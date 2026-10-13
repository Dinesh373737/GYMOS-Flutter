import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

class Access {
  static String authId(Session s) {
    final id = s.authenticated?.userIdentifier;

    if (id == null) throw GymException(message: 'Please sign in.');

    return id;
  }

  static Future<UserProfile> profile(Session s, {bool admin = false}) async {
    final id = authId(s);

    final p = await UserProfile.db.findFirstRow(
      s,
      where: (t) => t.authUserId.equals(id),
    );

    if (p == null) throw GymException(message: 'Complete your profile first.');

    final m = await SocietyMembership.db.findFirstRow(
      s,
      where: (t) =>
          t.userId.equals(p.id!) &
          t.societyId.equals(p.societyId) &
          t.isActive.equals(true),
    );

    if (m == null || (admin && m.role != 'admin')) {
      throw GymException(
        message: 'This action requires an active society administrator.',
      );
    }

    return p;
  }

  static String text(String value, {int max = 1000}) {
    final v = value.trim().replaceAll(RegExp(r'<[^>]*>'), '');

    if (v.isEmpty || v.length > max) {
      throw GymException(message: 'Enter between 1 and $max characters.');
    }

    return v;
  }
}
