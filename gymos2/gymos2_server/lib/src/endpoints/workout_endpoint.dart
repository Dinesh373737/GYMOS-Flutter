import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

import '../services/access.dart';

import '../services/workout/workout_service.dart';

class WorkoutEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<PlanDetail> generate(Session s, int minutes, String focus) async =>
      WorkoutService.generate(s, await Access.profile(s), minutes, focus);

  Future<PlanDetail> getPlan(Session s, int id) async =>
      WorkoutService.detail(s, id, await Access.profile(s));

  Future<List<WorkoutPlan>> plans(Session s) async {
    final p = await Access.profile(s);
    return WorkoutPlan.db.find(
      s,
      where: (t) => t.userId.equals(p.id!),
      orderBy: (t) => t.createdAt.desc(),
      limit: 20,
    );
  }

  Future<List<Exercise>> alternatives(Session s, int exerciseId) async {
    final p = await Access.profile(s);
    final e = await Exercise.db.findById(s, exerciseId);
    if (e == null) return [];
    return (await WorkoutService.eligible(s, p, focus: e.movementPattern))
        .where(
          (x) => x.id != e.id && x.defaultDurationMin <= e.defaultDurationMin,
        )
        .toList();
  }

  Future<PlanDetail> replace(
    Session s,
    int planId,
    int itemId,
    int exerciseId,
  ) async => WorkoutService.replace(
    s,
    await Access.profile(s),
    planId,
    itemId,
    exerciseId,
  );

  Future<WorkoutSession> start(Session s, int planId) async {
    final p = await Access.profile(s);
    return s.db.transaction((tx) async {
      final plan = await WorkoutService.ownedPlan(
        s,
        planId,
        p,
        transaction: tx,
        lockMode: LockMode.forUpdate,
      );

      final existing = await WorkoutSession.db.findFirstRow(
        s,
        where: (t) =>
            t.userId.equals(p.id!) &
            t.planId.equals(planId) &
            t.endedAt.equals(null),
        transaction: tx,
      );
      if (existing != null) return existing;

      if (plan.status == 'completed') {
        throw GymException(
          message: 'Generate a new plan for your next workout.',
        );
      }

      final allowed = (await WorkoutService.eligible(
        s,
        p,
      )).map((e) => e.id).toSet();
      final items = await WorkoutPlanItem.db.find(
        s,
        where: (t) => t.planId.equals(planId),
        transaction: tx,
      );
      if (items.any((i) => !allowed.contains(i.exerciseId))) {
        throw GymException(
          message:
              'Equipment availability changed. Replace unavailable exercises before starting.',
        );
      }

      plan.status = 'active';
      await WorkoutPlan.db.updateRow(s, plan, transaction: tx);

      return WorkoutSession.db.insertRow(
        s,
        WorkoutSession(
          userId: p.id!,
          planId: planId,
          title: plan.title,
          startedAt: DateTime.now().toUtc(),
          notes: '',
        ),
        transaction: tx,
      );
    });
  }

  Future<WorkoutSet> logSet(
    Session s,
    int sessionId,
    int exerciseId,
    int setNumber,
    int? reps,
    double? weightKg,
    int? durationSec,
    double? rpe,
  ) async {
    final p = await Access.profile(s);
    return s.db.transaction((tx) async {
      final session = await WorkoutService.ownedSession(
        s,
        sessionId,
        p,
        transaction: tx,
        lockMode: LockMode.forUpdate,
      );

      if (session.endedAt != null) {
        throw GymException(message: 'This session is already finished.');
      }

      if (setNumber < 1 ||
          setNumber > 100 ||
          (reps == null && durationSec == null) ||
          (reps != null && (reps < 1 || reps > 1000)) ||
          (weightKg != null &&
              (!weightKg.isFinite || weightKg < 0 || weightKg > 1000)) ||
          (durationSec != null && (durationSec < 1 || durationSec > 7200)) ||
          (rpe != null && (!rpe.isFinite || rpe < 1 || rpe > 10))) {
        throw GymException(message: 'Check the set values.');
      }

      final item = await WorkoutPlanItem.db.findFirstRow(
        s,
        where: (t) =>
            t.planId.equals(session.planId) & t.exerciseId.equals(exerciseId),
        transaction: tx,
      );
      if (item == null) {
        throw GymException(message: 'Exercise is not in this session.');
      }

      final old = await WorkoutSet.db.findFirstRow(
        s,
        where: (t) =>
            t.sessionId.equals(sessionId) &
            t.exerciseId.equals(exerciseId) &
            t.setNumber.equals(setNumber),
        transaction: tx,
      );

      final row = WorkoutSet(
        id: old?.id,
        sessionId: sessionId,
        exerciseId: exerciseId,
        setNumber: setNumber,
        reps: reps,
        weightKg: weightKg,
        durationSec: durationSec,
        rpe: rpe,
        completedAt: DateTime.now().toUtc(),
      );

      return old == null
          ? WorkoutSet.db.insertRow(s, row, transaction: tx)
          : WorkoutSet.db.updateRow(s, row, transaction: tx);
    });
  }

  Future<void> deleteSet(Session s, int setId) async {
    final p = await Access.profile(s);
    final set = await WorkoutSet.db.findById(s, setId);
    if (set == null) return;
    await s.db.transaction((tx) async {
      final session = await WorkoutService.ownedSession(
        s,
        set.sessionId,
        p,
        transaction: tx,
        lockMode: LockMode.forUpdate,
      );
      if (session.endedAt != null) {
        throw GymException(message: 'Finished sessions are read-only.');
      }
      await WorkoutSet.db.deleteRow(s, set, transaction: tx);
    });
  }

  Future<SessionDetail> finish(
    Session s,
    int id,
    String notes,
    double effort,
  ) async {
    final p = await Access.profile(s);
    if (!effort.isFinite || effort < 1 || effort > 10 || notes.length > 1000) {
      throw GymException(message: 'Check effort and notes.');
    }
    await s.db.transaction((tx) async {
      final x = await WorkoutService.ownedSession(
        s,
        id,
        p,
        transaction: tx,
        lockMode: LockMode.forUpdate,
      );
      if (x.endedAt == null) {
        x
          ..endedAt = DateTime.now().toUtc()
          ..durationMin = DateTime.now()
              .toUtc()
              .difference(x.startedAt)
              .inMinutes
          ..notes = notes.trim()
          ..perceivedEffort = effort;
        await WorkoutSession.db.updateRow(s, x, transaction: tx);
        final plan = await WorkoutService.ownedPlan(
          s,
          x.planId,
          p,
          transaction: tx,
        );
        plan.status = 'completed';
        await WorkoutPlan.db.updateRow(s, plan, transaction: tx);
      }
    });
    await WorkoutService.persistReadiness(s, p);
    return detail(s, id);
  }

  Future<List<WorkoutSession>> history(Session s) async {
    final p = await Access.profile(s);
    return WorkoutSession.db.find(
      s,
      where: (t) => t.userId.equals(p.id!),
      orderBy: (t) => t.startedAt.desc(),
      limit: 100,
    );
  }

  Future<SessionDetail> detail(Session s, int id) async {
    final p = await Access.profile(s);
    final x = await WorkoutService.ownedSession(s, id, p);
    final plan = await WorkoutService.detail(s, x.planId, p);
    return SessionDetail(
      session: x,
      sets: await WorkoutSet.db.find(
        s,
        where: (t) => t.sessionId.equals(id),
        orderBy: (t) => t.completedAt,
      ),
      plan: plan,
      previousSets: await WorkoutService.previousSets(
        s,
        p,
        plan.items.map((i) => i.exerciseId).toSet(),
        excludeSessionId: id,
      ),
    );
  }

  Future<List<TrainingReadiness>> readiness(Session s) async =>
      WorkoutService.readiness(s, await Access.profile(s));

  /// Exercises the caller has logged in finished sessions, for trend pickers.
  Future<List<Exercise>> loggedExercises(Session s) async {
    final p = await Access.profile(s);
    final ids = (await _finishedSessions(s, p)).map((x) => x.id!).toSet();
    if (ids.isEmpty) return [];
    final exerciseIds = (await WorkoutSet.db.find(
      s,
      where: (t) => t.sessionId.inSet(ids),
    )).map((x) => x.exerciseId).toSet();
    if (exerciseIds.isEmpty) return [];
    return Exercise.db.find(
      s,
      where: (t) => t.id.inSet(exerciseIds),
      orderBy: (t) => t.name,
    );
  }

  /// Per-session top weight, volume and reps for one exercise, oldest first.
  Future<List<ExercisePoint>> exerciseTrend(Session s, int exerciseId) async {
    final p = await Access.profile(s);
    final sessions = await _finishedSessions(s, p);
    if (sessions.isEmpty) return [];
    final sets = await WorkoutSet.db.find(
      s,
      where: (t) =>
          t.sessionId.inSet(sessions.map((x) => x.id!).toSet()) &
          t.exerciseId.equals(exerciseId),
    );
    return [
      for (final x in sessions.reversed)
        if (sets.where((set) => set.sessionId == x.id).toList() case final own
            when own.isNotEmpty)
          ExercisePoint(
            sessionId: x.id!,
            day: x.startedAt,
            topWeightKg: own.fold<double>(
              0,
              (m, set) => (set.weightKg ?? 0) > m ? set.weightKg! : m,
            ),
            volumeKg: own.fold<double>(
              0,
              (v, set) => v + (set.reps ?? 0) * (set.weightKg ?? 0),
            ),
            totalReps: own.fold<int>(0, (n, set) => n + (set.reps ?? 0)),
            sets: own.length,
          ),
    ];
  }

  static Future<List<WorkoutSession>> _finishedSessions(
    Session s,
    UserProfile p,
  ) => WorkoutSession.db.find(
    s,
    where: (t) => t.userId.equals(p.id!) & t.endedAt.notEquals(null),
    orderBy: (t) => t.startedAt.desc(),
    limit: 200,
  );

  Future<List<ReadinessPoint>> readinessTrend(
    Session s,
    int days,
    int utcOffsetMinutes,
  ) async => WorkoutService.readinessTrend(
    s,
    await Access.profile(s),
    days: days.clamp(7, 60),
    utcOffsetMinutes: utcOffsetMinutes,
  );
}
