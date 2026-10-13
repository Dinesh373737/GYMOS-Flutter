import 'package:gymos2_server/src/generated/protocol.dart';
import 'package:gymos2_server/src/services/events/event_cache_service.dart';
import 'package:gymos2_server/src/services/events/external_event_provider.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

class FakeProvider implements ExternalEventProvider {
  int calls = 0;
  bool fail = false;

  @override
  String get id => 'allevents';
  @override
  String get displayName => 'AllEvents';
  @override
  List<String> get supportedCities => const ['London', 'New York', 'Tokyo'];

  @override
  Future<List<ExternalEventListing>> search(
    String city, {
    DateTime? now,
  }) async {
    calls++;
    if (fail) {
      throw const ExternalProviderException('Provider is down.');
    }
    final start = DateTime.now().toUtc().add(const Duration(days: 3));
    return [
      ExternalEventListing(
        providerEventId: 'run-1',
        title: '$city Riverside 10K',
        category: 'running',
        startsAt: start,
        latitude: 51.5,
        longitude: -0.12,
        venueLabel: 'Riverside',
        sourceUrl: 'https://allevents.in/example/run-1',
        rawHash: 'a',
      ),
      ExternalEventListing(
        providerEventId: 'yoga-1',
        title: 'Park yoga',
        category: 'yoga',
        startsAt: start.add(const Duration(hours: 2)),
        sourceUrl: 'https://allevents.in/example/yoga-1',
        rawHash: 'b',
      ),
    ];
  }
}

void main() {
  withServerpod('Events, admin and notifications', (builder, endpoints) {
    final admin = builder.copyWith(
      authentication: AuthenticationOverride.authenticationInfo(
        'events-admin',
        {},
      ),
    );
    final resident = builder.copyWith(
      authentication: AuthenticationOverride.authenticationInfo(
        'events-resident',
        {},
      ),
    );
    late FakeProvider fake;

    setUp(() {
      EventCacheService.reset();
      fake = FakeProvider();
      EventCacheService.providerOverride = (_) => fake;
    });
    tearDown(() => EventCacheService.providerOverride = null);

    Future<(UserProfile, UserProfile)> onboard() async {
      final a = await endpoints.profile.completeOnboarding(
        admin,
        'Avery',
        '',
        true,
        'intermediate',
        'strength',
        40,
      );
      final society = await endpoints.profile.getSociety(admin);
      final r = await endpoints.profile.completeOnboarding(
        resident,
        'Robin',
        society.inviteCode,
        false,
        'beginner',
        'general fitness',
        30,
      );
      return (a, r);
    }

    test('external events refresh, cache, fall back and stay honest', () async {
      await onboard();

      final live = await endpoints.event.discover(resident, 'london', 'all');
      expect(live.providerState, 'live');
      expect(live.externalEvents, hasLength(2));
      expect(live.externalEvents.first.provider, 'allevents');
      expect(live.externalEvents.last.latitude, isNull);
      expect(live.community, hasLength(3));
      expect(live.participantCounts!.values, everyElement(0));
      expect(fake.calls, 1);

      final cached = await endpoints.event.discover(
        resident,
        'London',
        'yoga',
      );
      expect(cached.providerState, 'cached');
      expect(cached.externalEvents.single.title, 'Park yoga');
      expect(fake.calls, 1, reason: 'valid cache must not call the provider');

      // Expire the cache and break the provider: stale rows stay visible.
      final session = builder.build();
      final rows = await ExternalEventCache.db.find(session);
      await ExternalEventCache.db.update(session, [
        for (final r in rows)
          r
            ..expiresAt = DateTime.now().toUtc().subtract(
              const Duration(minutes: 1),
            ),
      ]);
      fake.fail = true;
      final stale = await endpoints.event.discover(resident, 'London', 'all');
      expect(stale.providerState, 'stale');
      expect(stale.externalEvents, hasLength(2));
      expect(stale.providerStatus, contains('Provider is down.'));
      expect(fake.calls, 2);

      // Back-off: an immediate retry does not hit the failing provider.
      await endpoints.event.discover(resident, 'London', 'all');
      expect(fake.calls, 2);

      final unsupported = await endpoints.event.discover(
        resident,
        'Pune',
        'all',
      );
      expect(unsupported.providerState, 'unsupported');
      expect(unsupported.externalEvents, isEmpty);
      expect(unsupported.supportedCities, contains('Tokyo'));

      EventCacheService.providerOverride = (_) => null;
      final off = await endpoints.event.discover(resident, 'London', 'all');
      expect(off.providerState, 'unconfigured');
      expect(off.community, isNotEmpty);
    });

    test('admin endpoints are scoped, guarded and notify members', () async {
      final (a, r) = await onboard();

      await expectLater(
        endpoints.admin.stats(resident),
        throwsA(isA<GymException>()),
      );
      await expectLater(
        endpoints.admin.updateMember(resident, r.id!, 'admin', true),
        throwsA(isA<GymException>()),
      );

      final stats = await endpoints.admin.stats(admin);
      expect(stats.memberCount, 2);
      expect(stats.adminCount, 1);
      expect(stats.equipmentTotal, 15);
      expect(stats.equipmentMaintenance, greaterThanOrEqualTo(1));
      expect(stats.upcomingEvents, 3);
      expect(stats.dailyWorkouts, hasLength(14));

      await expectLater(
        endpoints.admin.updateMember(admin, a.id!, 'resident', true),
        throwsA(
          isA<GymException>().having(
            (e) => e.message,
            'message',
            contains('at least one active admin'),
          ),
        ),
      );

      final promoted = await endpoints.admin.updateMember(
        admin,
        r.id!,
        'admin',
        true,
      );
      expect(promoted.role, 'admin');
      expect(await endpoints.notification.unreadCount(resident), 1);
      expect((await endpoints.admin.stats(resident)).adminCount, 2);

      await endpoints.admin.updateMember(admin, r.id!, 'resident', false);
      await expectLater(
        endpoints.workout.history(resident),
        throwsA(isA<GymException>()),
        reason: 'paused members lose access',
      );
      await endpoints.admin.updateMember(admin, r.id!, 'resident', true);
      await endpoints.notification.markAllRead(resident);
      expect(await endpoints.notification.unreadCount(resident), 0);
    });

    test('maintenance reports and resolutions notify the other side', () async {
      await onboard();
      final equipment = (await endpoints.equipment.list(resident)).first;
      final issue = await endpoints.equipment.report(
        resident,
        equipment.id!,
        'Loose pin',
        'The pin slips out.',
        'high',
      );
      final adminInbox = await endpoints.notification.list(admin);
      expect(adminInbox.single.title, contains(equipment.label));
      expect(adminInbox.single.body, contains('Robin'));

      await endpoints.equipment.updateIssue(admin, issue.id!, 'resolved');
      final residentInbox = await endpoints.notification.list(resident);
      expect(residentInbox.single.title, contains('fixed'));
      expect(residentInbox.single.link, '/equipment');
    });

    test('trend, previous sets and exercise trends use real history', () async {
      await onboard();
      Future<SessionDetail> train(int reps) async {
        final plan = await endpoints.workout.generate(resident, 30, 'push');
        final session = await endpoints.workout.start(
          resident,
          plan.plan.id!,
        );
        await endpoints.workout.logSet(
          resident,
          session.id!,
          plan.items.first.exerciseId,
          1,
          reps,
          20.0,
          null,
          7.0,
        );
        return endpoints.workout.finish(resident, session.id!, '', 7);
      }

      final empty = await endpoints.workout.readinessTrend(resident, 14, 0);
      expect(empty, hasLength(14));
      expect(empty.every((p) => p.totalLoad == 0), isTrue);

      final first = await train(10);
      final trend = await endpoints.workout.readinessTrend(resident, 14, 0);
      expect(trend.last.totalLoad, greaterThan(0));
      expect(trend.last.sessions, 1);

      final exerciseId = first.sets.single.exerciseId;
      final logged = await endpoints.workout.loggedExercises(resident);
      expect(logged.map((e) => e.id), contains(exerciseId));
      final points = await endpoints.workout.exerciseTrend(
        resident,
        exerciseId,
      );
      expect(points.single.topWeightKg, 20);
      expect(points.single.volumeKg, 200);

      // A later session that plans the same exercise sees the earlier sets.
      final plan = await endpoints.workout.generate(resident, 30, 'push');
      final next = await endpoints.workout.start(resident, plan.plan.id!);
      final detail = await endpoints.workout.detail(resident, next.id!);
      final previous = detail.previousSets!;
      if (plan.items.any((i) => i.exerciseId == exerciseId)) {
        expect(
          previous.where((s) => s.exerciseId == exerciseId).single.reps,
          10,
        );
      }
      expect(previous.every((s) => s.sessionId == first.session.id), isTrue);
    });
  });
}
