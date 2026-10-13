import 'package:serverpod/serverpod.dart';

import '../../generated/protocol.dart';

import 'planner.dart';

class WorkoutService {
  static Future<WorkoutPlan> ownedPlan(
    Session s,
    int id,
    UserProfile p, {
    Transaction? transaction,
    LockMode? lockMode,
  }) async {
    final plan = await WorkoutPlan.db.findById(
      s,
      id,
      transaction: transaction,
      lockMode: lockMode,
    );
    if (plan == null || plan.userId != p.id) {
      throw GymException(message: 'Workout not found.');
    }
    return plan;
  }

  static Future<WorkoutSession> ownedSession(
    Session s,
    int id,
    UserProfile p, {
    Transaction? transaction,
    LockMode? lockMode,
  }) async {
    final x = await WorkoutSession.db.findById(
      s,
      id,
      transaction: transaction,
      lockMode: lockMode,
    );
    if (x == null || x.userId != p.id) {
      throw GymException(message: 'Session not found.');
    }
    return x;
  }

  static Future<List<TrainingReadiness>> readiness(
    Session s,
    UserProfile p,
  ) async {
    final now = DateTime.now().toUtc();
    final sessions = await WorkoutSession.db.find(
      s,
      where: (t) =>
          t.userId.equals(p.id!) &
          (t.startedAt > now.subtract(const Duration(days: 14))),
    );

    final links = await ExerciseMuscle.db.find(s);
    final groups = await MuscleGroup.db.find(s);
    final loads = <int, double>{};
    final last = <int, DateTime>{};

    for (final session in sessions) {
      for (final set in await WorkoutSet.db.find(
        s,
        where: (t) => t.sessionId.equals(session.id!),
      )) {
        for (final link in links.where((x) => x.exerciseId == set.exerciseId)) {
          final dose =
              Planner.setLoad(
                reps: set.reps,
                weightKg: set.weightKg,
                durationSec: set.durationSec,
                rpe: set.rpe ?? session.perceivedEffort ?? 6,
              ) *
              link.contribution;
          loads.update(
            link.muscleGroupId,
            (v) =>
                v + Planner.decayedLoad(dose, now.difference(set.completedAt)),
            ifAbsent: () =>
                Planner.decayedLoad(dose, now.difference(set.completedAt)),
          );
          if (last[link.muscleGroupId] == null ||
              last[link.muscleGroupId]!.isBefore(set.completedAt)) {
            last[link.muscleGroupId] = set.completedAt;
          }
        }
      }
    }

    return [
      for (final g in groups)
        TrainingReadiness(
          userId: p.id!,
          muscleGroupId: g.id!,
          muscleName: g.name,
          trainingLoadScore: loads[g.id] ?? 0,
          readinessBand: Planner.band(loads[g.id] ?? 0),
          lastTrainedAt: last[g.id],
          computedAt: now,
          explanation: last[g.id] == null
              ? 'No sets logged for this muscle in the last 14 days.'
              : 'Training-load estimate from logged reps, weight, duration, effort and time; not a medical or recovery measurement.',
        ),
    ];
  }

  /// Daily training-load estimates for the last [days] days, using the same
  /// decay model as [readiness]. Day boundaries follow the caller's offset.
  static Future<List<ReadinessPoint>> readinessTrend(
    Session s,
    UserProfile p, {
    int days = 14,
    int utcOffsetMinutes = 0,
  }) async {
    final offset = Duration(
      minutes: utcOffsetMinutes.clamp(-14 * 60, 14 * 60),
    );
    final now = DateTime.now().toUtc();
    final local = now.add(offset);
    final today = DateTime.utc(local.year, local.month, local.day);
    final from = today.subtract(Duration(days: days + 14)).subtract(offset);

    final sessions = await WorkoutSession.db.find(
      s,
      where: (t) => t.userId.equals(p.id!) & (t.startedAt > from),
    );
    final ids = sessions.map((x) => x.id!).toSet();
    final sets = ids.isEmpty
        ? <WorkoutSet>[]
        : await WorkoutSet.db.find(s, where: (t) => t.sessionId.inSet(ids));
    final effort = {for (final x in sessions) x.id!: x.perceivedEffort};
    final links = <int, List<ExerciseMuscle>>{};
    for (final l in await ExerciseMuscle.db.find(s)) {
      links.putIfAbsent(l.exerciseId, () => []).add(l);
    }

    ReadinessPoint point(int daysAgo) {
      final dayStart = today.subtract(Duration(days: daysAgo)).subtract(offset);
      final dayEnd = dayStart.add(const Duration(days: 1));
      final asOf = daysAgo == 0 ? now : dayEnd;
      final loads = <int, double>{};
      for (final set in sets) {
        final elapsed = asOf.difference(set.completedAt);
        if (elapsed.isNegative || elapsed.inDays >= 14) continue;
        final dose = Planner.setLoad(
          reps: set.reps,
          weightKg: set.weightKg,
          durationSec: set.durationSec,
          rpe: set.rpe ?? effort[set.sessionId] ?? 6,
        );
        for (final l in links[set.exerciseId] ?? const <ExerciseMuscle>[]) {
          final value = Planner.decayedLoad(dose * l.contribution, elapsed);
          loads.update(
            l.muscleGroupId,
            (v) => v + value,
            ifAbsent: () => value,
          );
        }
      }
      final bands = loads.values.map(Planner.band).toList();
      return ReadinessPoint(
        day: today.subtract(Duration(days: daysAgo)),
        totalLoad: loads.values.fold<double>(0, (a, b) => a + b),
        highCount: bands.where((b) => b == 'HIGH RECENT LOAD').length,
        moderateCount: bands.where((b) => b == 'MODERATE LOAD').length,
        sessions: sessions
            .where(
              (x) =>
                  x.endedAt != null &&
                  !x.startedAt.isBefore(dayStart) &&
                  x.startedAt.isBefore(dayEnd),
            )
            .length,
      );
    }

    return [for (var i = days - 1; i >= 0; i--) point(i)];
  }

  /// Stores the current estimate so other services can read it without
  /// recomputing. The table keeps one row per user and muscle group.
  static Future<void> persistReadiness(Session s, UserProfile p) async {
    final current = await readiness(s, p);
    final existing = {
      for (final r in await TrainingReadiness.db.find(
        s,
        where: (t) => t.userId.equals(p.id!),
      ))
        r.muscleGroupId: r,
    };
    for (final r in current) {
      final old = existing[r.muscleGroupId];
      if (old == null) {
        await TrainingReadiness.db.insertRow(s, r);
      } else {
        await TrainingReadiness.db.updateRow(s, r..id = old.id);
      }
    }
  }

  /// Sets from the latest finished session (other than [excludeSessionId])
  /// for each of [exerciseIds], used as the "last time" reference.
  static Future<List<WorkoutSet>> previousSets(
    Session s,
    UserProfile p,
    Set<int> exerciseIds, {
    int? excludeSessionId,
  }) async {
    if (exerciseIds.isEmpty) return [];
    final sessions = await WorkoutSession.db.find(
      s,
      where: (t) =>
          t.userId.equals(p.id!) &
          t.endedAt.notEquals(null) &
          t.id.notEquals(excludeSessionId),
      orderBy: (t) => t.startedAt.desc(),
      limit: 30,
    );
    if (sessions.isEmpty) return [];
    final rank = {
      for (var i = 0; i < sessions.length; i++) sessions[i].id!: i,
    };
    final sets = await WorkoutSet.db.find(
      s,
      where: (t) =>
          t.sessionId.inSet(rank.keys.toSet()) &
          t.exerciseId.inSet(exerciseIds),
    );
    final latest = <int, int>{};
    for (final set in sets) {
      final r = rank[set.sessionId]!;
      final best = latest[set.exerciseId];
      if (best == null || r < best) latest[set.exerciseId] = r;
    }
    return sets.where((x) => rank[x.sessionId] == latest[x.exerciseId]).toList()
      ..sort((a, b) => a.setNumber.compareTo(b.setNumber));
  }

  static Future<List<Exercise>> eligible(
    Session s,
    UserProfile p, {
    String focus = 'full body',
  }) async {
    final equipment = await SocietyEquipment.db.find(
      s,
      where: (t) =>
          t.societyId.equals(p.societyId) &
          t.status.equals('available') &
          (t.quantity > 0),
    );

    return Planner.select(
      exercises: await Exercise.db.find(s),
      availableEquipment: equipment.map((e) => e.equipmentId).toSet(),
      requirements: await ExerciseEquipment.db.find(s),
      minutes: 10000,
      experience: p.experienceLevel,
      focus: focus,
      highLoadExercises: {},
    );
  }

  static Future<PlanDetail> generate(
    Session s,
    UserProfile p,
    int minutes,
    String focus, {
    String creator = 'user',
  }) async {
    if (minutes < 10 ||
        minutes > 90 ||
        ![
          'full body',
          'push',
          'pull',
          'squat',
          'hinge',
          'core',
          'cardio',
        ].contains(focus)) {
      throw GymException(
        message: 'Choose 10–90 minutes and a supported focus.',
      );
    }

    final equipment = await SocietyEquipment.db.find(
      s,
      where: (t) =>
          t.societyId.equals(p.societyId) &
          t.status.equals('available') &
          (t.quantity > 0),
    );

    final load = await readiness(s, p);
    final high = load
        .where((r) => r.readinessBand == 'HIGH RECENT LOAD')
        .map((r) => r.muscleGroupId)
        .toSet();

    final links = await ExerciseMuscle.db.find(s);
    final highExercises = links
        .where((l) => high.contains(l.muscleGroupId) && l.contribution >= 1)
        .map((l) => l.exerciseId)
        .toSet();

    final history = await WorkoutSession.db.find(
      s,
      where: (t) => t.userId.equals(p.id!),
      orderBy: (t) => t.startedAt.desc(),
      limit: 5,
    );
    final counts = <int, int>{};
    final skipped = <int, int>{};

    for (final h in history) {
      final logged = <int>{};
      for (final set in await WorkoutSet.db.find(
        s,
        where: (t) => t.sessionId.equals(h.id!),
      )) {
        counts.update(set.exerciseId, (v) => v + 1, ifAbsent: () => 1);
        logged.add(set.exerciseId);
      }
      // A planned exercise with no logged sets in a finished session counts
      // as skipped, which lowers its rank in later plans.
      if (h.endedAt == null) continue;
      for (final item in await WorkoutPlanItem.db.find(
        s,
        where: (t) => t.planId.equals(h.planId),
      )) {
        if (!logged.contains(item.exerciseId)) {
          skipped.update(item.exerciseId, (v) => v + 1, ifAbsent: () => 1);
        }
      }
    }

    final forms = await FormAnalysis.db.find(
      s,
      where: (t) =>
          t.userId.equals(p.id!) & t.resultBand.equals('needs attention'),
    );

    final picked = Planner.select(
      exercises: await Exercise.db.find(s),
      availableEquipment: equipment.map((e) => e.equipmentId).toSet(),
      requirements: await ExerciseEquipment.db.find(s),
      minutes: minutes,
      experience: p.experienceLevel,
      focus: focus,
      goal: p.primaryGoal,
      highLoadExercises: highExercises,
      recentCounts: counts,
      techniqueExercises: forms.map((f) => f.exerciseId).toSet(),
      skippedCounts: skipped,
    );

    if (picked.isEmpty) {
      throw GymException(
        message:
            'No eligible exercises for these preferences. Try a different focus.',
      );
    }

    return s.db.transaction((tx) async {
      final plan = await WorkoutPlan.db.insertRow(
        s,
        WorkoutPlan(
          userId: p.id!,
          title:
              '${focus == 'full body' ? 'Full body' : focus[0].toUpperCase() + focus.substring(1)} / ${picked.fold<int>(0, (n, e) => n + e.defaultDurationMin)} min',
          createdByType: creator,
          target: focus,
          plannedDurationMin: picked.fold<int>(
            0,
            (n, e) => n + e.defaultDurationMin,
          ),
          createdAt: DateTime.now().toUtc(),
          status: 'draft',
        ),
        transaction: tx,
      );

      for (var i = 0; i < picked.length; i++) {
        final e = picked[i];
        await WorkoutPlanItem.db.insertRow(
          s,
          WorkoutPlanItem(
            planId: plan.id!,
            exerciseId: e.id!,
            orderIndex: i,
            targetSets: Planner.targetSets(e, p.primaryGoal),
            targetRepsText: Planner.targetReps(e, p.primaryGoal),
            restSeconds: p.primaryGoal == 'strength' ? 90 : 60,
            rationale:
                'Fits your ${p.experienceLevel} level, ${p.primaryGoal} goal and available equipment.${counts[e.id] == null ? ' Adds variety to your recent sessions.' : ''}${forms.any((f) => f.exerciseId == e.id) ? ' Practice the recent technique cue with a comfortable load.' : ''}${(skipped[e.id] ?? 0) > 0 ? ' Skipped recently, so it ranks lower; swap it if it still does not suit you.' : ''}',
          ),
          transaction: tx,
        );
      }

      return detail(s, plan.id!, p, transaction: tx);
    });
  }

  static Future<PlanDetail> detail(
    Session s,
    int id,
    UserProfile p, {
    Transaction? transaction,
  }) async {
    final plan = await ownedPlan(s, id, p, transaction: transaction);
    final items = await WorkoutPlanItem.db.find(
      s,
      where: (t) => t.planId.equals(id),
      orderBy: (t) => t.orderIndex,
      transaction: transaction,
    );
    final exercises = <Exercise>[];
    for (final i in items) {
      final e = await Exercise.db.findById(
        s,
        i.exerciseId,
        transaction: transaction,
      );
      if (e != null) exercises.add(e);
    }
    return PlanDetail(plan: plan, items: items, exercises: exercises);
  }

  static Future<PlanDetail> replace(
    Session s,
    UserProfile p,
    int planId,
    int itemId,
    int exerciseId,
  ) async {
    return s.db.transaction((tx) async {
      final plan = await ownedPlan(
        s,
        planId,
        p,
        transaction: tx,
        lockMode: LockMode.forUpdate,
      );
      if (plan.status != 'draft' && plan.status != 'active') {
        throw GymException(message: 'Finished plans cannot be changed.');
      }

      final item = await WorkoutPlanItem.db.findById(
        s,
        itemId,
        transaction: tx,
      );
      if (item == null || item.planId != planId) {
        throw GymException(message: 'Plan item not found.');
      }

      if (plan.status == 'active') {
        final session = await WorkoutSession.db.findFirstRow(
          s,
          where: (t) =>
              t.userId.equals(p.id!) &
              t.planId.equals(planId) &
              t.endedAt.equals(null),
          transaction: tx,
        );
        if (session != null &&
            await WorkoutSet.db.count(
                  s,
                  where: (t) =>
                      t.sessionId.equals(session.id!) &
                      t.exerciseId.equals(item.exerciseId),
                  transaction: tx,
                ) >
                0) {
          throw GymException(
            message: 'Remove the logged sets before swapping this exercise.',
          );
        }
      }

      final source = (await Exercise.db.findById(s, item.exerciseId))!;
      final options = await eligible(s, p, focus: source.movementPattern);
      final replacement = options.where((e) => e.id == exerciseId).firstOrNull;

      if (replacement == null) {
        throw GymException(message: 'That alternative is not eligible.');
      }
      final duplicate = await WorkoutPlanItem.db.findFirstRow(
        s,
        where: (t) =>
            t.planId.equals(planId) &
            t.exerciseId.equals(exerciseId) &
            t.id.notEquals(itemId),
        transaction: tx,
      );
      if (duplicate != null) {
        throw GymException(message: 'That exercise is already in this plan.');
      }

      final newDuration =
          plan.plannedDurationMin -
          source.defaultDurationMin +
          replacement.defaultDurationMin;

      if (newDuration > plan.plannedDurationMin) {
        throw GymException(
          message: 'Choose an alternative that fits the remaining time.',
        );
      }

      item
        ..exerciseId = exerciseId
        ..rationale =
            'Replaced at your request with an eligible ${replacement.movementPattern} exercise that uses available equipment.';
      await WorkoutPlanItem.db.updateRow(s, item, transaction: tx);
      plan.plannedDurationMin = newDuration;
      await WorkoutPlan.db.updateRow(s, plan, transaction: tx);
      return detail(s, planId, p, transaction: tx);
    });
  }
}
