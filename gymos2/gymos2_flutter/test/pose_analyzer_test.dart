import 'package:flutter_test/flutter_test.dart';
import 'package:gymos2_flutter/features/form_coach/pose_analyzer.dart';

void main() {
  test('no person and missing landmarks request a retake', () {
    expect(PoseAnalyzer.analyze('plank', {}).complete, false);
    expect(
      PoseAnalyzer.analyze('plank', {
        'shoulder': const LandmarkPoint(0, 0, .9),
      }).complete,
      false,
    );
  });
  test('low confidence does not produce technique claims', () {
    final result = PoseAnalyzer.analyze('plank', {
      'shoulder': const LandmarkPoint(0, 0, .2),
      'hip': const LandmarkPoint(1, 0, .9),
      'ankle': const LandmarkPoint(2, 0, .9),
    });
    expect(result.complete, false);
    expect(result.metrics, isEmpty);
  });
  test('straight body line is 180 degrees', () {
    final result = PoseAnalyzer.analyze('plank', {
      'shoulder': const LandmarkPoint(0, 0, .9),
      'hip': const LandmarkPoint(1, 0, .9),
      'ankle': const LandmarkPoint(2, 0, .9),
    });
    expect(result.complete, true);
    expect(result.metrics.single.value, closeTo(180, .01));
    expect(result.metrics.single.passed, true);
  });
  test('overlapping joints are rejected', () {
    final result = PoseAnalyzer.analyze('plank', {
      'shoulder': const LandmarkPoint(0, 0, .9),
      'hip': const LandmarkPoint(0, 0, .9),
      'ankle': const LandmarkPoint(2, 0, .9),
    });
    expect(result.complete, false);
  });
}
