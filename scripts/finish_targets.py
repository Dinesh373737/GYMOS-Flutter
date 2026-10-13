from pathlib import Path
p=Path('gymos2/gymos2_server/lib/src/services/workout/planner.dart');s=p.read_text().replace('  // Relative training exposure', '''  static int targetSets(Exercise e, String goal) =>
      ['warmup', 'cooldown', 'cardio', 'flexibility'].contains(e.exerciseType) ? 1 : goal == 'consistency' ? 2 : 3;

  static String targetReps(Exercise e, String goal) {
    if (e.movementPattern == 'core' || e.exerciseType == 'flexibility') return '30 sec';
    if (['warmup', 'cooldown', 'cardio'].contains(e.exerciseType)) return '${e.defaultDurationMin} min';
    return switch (goal) { 'strength' => '6–8', 'endurance' => '12–15', _ => '8–12' };
  }

  // Relative training exposure''');p.write_text(s)
p=Path('gymos2/gymos2_server/test/unit/planner_test.dart');s=p.read_text();pos=s.rfind('}');s=s[:pos]+'''  test('goal changes targets and logged volume changes estimated exposure', () {
    final movement = ex(1, 'press');
    expect(Planner.targetReps(movement, 'strength'), '6–8');
    expect(Planner.targetReps(movement, 'endurance'), '12–15');
    expect(Planner.targetSets(movement, 'consistency'), 2);
    expect(Planner.setLoad(reps: 15, weightKg: 20, rpe: 7), greaterThan(Planner.setLoad(reps: 5, weightKg: 5, rpe: 4)));
  });
''' +s[pos:];p.write_text(s)
