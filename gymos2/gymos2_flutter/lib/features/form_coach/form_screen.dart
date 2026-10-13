import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gymos2_client/gymos2_client.dart';
import '../../client.dart';
import '../../app/theme.dart';
import '../../core/providers.dart';
import '../../core/widgets.dart';
import 'pose_analyzer.dart';

class FormScreen extends ConsumerStatefulWidget {
  const FormScreen({super.key});
  @override
  ConsumerState<FormScreen> createState() => _State();
}

class _State extends ConsumerState<FormScreen> {
  String checkpoint = 'squat';
  PoseAssessment? result;
  Uint8List? photo;
  bool busy = false, saved = false;
  Future<void> capture(ImageSource source) async {
    if (kIsWeb ||
        defaultTargetPlatform != TargetPlatform.android &&
            defaultTargetPlatform != TargetPlatform.iOS) {
      setState(
        () => result = const PoseAssessment(
          'Photo analysis runs on the Android or iOS app. Your saved history is available here.',
          [],
        ),
      );
      return;
    }
    setState(() {
      busy = true;
      saved = false;
      result = null;
    });
    PoseDetector? detector;
    try {
      final file = await ImagePicker().pickImage(
        source: source,
        maxWidth: 1800,
        imageQuality: 90,
      );
      if (file == null) return;
      if (await file.length() > 10 * 1024 * 1024) {
        throw Exception('Photo too large');
      }
      final bytes = await file.readAsBytes();
      detector = PoseDetector(
        options: PoseDetectorOptions(
          mode: PoseDetectionMode.single,
          model: PoseDetectionModel.accurate,
        ),
      );
      final poses = await detector.processImage(
        InputImage.fromFilePath(file.path),
      );
      final points = <String, LandmarkPoint>{};
      if (poses.isNotEmpty) {
        final landmarks = poses.first.landmarks;
        final left = [
              PoseLandmarkType.leftShoulder,
              PoseLandmarkType.leftElbow,
              PoseLandmarkType.leftWrist,
              PoseLandmarkType.leftHip,
              PoseLandmarkType.leftKnee,
              PoseLandmarkType.leftAnkle,
            ],
            right = [
              PoseLandmarkType.rightShoulder,
              PoseLandmarkType.rightElbow,
              PoseLandmarkType.rightWrist,
              PoseLandmarkType.rightHip,
              PoseLandmarkType.rightKnee,
              PoseLandmarkType.rightAnkle,
            ];
        double score(List<PoseLandmarkType> side) =>
            side.fold(0, (n, t) => n + (landmarks[t]?.likelihood ?? 0));
        final side = score(left) >= score(right) ? left : right;
        const names = ['shoulder', 'elbow', 'wrist', 'hip', 'knee', 'ankle'];
        for (var i = 0; i < side.length; i++) {
          final l = landmarks[side[i]];
          if (l != null) {
            points[names[i]] = LandmarkPoint(l.x, l.y, l.likelihood);
          }
        }
      }
      if (mounted) {
        setState(() {
          photo = bytes;
          result = PoseAnalyzer.analyze(checkpoint, points);
        });
      }
    } catch (_) {
      if (mounted) {
        setState(
          () => result = const PoseAssessment(
            'Could not analyze this image. Check camera permission and try a well-lit photo.',
            [],
          ),
        );
      }
    } finally {
      await detector?.close();
      if (mounted) setState(() => busy = false);
    }
  }

  @override
  Widget build(BuildContext context) => PageBody(
    children: [
      const PageTitle(
        'A FRESH PERSPECTIVE',
        'Move with intention.',
        'One photo. Clear technique cues. No live rep counting.',
      ),
      ResponsivePair(
        first: Panel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Choose your checkpoint',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 18),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: ['squat', 'push-up', 'plank', 'curl']
                    .map(
                      (x) => ChoiceChip(
                        label: Text(x),
                        selected: checkpoint == x,
                        onSelected: busy
                            ? null
                            : (_) => setState(() {
                                checkpoint = x;
                                result = null;
                                photo = null;
                                saved = false;
                              }),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 24),
              Container(
                height: 240,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: GymTheme.bg,
                  border: Border.all(color: GymTheme.line),
                ),
                child: photo != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Image.memory(photo!, fit: BoxFit.contain),
                      )
                    : const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.accessibility_new_rounded,
                            size: 96,
                            color: GymTheme.accent,
                          ),
                          SizedBox(height: 16),
                          Text(
                            'A clear side view. Your whole body in frame.',
                            style: TextStyle(
                              color: GymTheme.muted,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  FilledButton.icon(
                    onPressed: busy ? null : () => capture(ImageSource.camera),
                    icon: const Icon(Icons.camera_alt_outlined),
                    label: Text(busy ? 'Analyzing…' : 'Take a photo'),
                  ),
                  OutlinedButton.icon(
                    onPressed: busy ? null : () => capture(ImageSource.gallery),
                    icon: const Icon(Icons.photo_outlined),
                    label: const Text('Choose photo'),
                  ),
                ],
              ),
            ],
          ),
        ),
        second: Panel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const StatusPill('PRIVATE BY DESIGN'),
              const SizedBox(height: 22),
              Text(
                'Set yourself up for a useful check.',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 20),
              const Text(
                '01  Place the camera at hip height.\n\n02  Use a side view with good lighting.\n\n03  Hold the selected checkpoint.\n\n04  Keep joints visible and the camera still.',
                style: TextStyle(color: GymTheme.muted, height: 1.6),
              ),
              const SizedBox(height: 24),
              const Text(
                'Pose detection happens on your device. Only derived metrics are saved; your photo is not uploaded.',
                style: TextStyle(fontSize: 12, color: GymTheme.accent),
              ),
              const SizedBox(height: 12),
              const Text(
                'Reference ranges are general technique cues, not a diagnosis or guarantee of safety.',
                style: TextStyle(fontSize: 12, color: GymTheme.muted),
              ),
            ],
          ),
        ),
      ),
      if (result != null) ...[
        const SectionTitle('Your checkpoint'),
        if (!result!.complete)
          EmptyCard(
            icon: Icons.camera_enhance_outlined,
            title: 'Let’s get a clearer view',
            message: result!.state,
          )
        else
          Panel(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final m in result!.metrics)
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(
                      m.passed
                          ? Icons.check_circle_outline
                          : Icons.tips_and_updates_outlined,
                      color: m.passed ? GymTheme.accent : GymTheme.orange,
                    ),
                    title: Text('${m.name} • ${m.value.toStringAsFixed(0)}°'),
                    subtitle: Text('Reference ${m.range}\n${m.cue}'),
                    isThreeLine: true,
                    trailing: Text('${(m.confidence * 100).round()}%'),
                  ),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: saved || busy
                      ? null
                      : () async {
                          setState(() => busy = true);
                          final library = await guarded(
                            context,
                            () => client.exercise.list(''),
                          );
                          if (library != null && context.mounted) {
                            final slug = {
                              'squat': 'bodyweight_sq',
                              'push-up': 'pushups',
                              'plank': 'plank',
                              'curl': 'db_curl',
                            }[checkpoint];
                            final ex = library
                                .where((e) => e.slug == slug)
                                .firstOrNull;
                            if (ex != null) {
                              final value = await guarded(
                                context,
                                () => client.form.save(
                                  ex.id!,
                                  checkpoint,
                                  result!.metrics
                                      .map((m) => m.confidence)
                                      .reduce(min),
                                  result!.metrics
                                      .map(
                                        (m) => FormMetric(
                                          formAnalysisId: 0,
                                          metricName: m.name,
                                          measuredValue: m.value,
                                          unit: 'degrees',
                                          targetRangeText: m.range,
                                          status: m.passed
                                              ? 'check passed'
                                              : 'needs attention',
                                          confidence: m.confidence,
                                          cue: m.cue,
                                        ),
                                      )
                                      .toList(),
                                ),
                              );
                              if (value != null) {
                                saved = true;
                                ref.invalidate(formHistoryProvider);
                              }
                            }
                          }
                          if (mounted) setState(() => busy = false);
                        },
                  child: Text(
                    saved ? 'Saved to your history' : 'Save technique check',
                  ),
                ),
              ],
            ),
          ),
      ],
      const SectionTitle('Your technique journal'),
      AsyncPanel(
        value: ref.watch(formHistoryProvider),
        retry: () => ref.invalidate(formHistoryProvider),
        builder: (list) => list.isEmpty
            ? const Text(
                'Saved checks will appear here. Compare cues over time.',
                style: TextStyle(color: GymTheme.muted),
              )
            : Column(
                children: [
                  for (final a in list)
                    ListTile(
                      title: Text('${a.checkpoint} • ${a.resultBand}'),
                      subtitle: Text(
                        '${shortDate(a.capturedAt)} • ${(a.confidence * 100).round()}% confidence',
                      ),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () async {
                        final detail = await guarded(
                          context,
                          () => client.form.detail(a.id!),
                        );
                        if (context.mounted && detail != null) {
                          showModalBottomSheet<void>(
                            context: context,
                            builder: (c) => Padding(
                              padding: const EdgeInsets.all(24),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(detail.analysis.summary),
                                  for (final m in detail.metrics)
                                    ListTile(
                                      title: Text(
                                        '${m.metricName} • ${m.measuredValue.toStringAsFixed(0)}°',
                                      ),
                                      subtitle: Text(m.cue),
                                    ),
                                ],
                              ),
                            ),
                          );
                        }
                      },
                    ),
                ],
              ),
      ),
    ],
  );
}
