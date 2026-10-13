import 'dart:math';

import '../../generated/protocol.dart';

class Planner {
  static List<Exercise> select({
    required List<Exercise> exercises,
    required Set<int> availableEquipment,
    required List<ExerciseEquipment> requirements,
    required int minutes,
    required String experience,
    required String focus,
    String goal = 'general fitness',
    required Set<int> highLoadExercises,
    Map<int, int> recentCounts = const {},
    Set<int> techniqueExercises = const {},
    Map<int, int> skippedCounts = const {},
  }) {
    const ranks = {'beginner': 0, 'intermediate': 1, 'advanced': 2};

    final candidates = exercises
        .where(
          (e) =>
              e.isActive &&
              (ranks[e.difficulty] ?? 2) <= (ranks[experience] ?? 0) &&
              !highLoadExercises.contains(e.id) &&
              !requirements.any(
                (r) =>
                    r.exerciseId == e.id &&
                    r.required &&
                    !availableEquipment.contains(r.equipmentId),
              ) &&
              (focus == 'full body' ||
                  e.movementPattern == focus ||
                  [
                    'warmup',
                    'cooldown',
                    'flexibility',
                  ].contains(e.exerciseType)),
        )
        .toList();

    int phase(Exercise e) =>
        goal == 'mobility' && e.exerciseType == 'flexibility'
        ? 1
        : e.exerciseType == 'warmup'
        ? 0
        : ['cooldown', 'flexibility'].contains(e.exerciseType)
        ? 3
        : e.exerciseType == 'isolation'
        ? 2
        : 1;

    candidates.sort((a, b) {
      final order = phase(a).compareTo(phase(b));
      if (order != 0) return order;
      int goalPreference(Exercise e) => switch (goal) {
        'endurance' => e.exerciseType == 'cardio' ? -8 : 0,
        'strength' =>
          ['compound', 'strength'].contains(e.exerciseType) ? -3 : 0,
        'mobility' => e.exerciseType == 'flexibility' ? -8 : 0,
        'consistency' => e.difficulty == 'beginner' ? -2 : 0,
        _ => 0,
      };
      final goalOrder = goalPreference(a).compareTo(goalPreference(b));
      if (goalOrder != 0) return goalOrder;
      int penalty(Exercise e) =>
          (recentCounts[e.id] ?? 0) +
          (techniqueExercises.contains(e.id) ? 3 : 0) +
          (skippedCounts[e.id] ?? 0) * 4;
      final score = penalty(a).compareTo(penalty(b));
      return score != 0 ? score : a.id!.compareTo(b.id!);
    });

    final selected = <Exercise>[];
    var used = 0;

    // Distribute a full-body session across patterns before repeating them.
    final ordered = <Exercise>[];
    final patterns = <String>{};
    for (final e in candidates) {
      if (focus == 'full body' &&
          goal != 'endurance' &&
          goal != 'mobility' &&
          !['warmup', 'cooldown', 'flexibility'].contains(e.exerciseType) &&
          !patterns.add(e.movementPattern)) {
        continue;
      }
      ordered.add(e);
    }
    ordered.addAll(candidates.where((e) => !ordered.contains(e)));
    for (final e in ordered) {
      if (minutes <= 90 &&
          e.exerciseType == 'warmup' &&
          selected.any((x) => x.exerciseType == 'warmup')) {
        continue;
      }
      if (used + e.defaultDurationMin <= minutes &&
          selected.length < max(2, minutes ~/ 5)) {
        selected.add(e);
        used += e.defaultDurationMin;
      }
    }

    return selected;
  }

  static int targetSets(Exercise e, String goal) =>
      ['warmup', 'cooldown', 'cardio', 'flexibility'].contains(e.exerciseType)
      ? 1
      : goal == 'consistency'
      ? 2
      : 3;

  static String targetReps(Exercise e, String goal) {
    if (e.movementPattern == 'core' || e.exerciseType == 'flexibility') {
      return '30 sec';
    }
    if (['warmup', 'cooldown', 'cardio'].contains(e.exerciseType)) {
      return '${e.defaultDurationMin} min';
    }
    return switch (goal) {
      'strength' => '6–8',
      'endurance' => '12–15',
      _ => '8–12',
    };
  }

  // Relative training exposure, deliberately bounded. This is not a biological
  // recovery formula: logged work and perceived effort only alter load bands.
  static double setLoad({
    int? reps,
    double? weightKg,
    int? durationSec,
    double rpe = 6,
  }) {
    final repetitions = ((reps ?? 10) / 10).clamp(.5, 2.0);
    final resistance = 1 + log(1 + (weightKg ?? 0).clamp(0, 1000) / 20) * .2;
    final duration = durationSec == null
        ? 1.0
        : (durationSec / 45).clamp(.5, 2.0);
    return rpe.clamp(1, 10) * 1.5 * max(repetitions, duration) * resistance;
  }

  static double decayedLoad(double load, Duration elapsed) =>
      load * pow(.5, elapsed.inMinutes.clamp(0, 1000000) / (48 * 60));

  static String band(double score) => score >= 65
      ? 'HIGH RECENT LOAD'
      : score >= 25
      ? 'MODERATE LOAD'
      : 'READY';
}
