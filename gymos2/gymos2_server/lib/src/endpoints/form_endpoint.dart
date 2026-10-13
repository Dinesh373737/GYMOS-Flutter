import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

import '../services/access.dart';

class FormEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<FormResult> save(
    Session s,
    int exerciseId,
    String checkpoint,
    double confidence,
    List<FormMetric> metrics,
  ) async {
    final p = await Access.profile(s);
    final exercise = await Exercise.db.findById(s, exerciseId);

    if (exercise == null ||
        !['squat', 'push-up', 'plank', 'curl'].contains(checkpoint) ||
        !confidence.isFinite ||
        confidence < .65 ||
        confidence > 1 ||
        metrics.isEmpty ||
        metrics.length > 8 ||
        metrics.any(
          (m) =>
              !m.measuredValue.isFinite ||
              !m.confidence.isFinite ||
              m.confidence < .65 ||
              m.confidence > 1 ||
              m.metricName.length > 60 ||
              m.cue.length > 300 ||
              m.targetRangeText.length > 80 ||
              !['check passed', 'needs attention'].contains(m.status),
        )) {
      throw GymException(
        message: 'Retake the photo with all important landmarks visible.',
      );
    }

    final now = DateTime.now().toUtc();
    final attention = metrics.any((m) => m.status == 'needs attention');

    final row = await FormAnalysis.db.insertRow(
      s,
      FormAnalysis(
        userId: p.id!,
        exerciseId: exerciseId,
        checkpoint: checkpoint,
        capturedAt: now,
        analysisType: 'photo',
        resultBand: attention ? 'needs attention' : 'checks passed',
        confidence: confidence,
        summary: attention
            ? 'Review the technique cues below.'
            : 'Visible checkpoint metrics are within the reference ranges. This is not a safety assessment.',
      ),
    );

    final saved = <FormMetric>[];
    for (final m in metrics) {
      saved.add(
        await FormMetric.db.insertRow(
          s,
          FormMetric(
            formAnalysisId: row.id!,
            metricName: m.metricName,
            measuredValue: m.measuredValue,
            unit: m.unit,
            targetRangeText: m.targetRangeText,
            status: m.status,
            confidence: m.confidence,
            cue: m.cue,
          ),
        ),
      );
    }

    return FormResult(analysis: row, metrics: saved);
  }

  Future<List<FormAnalysis>> history(Session s) async {
    final p = await Access.profile(s);
    return FormAnalysis.db.find(
      s,
      where: (t) => t.userId.equals(p.id!),
      orderBy: (t) => t.capturedAt.desc(),
      limit: 100,
    );
  }

  Future<FormResult> detail(Session s, int id) async {
    final p = await Access.profile(s);
    final a = await FormAnalysis.db.findById(s, id);
    if (a == null || a.userId != p.id) {
      throw GymException(message: 'Analysis not found.');
    }
    return FormResult(
      analysis: a,
      metrics: await FormMetric.db.find(
        s,
        where: (t) => t.formAnalysisId.equals(id),
      ),
    );
  }
}
