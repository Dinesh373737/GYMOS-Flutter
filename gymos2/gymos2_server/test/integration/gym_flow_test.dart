import 'package:test/test.dart';
import 'package:gymos2_server/src/generated/protocol.dart';
import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('GymOS real database flow', (builder, endpoints) {
    final admin = builder.copyWith(
      authentication: AuthenticationOverride.authenticationInfo(
        'test-admin',
        {},
      ),
    );
    final resident = builder.copyWith(
      authentication: AuthenticationOverride.authenticationInfo(
        'test-resident',
        {},
      ),
    );
    final outsider = builder.copyWith(
      authentication: AuthenticationOverride.authenticationInfo(
        'test-outsider',
        {},
      ),
    );
    test(
      'onboarding, tenant authorization, plans, sets, load, events and maintenance',
      () async {
        final a = await endpoints.profile.completeOnboarding(
          admin,
          'Alex',
          '',
          true,
          'beginner',
          'strength',
          40,
        );
        final society = await endpoints.profile.getSociety(admin);
        final r = await endpoints.profile.completeOnboarding(
          resident,
          'Riley',
          society.inviteCode,
          false,
          'beginner',
          'strength',
          40,
        );
        final o = await endpoints.profile.completeOnboarding(
          outsider,
          'Other',
          '',
          true,
          'beginner',
          'strength',
          40,
        );
        expect(a.societyId, r.societyId);
        expect(o.societyId, isNot(a.societyId));
        final eq = await endpoints.equipment.list(resident);
        expect(eq, isNotEmpty);
        await expectLater(
          endpoints.equipment.save(
            resident,
            eq.first.id,
            eq.first.equipmentId,
            'Forbidden',
            1,
            'available',
            'Floor',
          ),
          throwsA(isA<GymException>()),
        );
        await expectLater(
          endpoints.equipment.report(
            outsider,
            eq.first.id!,
            'No access',
            'Cannot report another society',
            'high',
          ),
          throwsA(isA<GymException>()),
        );
        final plan = await endpoints.workout.generate(
          resident,
          40,
          'full body',
        );
        expect(plan.plan.plannedDurationMin, lessThanOrEqualTo(40));
        expect(plan.items, isNotEmpty);
        await expectLater(
          endpoints.workout.getPlan(outsider, plan.plan.id!),
          throwsA(isA<GymException>()),
        );
        final before = await endpoints.workout.readiness(resident);
        final session = await endpoints.workout.start(resident, plan.plan.id!);
        final set = await endpoints.workout.logSet(
          resident,
          session.id!,
          plan.items.first.exerciseId,
          1,
          10,
          12.0,
          null,
          7.0,
        );
        await endpoints.workout.logSet(
          resident,
          session.id!,
          plan.items.first.exerciseId,
          1,
          12,
          12.0,
          null,
          7.0,
        );
        final detail = await endpoints.workout.detail(resident, session.id!);
        expect(detail.sets.length, 1);
        expect(detail.sets.first.reps, 12);
        expect(detail.sets.first.id, set.id);
        await expectLater(
          endpoints.workout.detail(outsider, session.id!),
          throwsA(isA<GymException>()),
        );
        final finished = await endpoints.workout.finish(
          resident,
          session.id!,
          'Good session',
          7,
        );
        expect(finished.session.endedAt, isNotNull);
        final after = await endpoints.workout.readiness(resident);
        expect(
          after.fold<double>(0, (a, b) => a + b.trainingLoadScore),
          greaterThan(
            before.fold<double>(0, (a, b) => a + b.trainingLoadScore),
          ),
        );
        await expectLater(
          endpoints.workout.logSet(
            resident,
            session.id!,
            plan.items.first.exerciseId,
            2,
            10,
            12.0,
            null,
            7.0,
          ),
          throwsA(isA<GymException>()),
        );
        final events = await endpoints.event.discover(
          resident,
          'Bengaluru',
          'all',
        );
        expect(events.community, isNotEmpty);
        expect(events.community.every((e) => e.isDemo), true);
        expect(events.externalEvents, isEmpty);
        await endpoints.event.join(resident, events.community.first.id!, true);
        expect(
          await endpoints.event.participantCount(
            resident,
            events.community.first.id!,
          ),
          1,
        );
        await expectLater(
          endpoints.event.join(outsider, events.community.first.id!, true),
          throwsA(isA<GymException>()),
        );
        await endpoints.event.join(resident, events.community.first.id!, false);
        expect(
          await endpoints.event.participantCount(
            resident,
            events.community.first.id!,
          ),
          0,
        );
        final issue = await endpoints.equipment.report(
          resident,
          eq.first.id!,
          'Loose handle',
          'Please inspect handle',
          'medium',
        );
        await expectLater(
          endpoints.equipment.updateIssue(resident, issue.id!, 'resolved'),
          throwsA(isA<GymException>()),
        );
        await endpoints.equipment.updateIssue(admin, issue.id!, 'in progress');
        await endpoints.equipment.updateIssue(admin, issue.id!, 'resolved');
        final refreshed = await endpoints.equipment.list(resident);
        expect(
          refreshed.firstWhere((e) => e.id == eq.first.id).status,
          'available',
        );
        final dashboard = await endpoints.dashboard.getSummary(resident);
        expect(dashboard.completedSets, 1);
        expect(dashboard.volumeKg, 144);
      },
    );
  });
}
