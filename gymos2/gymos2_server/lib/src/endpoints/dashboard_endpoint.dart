import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

import '../services/access.dart';

import '../services/workout/workout_service.dart';

class DashboardEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<DashboardData> getSummary(Session s) async {
    final p = await Access.profile(s);
    final history = await WorkoutSession.db.find(
      s,
      where: (t) => t.userId.equals(p.id!),
      orderBy: (t) => t.startedAt.desc(),
      limit: 100,
    );

    var count = 0;
    var volume = 0.0;
    for (final session in history) {
      final sets = await WorkoutSet.db.find(
        s,
        where: (t) => t.sessionId.equals(session.id!),
      );
      count += sets.length;
      volume += sets.fold<double>(
        0,
        (v, e) => v + (e.reps ?? 0) * (e.weightKg ?? 0),
      );
    }

    return DashboardData(
      profile: p,
      society: (await Society.db.findById(s, p.societyId))!,
      equipment: await SocietyEquipment.db.find(
        s,
        where: (t) => t.societyId.equals(p.societyId),
      ),
      readiness: await WorkoutService.readiness(s, p),
      recentSessions: history,
      events: await CommunityEvent.db.find(
        s,
        where: (t) =>
            t.societyId.equals(p.societyId) &
            (t.endsAt > DateTime.now().toUtc()),
        orderBy: (t) => t.startsAt,
        limit: 3,
      ),
      completedSets: count,
      volumeKg: volume,
    );
  }
}
