import 'dart:convert';
import 'package:gymos2_server/src/generated/protocol.dart';
import 'package:gymos2_server/src/services/agent/agent_service.dart';
import 'package:test/test.dart';

void main() {
  test('tool schemas contain only their own parameters and stay compact', () {
    expect(AgentService.parameters('get_user_profile')['properties'], isEmpty);
    expect(
      (AgentService.parameters('create_workout_draft')['properties'] as Map)
          .keys,
      unorderedEquals(['minutes', 'focus']),
    );
    expect(
      AgentService.parameters('replace_workout_exercise')['required'],
      unorderedEquals(['exerciseId', 'planId', 'itemId']),
    );
    expect(jsonEncode(AgentService.tools).length, lessThan(5000));
  });

  test(
    'readiness transport preserves load facts without repetitive ORM fields',
    () {
      final rows = List.generate(
        12,
        (i) => TrainingReadiness(
          userId: 1,
          muscleGroupId: i,
          muscleName: 'muscle$i',
          trainingLoadScore: 28.6,
          readinessBand: 'MODERATE LOAD',
          computedAt: DateTime.utc(2026),
          explanation: 'Repeated methodology explanation. ' * 20,
        ),
      );
      final json = jsonEncode(AgentService.compactResult(rows));
      expect(json.length, lessThan(1000));
      expect(json, isNot(contains('__className__')));
      expect(json, isNot(contains('explanation')));
      final result = jsonDecode(json) as List;
      expect(result.first, {
        'muscle': 'muscle0',
        'load': 29,
        'band': 'MODERATE LOAD',
      });
    },
  );
}
