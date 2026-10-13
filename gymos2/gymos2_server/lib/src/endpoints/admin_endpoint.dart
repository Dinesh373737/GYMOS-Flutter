import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

import '../services/access.dart';

import '../services/notifications.dart';

/// Society administration. Every method is scoped to the caller's own society
/// and requires an active admin membership. Admins see aggregate activity
/// only, never members' private workout or form records.
class AdminEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<AdminStats> stats(Session s) async {
    final p = await Access.profile(s, admin: true);
    final society = p.societyId;
    final now = DateTime.now().toUtc();

    final memberships = await SocietyMembership.db.find(
      s,
      where: (t) => t.societyId.equals(society),
    );
    final equipment = await SocietyEquipment.db.find(
      s,
      where: (t) => t.societyId.equals(society),
    );
    final issues = await MaintenanceIssue.db.find(
      s,
      where: (t) => t.societyId.equals(society),
    );
    final events = await CommunityEvent.db.find(
      s,
      where: (t) =>
          t.societyId.equals(society) &
          t.status.equals('scheduled') &
          (t.endsAt > now),
    );
    final participants = events.isEmpty
        ? 0
        : await EventParticipant.db.count(
            s,
            where: (t) =>
                t.eventId.inSet(events.map((e) => e.id!).toSet()) &
                t.status.equals('joined'),
          );

    final members = memberships.map((m) => m.userId).toSet();
    final since = DateTime.utc(
      now.year,
      now.month,
      now.day,
    ).subtract(const Duration(days: 13));
    final sessions = members.isEmpty
        ? <WorkoutSession>[]
        : await WorkoutSession.db.find(
            s,
            where: (t) =>
                t.userId.inSet(members) &
                (t.startedAt >= since) &
                t.endedAt.notEquals(null),
          );
    final weekStart = now.subtract(const Duration(days: 7));
    final week = sessions.where((x) => x.startedAt.isAfter(weekStart));
    final daily = List.filled(14, 0);
    for (final x in sessions) {
      final day = x.startedAt.difference(since).inDays;
      if (day >= 0 && day < 14) daily[day]++;
    }

    return AdminStats(
      society: (await Society.db.findById(s, society))!,
      memberCount: memberships.length,
      activeMembers: memberships.where((m) => m.isActive).length,
      adminCount: memberships
          .where((m) => m.isActive && m.role == 'admin')
          .length,
      equipmentTotal: equipment.length,
      equipmentAvailable: equipment
          .where((e) => e.status == 'available')
          .length,
      equipmentMaintenance: equipment
          .where((e) => e.status == 'maintenance')
          .length,
      equipmentUnavailable: equipment
          .where((e) => e.status == 'unavailable')
          .length,
      openIssues: issues.where((i) => i.status == 'open').length,
      inProgressIssues: issues.where((i) => i.status == 'in progress').length,
      resolvedIssues30d: issues
          .where(
            (i) =>
                i.status == 'resolved' &&
                (i.resolvedAt?.isAfter(
                      now.subtract(const Duration(days: 30)),
                    ) ??
                    false),
          )
          .length,
      highSeverityOpen: issues
          .where((i) => i.status != 'resolved' && i.severity == 'high')
          .length,
      upcomingEvents: events.length,
      eventParticipants: participants,
      workoutsThisWeek: week.length,
      activeTrainersThisWeek: week.map((x) => x.userId).toSet().length,
      dailyWorkouts: daily,
    );
  }

  Future<List<MemberSummary>> members(Session s) async {
    final p = await Access.profile(s, admin: true);
    return _members(s, p.societyId);
  }

  Future<MemberSummary> updateMember(
    Session s,
    int profileId,
    String role,
    bool active,
  ) async {
    final p = await Access.profile(s, admin: true);
    if (!['admin', 'resident'].contains(role)) {
      throw GymException(message: 'Choose admin or resident.');
    }

    await s.db.transaction((tx) async {
      final m = await SocietyMembership.db.findFirstRow(
        s,
        where: (t) =>
            t.societyId.equals(p.societyId) & t.userId.equals(profileId),
        transaction: tx,
        lockMode: LockMode.forUpdate,
      );
      if (m == null) throw GymException(message: 'Member not found.');

      final losesAdmin =
          m.role == 'admin' && m.isActive && (role != 'admin' || !active);
      if (losesAdmin) {
        final admins = await SocietyMembership.db.count(
          s,
          where: (t) =>
              t.societyId.equals(p.societyId) &
              t.role.equals('admin') &
              t.isActive.equals(true),
          transaction: tx,
        );
        if (admins <= 1) {
          throw GymException(
            message: 'A society needs at least one active admin.',
          );
        }
      }

      final changed = m.role != role || m.isActive != active;
      m
        ..role = role
        ..isActive = active;
      await SocietyMembership.db.updateRow(s, m, transaction: tx);

      final profile = await UserProfile.db.findById(
        s,
        profileId,
        transaction: tx,
      );
      if (profile != null && profile.role != role) {
        profile
          ..role = role
          ..updatedAt = DateTime.now().toUtc();
        await UserProfile.db.updateRow(s, profile, transaction: tx);
      }

      if (changed && profileId != p.id) {
        await Notifications.send(
          s,
          profileId,
          'membership',
          active ? 'Your membership was updated' : 'Membership paused',
          active
              ? 'You are now ${role == 'admin' ? 'an admin' : 'a resident'} of your community.'
              : 'An admin paused your community membership.',
          link: '/profile',
          transaction: tx,
        );
      }
    });

    return (await _members(
      s,
      p.societyId,
    )).firstWhere((m) => m.profileId == profileId);
  }

  static Future<List<MemberSummary>> _members(Session s, int societyId) async {
    final memberships = await SocietyMembership.db.find(
      s,
      where: (t) => t.societyId.equals(societyId),
      orderBy: (t) => t.joinedAt,
    );
    if (memberships.isEmpty) return [];
    final ids = memberships.map((m) => m.userId).toSet();
    final profiles = {
      for (final x in await UserProfile.db.find(
        s,
        where: (t) => t.id.inSet(ids),
      ))
        x.id!: x,
    };
    final since = DateTime.now().toUtc().subtract(const Duration(days: 30));
    final sessions = await WorkoutSession.db.find(
      s,
      where: (t) =>
          t.userId.inSet(ids) &
          (t.startedAt > since) &
          t.endedAt.notEquals(null),
    );
    return [
      for (final m in memberships)
        if (profiles[m.userId] case final profile?)
          MemberSummary(
            profileId: m.userId,
            displayName: profile.displayName,
            role: m.role,
            isActive: m.isActive,
            joinedAt: m.joinedAt,
            workoutsLast30Days: sessions
                .where((x) => x.userId == m.userId)
                .length,
          ),
    ];
  }
}
