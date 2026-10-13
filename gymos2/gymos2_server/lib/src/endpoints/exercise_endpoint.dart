import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

import '../services/access.dart';

class ExerciseEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<List<Exercise>> list(Session s, String query) async {
    await Access.profile(s);
    final all = await Exercise.db.find(
      s,
      where: (t) => t.isActive.equals(true),
    );
    return all
        .where((e) => e.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
