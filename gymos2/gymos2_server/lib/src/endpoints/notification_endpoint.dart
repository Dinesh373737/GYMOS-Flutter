import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

import '../services/access.dart';

class NotificationEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<List<Notification>> list(Session s) async {
    final p = await Access.profile(s);
    return Notification.db.find(
      s,
      where: (t) => t.userId.equals(p.id!),
      orderBy: (t) => t.createdAt.desc(),
      limit: 40,
    );
  }

  Future<int> unreadCount(Session s) async {
    final p = await Access.profile(s);
    return Notification.db.count(
      s,
      where: (t) => t.userId.equals(p.id!) & t.readAt.equals(null),
    );
  }

  Future<void> markAllRead(Session s) async {
    final p = await Access.profile(s);
    final unread = await Notification.db.find(
      s,
      where: (t) => t.userId.equals(p.id!) & t.readAt.equals(null),
    );
    if (unread.isEmpty) return;
    final now = DateTime.now().toUtc();
    await Notification.db.update(s, [for (final n in unread) n..readAt = now]);
  }
}
