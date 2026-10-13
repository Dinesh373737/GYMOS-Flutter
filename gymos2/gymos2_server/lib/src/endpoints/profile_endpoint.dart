import 'dart:math';

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

import '../services/access.dart';

import '../seed/seed_service.dart';

class ProfileEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<UserProfile?> getMe(Session s) async => UserProfile.db.findFirstRow(
    s,
    where: (t) => t.authUserId.equals(Access.authId(s)),
  );

  Future<UserProfile> completeOnboarding(
    Session s,
    String name,
    String inviteCode,
    bool createDemo,
    String experience,
    String goal,
    int duration,
  ) async {
    final id = Access.authId(s);
    if (!['beginner', 'intermediate', 'advanced'].contains(experience) ||
        ![
          'strength',
          'endurance',
          'mobility',
          'general fitness',
          'consistency',
        ].contains(goal) ||
        duration < 10 ||
        duration > 90) {
      throw GymException(message: 'Check your training preferences.');
    }

    await SeedService.catalog(s);

    return s.db.transaction((tx) async {
      await s.db.unsafeQuery(
        'SELECT pg_advisory_xact_lock(hashtextextended(@authId, 0))',
        parameters: QueryParameters.named({'authId': id}),
        transaction: tx,
      );
      final existing = await UserProfile.db.findFirstRow(
        s,
        where: (t) => t.authUserId.equals(id),
        transaction: tx,
      );
      if (existing != null) return existing;

      Society? society;

      if (createDemo) {
        society = await Society.db.insertRow(
          s,
          Society(
            name: 'Demo community',
            addressLabel: 'Bengaluru • demo location',
            inviteCode:
                'GYM-${DateTime.now().millisecondsSinceEpoch}-${Random.secure().nextInt(9999)}',
            createdBy: id,
            createdAt: DateTime.now().toUtc(),
            isActive: true,
          ),
          transaction: tx,
        );
        await SeedService.inventory(s, society.id!, transaction: tx);
      } else {
        society = await Society.db.findFirstRow(
          s,
          where: (t) =>
              t.inviteCode.equals(inviteCode.trim()) & t.isActive.equals(true),
          transaction: tx,
        );
      }

      if (society == null) {
        throw GymException(message: 'That invite code was not found.');
      }

      final now = DateTime.now().toUtc();
      final role = createDemo ? 'admin' : 'resident';

      final p = await UserProfile.db.insertRow(
        s,
        UserProfile(
          authUserId: id,
          displayName: Access.text(name, max: 60),
          role: role,
          societyId: society.id!,
          experienceLevel: experience,
          primaryGoal: Access.text(goal, max: 40),
          preferredWorkoutDuration: duration,
          onboardingComplete: true,
          createdAt: now,
          updatedAt: now,
        ),
        transaction: tx,
      );

      await SocietyMembership.db.insertRow(
        s,
        SocietyMembership(
          societyId: society.id!,
          userId: p.id!,
          role: role,
          joinedAt: now,
          isActive: true,
        ),
        transaction: tx,
      );

      if (createDemo) {
        for (var i = 0; i < 3; i++) {
          final start = DateTime.utc(now.year, now.month, now.day + 2 + i, 1);
          await CommunityEvent.db.insertRow(
            s,
            CommunityEvent(
              societyId: society.id!,
              organizerUserId: p.id!,
              title: [
                'Sunrise run',
                'Weekend mobility',
                'Community strength',
              ][i],
              description:
                  'Demonstration event created with your demo society. Not a real scheduled activity.',
              category: ['running', 'yoga', 'fitness'][i],
              startsAt: start,
              endsAt: start.add(const Duration(hours: 1)),
              latitude: 12.9716 + i * .008,
              longitude: 77.5946 + i * .006,
              venueLabel: 'Demo community park',
              capacity: 20,
              status: 'scheduled',
              isDemo: true,
            ),
            transaction: tx,
          );
        }
      }

      return p;
    });
  }

  Future<UserProfile> updatePreferences(
    Session s,
    String name,
    String experience,
    String goal,
    int duration,
  ) async {
    final p = await Access.profile(s);
    if (duration < 10 ||
        duration > 90 ||
        ![
          'strength',
          'endurance',
          'mobility',
          'general fitness',
          'consistency',
        ].contains(goal) ||
        !['beginner', 'intermediate', 'advanced'].contains(experience)) {
      throw GymException(message: 'Invalid preferences.');
    }

    p
      ..displayName = Access.text(name, max: 60)
      ..experienceLevel = experience
      ..primaryGoal = Access.text(goal, max: 40)
      ..preferredWorkoutDuration = duration
      ..updatedAt = DateTime.now().toUtc();
    return UserProfile.db.updateRow(s, p);
  }

  Future<Society> getSociety(Session s) async {
    final p = await Access.profile(s);
    return (await Society.db.findById(s, p.societyId))!;
  }

  Future<List<UserProfile>> getMembers(Session s) async {
    final p = await Access.profile(s, admin: true);
    return UserProfile.db.find(
      s,
      where: (t) => t.societyId.equals(p.societyId),
    );
  }
}
