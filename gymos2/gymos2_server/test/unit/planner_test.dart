import 'package:test/test.dart';
import 'package:gymos2_server/src/generated/protocol.dart';
import 'package:gymos2_server/src/services/workout/planner.dart';

Exercise ex(
  int id,
  String name, {
  String difficulty = 'beginner',
  int minutes = 5,
}) => Exercise(
  id: id,
  name: name,
  slug: name,
  instructions: 'Controlled movement',
  difficulty: difficulty,
  movementPattern: 'push',
  exerciseType: 'strength',
  defaultDurationMin: minutes,
  isActive: true,
);
void main() {
  test('planner respects equipment, duration, difficulty and high load', () {
    final chosen = Planner.select(
      exercises: [
        ex(1, 'bodyweight'),
        ex(2, 'machine'),
        ex(3, 'advanced', difficulty: 'advanced'),
        ex(4, 'loaded'),
        ex(5, 'long', minutes: 20),
      ],
      availableEquipment: {},
      requirements: [
        ExerciseEquipment(exerciseId: 2, equipmentId: 1, required: true),
      ],
      minutes: 10,
      experience: 'beginner',
      focus: 'push',
      highLoadExercises: {4},
    );
    expect(chosen.map((e) => e.id), [1]);
    expect(
      chosen.fold<int>(0, (n, e) => n + e.defaultDurationMin),
      lessThanOrEqualTo(10),
    );
  });
  test('training load decays with time and effort matters', () {
    expect(
      Planner.decayedLoad(80, const Duration(hours: 48)),
      closeTo(40, .001),
    );
    expect(Planner.band(80), 'HIGH RECENT LOAD');
    expect(Planner.band(40), 'MODERATE LOAD');
    expect(Planner.band(10), 'READY');
  });
  test('recently repeated exercise is deprioritized', () {
    final selected = Planner.select(
      exercises: [ex(1, 'repeated'), ex(2, 'fresh')],
      availableEquipment: {},
      requirements: [],
      minutes: 5,
      experience: 'beginner',
      focus: 'push',
      highLoadExercises: {},
      recentCounts: {1: 3},
    );
    expect(selected.single.id, 2);
  });
  test('goal changes targets and logged volume changes estimated exposure', () {
    final movement = ex(1, 'press');
    expect(Planner.targetReps(movement, 'strength'), '6–8');
    expect(Planner.targetReps(movement, 'endurance'), '12–15');
    expect(Planner.targetSets(movement, 'consistency'), 2);
    expect(
      Planner.setLoad(reps: 15, weightKg: 20, rpe: 7),
      greaterThan(Planner.setLoad(reps: 5, weightKg: 5, rpe: 4)),
    );
  });
}
