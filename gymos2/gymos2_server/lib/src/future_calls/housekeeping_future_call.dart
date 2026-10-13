import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../services/events/event_cache_service.dart';

/// Recurring maintenance: refreshes expired external event caches and prunes
/// ended listings and old read notifications.
class HousekeepingFutureCall extends FutureCall {
  Future<void> run(Session session) async {
    final listings = await EventCacheService.housekeeping(session);
    final notifications = await Notification.db.deleteWhere(
      session,
      where: (t) =>
          t.readAt.notEquals(null) &
          (t.createdAt <
              DateTime.now().toUtc().subtract(const Duration(days: 60))),
    );
    session.log(
      'Housekeeping removed $listings ended listings and '
      '${notifications.length} old notifications.',
    );
  }
}
