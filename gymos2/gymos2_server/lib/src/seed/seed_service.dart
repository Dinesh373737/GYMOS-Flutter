import 'dart:convert';

import 'dart:io';

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

class SeedService {
  static Future<void> catalog(Session s) async {
    await s.db.transaction((tx) async {
      // One catalog writer across requests and server processes. Retry also
      // repairs a catalog partially written by an older application version.
      await s.db.unsafeQuery(
        'SELECT pg_advisory_xact_lock(4729001)',
        transaction: tx,
      );

      final data =
          jsonDecode(await File('lib/src/seed/catalog.json').readAsString())
              as Map<String, dynamic>;

      final eq = <String, int>{};
      final muscles = <String, int>{};
      final savedEquipment = await EquipmentCatalog.db.find(s, transaction: tx);
      final savedMuscles = await MuscleGroup.db.find(s, transaction: tx);
      final savedExercises = await Exercise.db.find(s, transaction: tx);
      final savedMuscleLinks = await ExerciseMuscle.db.find(s, transaction: tx);
      final savedRequirements = await ExerciseEquipment.db.find(
        s,
        transaction: tx,
      );
      final savedAlternatives = await ExerciseAlternative.db.find(
        s,
        transaction: tx,
      );

      for (final row in data['equipment'] as List) {
        final e =
            savedEquipment.where((e) => e.name == row[1]).firstOrNull ??
            await EquipmentCatalog.db.insertRow(
              s,
              EquipmentCatalog(
                name: row[1],
                category: row[2],
                description: row[3],
              ),
              transaction: tx,
            );
        eq[row[0]] = e.id!;
      }

      final exercises = <Exercise>[];

      for (final x in data['exercises'] as List) {
        final e =
            savedExercises.where((e) => e.slug == x['slug']).firstOrNull ??
            await Exercise.db.insertRow(
              s,
              Exercise(
                name: x['name'],
                slug: x['slug'],
                instructions: x['instructions'],
                difficulty: x['difficulty'],
                movementPattern: x['pattern'],
                exerciseType: x['type'],
                defaultDurationMin: x['duration'],
                isActive: true,
              ),
              transaction: tx,
            );
        exercises.add(e);

        for (final m in x['muscles'] as List) {
          if (!muscles.containsKey(m[0])) {
            final g =
                savedMuscles.where((g) => g.name == m[0]).firstOrNull ??
                await MuscleGroup.db.insertRow(
                  s,
                  MuscleGroup(
                    name: m[0],
                    bodyArea:
                        [
                          'quads',
                          'hamstrings',
                          'glutes',
                          'calves',
                        ].contains(m[0])
                        ? 'lower'
                        : 'upper',
                  ),
                  transaction: tx,
                );
            muscles[m[0]] = g.id!;
          }

          if (!savedMuscleLinks.any(
            (l) => l.exerciseId == e.id && l.muscleGroupId == muscles[m[0]],
          )) {
            await ExerciseMuscle.db.insertRow(
              s,
              ExerciseMuscle(
                exerciseId: e.id!,
                muscleGroupId: muscles[m[0]]!,
                contribution: m[1] == 'true' ? 1 : .4,
              ),
              transaction: tx,
            );
          }
        }

        for (final q in x['equipment'] as List) {
          if (!savedRequirements.any(
            (r) => r.exerciseId == e.id && r.equipmentId == eq[q[0]],
          )) {
            await ExerciseEquipment.db.insertRow(
              s,
              ExerciseEquipment(
                exerciseId: e.id!,
                equipmentId: eq[q[0]]!,
                required: q[1] == 'false',
              ),
              transaction: tx,
            );
          }
        }
      }

      for (final a in exercises) {
        for (final b in exercises) {
          if (a.id != b.id &&
              a.movementPattern == b.movementPattern &&
              !savedAlternatives.any(
                (l) =>
                    l.sourceExerciseId == a.id &&
                    l.alternativeExerciseId == b.id,
              )) {
            await ExerciseAlternative.db.insertRow(
              s,
              ExerciseAlternative(
                sourceExerciseId: a.id!,
                alternativeExerciseId: b.id!,
                similarityScore: .8,
                notes:
                    'Same movement pattern; check the exercise instructions.',
              ),
              transaction: tx,
            );
          }
        }
      }
    });
  }

  static Future<void> inventory(
    Session s,
    int societyId, {
    Transaction? transaction,
  }) async {
    for (final e in await EquipmentCatalog.db.find(
      s,
      limit: 15,
      transaction: transaction,
    )) {
      await SocietyEquipment.db.insertRow(
        s,
        SocietyEquipment(
          societyId: societyId,
          equipmentId: e.id!,
          label: e.name,
          quantity: 1,
          status: e.name == 'Cable Machine' ? 'maintenance' : 'available',
          locationLabel: 'Demo gym • main floor',
        ),
        transaction: transaction,
      );
    }
  }
}
