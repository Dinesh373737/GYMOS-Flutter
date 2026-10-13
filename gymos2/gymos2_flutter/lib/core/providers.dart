import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../client.dart';

final profileProvider = FutureProvider((ref) => client.profile.getMe());
final dashboardProvider = FutureProvider(
  (ref) => client.dashboard.getSummary(),
);
final equipmentProvider = FutureProvider((ref) => client.equipment.list());
final issuesProvider = FutureProvider((ref) => client.equipment.issues());
final exercisesProvider = FutureProvider((ref) => client.exercise.list(''));
final historyProvider = FutureProvider((ref) => client.workout.history());
final plansProvider = FutureProvider((ref) => client.workout.plans());
final readinessProvider = FutureProvider((ref) => client.workout.readiness());
final readinessTrendProvider = FutureProvider(
  (ref) => client.workout.readinessTrend(
    14,
    DateTime.now().timeZoneOffset.inMinutes,
  ),
);
final formHistoryProvider = FutureProvider((ref) => client.form.history());
final equipmentStreamProvider = StreamProvider(
  (ref) => client.equipment.watch(),
);
final planProvider = FutureProvider.family(
  (ref, int id) => client.workout.getPlan(id),
);
final sessionProvider = FutureProvider.family(
  (ref, int id) => client.workout.detail(id),
);
final discoverProvider = FutureProvider.family(
  (ref, ({String city, String category}) q) =>
      client.event.discover(q.city, q.category),
);
final notificationsProvider = FutureProvider(
  (ref) => client.notification.list(),
);
final unreadCountProvider = FutureProvider(
  (ref) => client.notification.unreadCount(),
);
final adminStatsProvider = FutureProvider((ref) => client.admin.stats());
final membersProvider = FutureProvider((ref) => client.admin.members());
