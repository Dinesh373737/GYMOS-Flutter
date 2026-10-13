from pathlib import Path
base=Path('gymos2/gymos2_server/lib/src/services/workout')
p=base/'planner.dart';s=p.read_text();s=s.replace('required String focus,','required String focus,\n    String goal = \'general fitness\',')
s=s.replace("int phase(Exercise e) => e.exerciseType == 'warmup'", "int phase(Exercise e) => goal == 'mobility' && e.exerciseType == 'flexibility' ? 1 : e.exerciseType == 'warmup'")
s=s.replace('      final score =','''      int goalPreference(Exercise e) => switch (goal) {
        'endurance' => e.exerciseType == 'cardio' ? -8 : 0,
        'strength' => ['compound', 'strength'].contains(e.exerciseType) ? -3 : 0,
        'mobility' => e.exerciseType == 'flexibility' ? -8 : 0,
        'consistency' => e.difficulty == 'beginner' ? -2 : 0,
        _ => 0,
      };
      final goalOrder = goalPreference(a).compareTo(goalPreference(b));
      if (goalOrder != 0) return goalOrder;
      final score =''')
s=s.replace('''    for (final e in candidates) {
      if (used + e.defaultDurationMin <= minutes &&''','''    // Distribute a full-body session across patterns before repeating them.
    final ordered = <Exercise>[];
    final patterns = <String>{};
    for (final e in candidates) {
      if (focus == 'full body' && goal != 'endurance' && goal != 'mobility' && !['warmup', 'cooldown', 'flexibility'].contains(e.exerciseType) && !patterns.add(e.movementPattern)) continue;
      ordered.add(e);
    }
    ordered.addAll(candidates.where((e) => !ordered.contains(e)));
    for (final e in ordered) {
      if (minutes <= 90 && e.exerciseType == 'warmup' && selected.any((x) => x.exerciseType == 'warmup')) continue;
      if (used + e.defaultDurationMin <= minutes &&''')
s=s.replace('  static double decayedLoad', '''  // Relative training exposure, deliberately bounded. This is not a biological
  // recovery formula: logged work and perceived effort only alter load bands.
  static double setLoad({int? reps, double? weightKg, int? durationSec, double rpe = 6}) {
    final repetitions = ((reps ?? 10) / 10).clamp(.5, 2.0);
    final resistance = 1 + log(1 + (weightKg ?? 0).clamp(0, 1000) / 20) * .2;
    final duration = durationSec == null ? 1.0 : (durationSec / 45).clamp(.5, 2.0);
    return rpe.clamp(1, 10) * 1.5 * max(repetitions, duration) * resistance;
  }

  static double decayedLoad''')
p.write_text(s)
p=base/'workout_service.dart';s=p.read_text();s=s.replace('focus: focus,\n      highLoadExercises: highExercises,','focus: focus,\n      goal: p.primaryGoal,\n      highLoadExercises: highExercises,');p.write_text(s)
