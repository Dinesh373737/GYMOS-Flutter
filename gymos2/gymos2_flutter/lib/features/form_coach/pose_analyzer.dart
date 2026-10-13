import 'dart:math';

class LandmarkPoint {
  final double x, y, confidence;
  const LandmarkPoint(this.x, this.y, this.confidence);
}

class TechniqueMetric {
  final String name, cue, range;
  final double value, confidence;
  final bool passed;
  const TechniqueMetric(
    this.name,
    this.value,
    this.range,
    this.passed,
    this.confidence,
    this.cue,
  );
}

class PoseAssessment {
  final String state;
  final List<TechniqueMetric> metrics;
  const PoseAssessment(this.state, this.metrics);
  bool get complete => state == 'complete';
}

class PoseAnalyzer {
  static double angle(LandmarkPoint a, LandmarkPoint b, LandmarkPoint c) {
    final ux = a.x - b.x, uy = a.y - b.y, vx = c.x - b.x, vy = c.y - b.y;
    final den = sqrt((ux * ux + uy * uy) * (vx * vx + vy * vy));
    if (den < .001) return double.nan;
    return acos(((ux * vx + uy * vy) / den).clamp(-1, 1)) * 180 / pi;
  }

  static PoseAssessment analyze(
    String checkpoint,
    Map<String, LandmarkPoint> p,
  ) {
    if (p.isEmpty) {
      return const PoseAssessment(
        'No person detected. Retake with your full body visible.',
        [],
      );
    }
    final required = switch (checkpoint) {
      'squat' => ['shoulder', 'hip', 'knee', 'ankle'],
      'push-up' => ['shoulder', 'elbow', 'wrist', 'hip', 'ankle'],
      'plank' => ['shoulder', 'hip', 'ankle'],
      'curl' => ['shoulder', 'elbow', 'wrist'],
      _ => <String>[],
    };
    if (required.isEmpty || required.any((k) => !p.containsKey(k))) {
      return const PoseAssessment(
        'Important landmarks are out of frame. Step back and retake.',
        [],
      );
    }
    final confidence = required.map((k) => p[k]!.confidence).reduce(min);
    if (confidence < .65) {
      return const PoseAssessment(
        'Low confidence. Improve lighting and use a clear side view.',
        [],
      );
    }
    final metrics = <TechniqueMetric>[];
    void metric(
      String name,
      String a,
      String b,
      String c,
      double low,
      double high,
      String cue,
    ) {
      final v = angle(p[a]!, p[b]!, p[c]!);
      metrics.add(
        TechniqueMetric(
          name,
          v,
          '${low.toInt()}–${high.toInt()}°',
          v >= low && v <= high,
          confidence,
          cue,
        ),
      );
    }

    if (checkpoint == 'squat') {
      metric(
        'Knee angle',
        'hip',
        'knee',
        'ankle',
        65,
        115,
        'Use a comfortable depth and keep the movement controlled.',
      );
      metric(
        'Hip angle',
        'shoulder',
        'hip',
        'knee',
        45,
        125,
        'Keep your torso supported and avoid forcing depth.',
      );
    }
    if (checkpoint == 'push-up') {
      metric(
        'Elbow angle',
        'shoulder',
        'elbow',
        'wrist',
        65,
        115,
        'At the bottom checkpoint, try a controlled elbow bend.',
      );
      metric(
        'Body line',
        'shoulder',
        'hip',
        'ankle',
        160,
        180,
        'Keep shoulders, hips and ankles in one long line.',
      );
    }
    if (checkpoint == 'plank') {
      metric(
        'Body line',
        'shoulder',
        'hip',
        'ankle',
        165,
        180,
        'Gently bring your hips into line with shoulders and ankles.',
      );
    }
    if (checkpoint == 'curl') {
      metric(
        'Elbow angle',
        'shoulder',
        'elbow',
        'wrist',
        40,
        100,
        'Capture the top of the curl with the elbow held close to your side.',
      );
    }
    if (metrics.any((m) => !m.value.isFinite)) {
      return const PoseAssessment(
        'Landmarks overlap. Retake from a clearer side angle.',
        [],
      );
    }
    return PoseAssessment('complete', metrics);
  }
}
