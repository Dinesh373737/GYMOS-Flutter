import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// Creates in-app notifications. Delivery is in-app only; connected clients
/// refresh through the society stream.
class Notifications {
  static Future<void> send(
    Session s,
    int userId,
    String type,
    String title,
    String body, {
    String? link,
    Transaction? transaction,
  }) => Notification.db.insertRow(
    s,
    Notification(
      userId: userId,
      type: type,
      title: title,
      body: body,
      link: link,
      createdAt: DateTime.now().toUtc(),
    ),
    transaction: transaction,
  );

  static Future<void> toAdmins(
    Session s,
    int societyId,
    String type,
    String title,
    String body, {
    String? link,
    int? exceptUserId,
  }) async {
    final admins = await SocietyMembership.db.find(
      s,
      where: (t) =>
          t.societyId.equals(societyId) &
          t.role.equals('admin') &
          t.isActive.equals(true),
    );
    for (final a in admins) {
      if (a.userId == exceptUserId) continue;
      await send(s, a.userId, type, title, body, link: link);
    }
  }
}
