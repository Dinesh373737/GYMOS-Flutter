import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:go_router/go_router.dart';
import 'package:gymos2_client/gymos2_client.dart';
import '../../app/theme.dart';
import '../../client.dart';
import '../../core/providers.dart';
import '../../core/widgets.dart';

final loggedExercisesProvider = FutureProvider(
  (ref) => client.workout.loggedExercises(),
);
final exerciseTrendProvider = FutureProvider.family(
  (ref, int id) => client.workout.exerciseTrend(id),
);

class ProgressScreen extends ConsumerWidget {
  const ProgressScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) => PageBody(
    children: [
      const PageTitle(
        'Consistency over perfection',
        'Look how far you’ve come.',
        'A clear view of the work you’ve actually logged.',
      ),
      AsyncPanel(
        value: ref.watch(dashboardProvider),
        retry: () => ref.invalidate(dashboardProvider),
        builder: (d) {
          final finished = d.recentSessions
              .where((s) => s.endedAt != null)
              .toList();
          final month = finished
              .where(
                (s) => s.startedAt.isAfter(
                  DateTime.now().subtract(const Duration(days: 30)),
                ),
              )
              .length;
          final minutes = finished.fold<int>(
            0,
            (n, s) => n + (s.durationMin ?? 0),
          );
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AdaptiveGrid(
                minTileWidth: 180,
                children: [
                  StatTile(
                    icon: Icons.calendar_month_rounded,
                    value: '$month',
                    label: 'Sessions · 30 days',
                  ),
                  StatTile(
                    icon: Icons.local_fire_department_rounded,
                    value: '${_weekStreak(finished)}',
                    label: 'Week streak',
                    color: GymTheme.orange,
                  ),
                  StatTile(
                    icon: Icons.timer_outlined,
                    value: '$minutes',
                    label: 'Minutes trained',
                    color: GymTheme.sky,
                  ),
                  StatTile(
                    icon: Icons.stacked_bar_chart_rounded,
                    value: '${d.completedSets}',
                    label: 'Sets logged',
                    color: GymTheme.mint,
                  ),
                ],
              ),
              const SizedBox(height: 18),
              ResponsivePair(
                firstFlex: 1,
                secondFlex: 1,
                breakpoint: 860,
                first: _WeekChart(finished),
                second: const _LoadTrend(),
              ),
              const SectionTitle(
                'Exercise trends',
                icon: Icons.show_chart_rounded,
              ),
              const _ExerciseTrend(),
              const SectionTitle(
                'Estimated training readiness',
                icon: Icons.monitor_heart_outlined,
              ),
              _Readiness(d.readiness),
              const SectionTitle(
                'Form-check trend',
                icon: Icons.accessibility_new_rounded,
              ),
              const _FormTrend(),
              const SectionTitle(
                'Session history',
                icon: Icons.history_rounded,
              ),
              if (d.recentSessions.isEmpty)
                const EmptyCard(
                  icon: Icons.timeline,
                  title: 'Your story starts with one session',
                  message:
                      'No workout history yet. Log your first sets in Workout.',
                )
              else
                Panel(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 6,
                  ),
                  child: Column(
                    children: [
                      for (final s in d.recentSessions.take(20))
                        ListTile(
                          leading: Icon(
                            s.endedAt == null
                                ? Icons.play_circle_outline
                                : Icons.check_circle_rounded,
                            color: s.endedAt == null
                                ? GymTheme.orange
                                : GymTheme.accent,
                          ),
                          title: Text(
                            s.title,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          subtitle: Text(friendlyDate(s.startedAt)),
                          trailing: Text(
                            s.endedAt == null
                                ? 'In progress'
                                : '${s.durationMin} min',
                            style: const TextStyle(color: GymTheme.muted),
                          ),
                          onTap: () => context.go('/session/${s.id}'),
                        ),
                    ],
                  ),
                ),
            ],
          );
        },
      ),
    ],
  );
}

/// Consecutive weeks (ending this week) with at least one finished session.
int _weekStreak(List<WorkoutSession> finished) {
  DateTime weekStart(DateTime d) {
    final x = d.toLocal();
    return DateTime(x.year, x.month, x.day).subtract(
      Duration(days: x.weekday - 1),
    );
  }

  final weeks = finished.map((s) => weekStart(s.startedAt)).toSet();
  var cursor = weekStart(DateTime.now());
  if (!weeks.contains(cursor)) {
    cursor = cursor.subtract(const Duration(days: 7));
  }
  var streak = 0;
  while (weeks.contains(cursor)) {
    streak++;
    cursor = cursor.subtract(const Duration(days: 7));
  }
  return streak;
}

FlTitlesData _titles({
  required Widget Function(double) bottom,
  double? interval,
}) => FlTitlesData(
  topTitles: const AxisTitles(),
  rightTitles: const AxisTitles(),
  leftTitles: AxisTitles(
    sideTitles: SideTitles(
      showTitles: true,
      reservedSize: 32,
      interval: interval,
      getTitlesWidget: (v, meta) => v == meta.max
          ? const SizedBox.shrink()
          : Text(
              v >= 1000
                  ? '${(v / 1000).toStringAsFixed(1)}k'
                  : v.toInt().toString(),
              style: const TextStyle(color: GymTheme.subtle, fontSize: 10.5),
            ),
    ),
  ),
  bottomTitles: AxisTitles(
    sideTitles: SideTitles(
      showTitles: true,
      reservedSize: 26,
      interval: 1,
      getTitlesWidget: (v, _) =>
          Padding(padding: const EdgeInsets.only(top: 6), child: bottom(v)),
    ),
  ),
);

const _grid = FlGridData(
  drawVerticalLine: false,
  getDrawingHorizontalLine: _line,
);
FlLine _line(double _) => const FlLine(color: GymTheme.line, strokeWidth: 1);

class _WeekChart extends StatelessWidget {
  final List<WorkoutSession> finished;
  const _WeekChart(this.finished);
  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final days = [for (var i = 6; i >= 0; i--) now.subtract(Duration(days: i))];
    final counts = [
      for (final day in days)
        finished.where((s) {
          final x = s.startedAt.toLocal();
          return x.year == day.year && x.month == day.month && x.day == day.day;
        }).length,
    ];
    final total = counts.fold<int>(0, (a, b) => a + b);
    final maxY = (counts.reduce(math.max) + 1).toDouble();
    return Panel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your last 7 days',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 4),
          Text(
            '$total completed session${total == 1 ? '' : 's'}',
            style: const TextStyle(color: GymTheme.muted),
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 190,
            child: BarChart(
              BarChartData(
                maxY: maxY,
                borderData: FlBorderData(show: false),
                gridData: _grid,
                titlesData: _titles(
                  interval: 1,
                  bottom: (v) => Text(
                    'MTWTFSS'[days[v.toInt()].weekday - 1],
                    style: TextStyle(
                      color: v.toInt() == 6 ? GymTheme.accent : GymTheme.subtle,
                      fontWeight: FontWeight.w700,
                      fontSize: 11,
                    ),
                  ),
                ),
                barTouchData: BarTouchData(
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipColor: (_) => GymTheme.surfaceHigh,
                    getTooltipItem: (g, _, rod, _) => BarTooltipItem(
                      '${rod.toY.toInt()} session${rod.toY == 1 ? '' : 's'}',
                      const TextStyle(color: GymTheme.text, fontSize: 12),
                    ),
                  ),
                ),
                barGroups: [
                  for (var i = 0; i < 7; i++)
                    BarChartGroupData(
                      x: i,
                      barRods: [
                        BarChartRodData(
                          toY: counts[i].toDouble(),
                          width: 24,
                          gradient: const LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [GymTheme.accentDeep, GymTheme.accent],
                          ),
                          borderRadius: BorderRadius.circular(7),
                          backDrawRodData: BackgroundBarChartRodData(
                            show: true,
                            toY: maxY,
                            color: GymTheme.bgRaised,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LoadTrend extends ConsumerWidget {
  const _LoadTrend();
  @override
  Widget build(BuildContext context, WidgetRef ref) => Panel(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Training-load trend',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 4),
        const Text(
          'Daily estimate across all muscles, last 14 days',
          style: TextStyle(color: GymTheme.muted),
        ),
        const SizedBox(height: 24),
        SizedBox(
          height: 190,
          child: AsyncPanel(
            value: ref.watch(readinessTrendProvider),
            retry: () => ref.invalidate(readinessTrendProvider),
            loading: const Center(child: CircularProgressIndicator()),
            builder: (points) {
              if (points.every((p) => p.totalLoad == 0)) {
                return const Center(
                  child: Text(
                    'Log sets to see how your load rises and settles.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: GymTheme.muted),
                  ),
                );
              }
              final maxY =
                  points.map((p) => p.totalLoad).reduce(math.max) * 1.2;
              return LineChart(
                LineChartData(
                  minY: 0,
                  maxY: maxY,
                  borderData: FlBorderData(show: false),
                  gridData: _grid,
                  titlesData: _titles(
                    bottom: (v) {
                      final i = v.toInt();
                      if (i % 3 != 1 && i != points.length - 1) {
                        return const SizedBox.shrink();
                      }
                      final d = points[i].day;
                      return Text(
                        i == points.length - 1
                            ? 'Today'
                            : '${d.day}/${d.month}',
                        style: const TextStyle(
                          color: GymTheme.subtle,
                          fontSize: 10,
                        ),
                      );
                    },
                  ),
                  lineTouchData: LineTouchData(
                    touchTooltipData: LineTouchTooltipData(
                      getTooltipColor: (_) => GymTheme.surfaceHigh,
                      getTooltipItems: (spots) => [
                        for (final s in spots)
                          LineTooltipItem(
                            'Load ${s.y.toStringAsFixed(0)}\n${points[s.x.toInt()].sessions} session(s)',
                            const TextStyle(color: GymTheme.text, fontSize: 12),
                          ),
                      ],
                    ),
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      spots: [
                        for (var i = 0; i < points.length; i++)
                          FlSpot(i.toDouble(), points[i].totalLoad),
                      ],
                      isCurved: true,
                      curveSmoothness: .3,
                      preventCurveOverShooting: true,
                      barWidth: 3,
                      gradient: const LinearGradient(
                        colors: [GymTheme.mint, GymTheme.accent],
                      ),
                      dotData: FlDotData(
                        checkToShowDot: (s, _) =>
                            points[s.x.toInt()].sessions > 0,
                        getDotPainter: (s, _, _, _) => FlDotCirclePainter(
                          radius: 4,
                          color: GymTheme.accent,
                          strokeColor: GymTheme.bg,
                          strokeWidth: 2,
                        ),
                      ),
                      belowBarData: BarAreaData(
                        show: true,
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            GymTheme.accent.withValues(alpha: .25),
                            GymTheme.accent.withValues(alpha: 0),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    ),
  );
}

class _ExerciseTrend extends ConsumerStatefulWidget {
  const _ExerciseTrend();
  @override
  ConsumerState<_ExerciseTrend> createState() => _ExerciseTrendState();
}

class _ExerciseTrendState extends ConsumerState<_ExerciseTrend> {
  int? selected;
  bool volume = false;
  @override
  Widget build(BuildContext context) => AsyncPanel(
    value: ref.watch(loggedExercisesProvider),
    retry: () => ref.invalidate(loggedExercisesProvider),
    builder: (exercises) {
      if (exercises.isEmpty) {
        return const EmptyCard(
          icon: Icons.show_chart_rounded,
          title: 'Trends appear after your first session',
          message: 'Finish a workout to compare lifts over time.',
        );
      }
      final id = exercises.any((e) => e.id == selected)
          ? selected!
          : exercises.first.id!;
      return Panel(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 12,
              runSpacing: 12,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                DropdownMenu<int>(
                  initialSelection: id,
                  width: 280,
                  label: const Text('Exercise'),
                  onSelected: (v) => setState(() => selected = v),
                  dropdownMenuEntries: [
                    for (final e in exercises)
                      DropdownMenuEntry(value: e.id!, label: e.name),
                  ],
                ),
                SegmentedButton<bool>(
                  showSelectedIcon: false,
                  segments: const [
                    ButtonSegment(value: false, label: Text('Top weight')),
                    ButtonSegment(value: true, label: Text('Volume')),
                  ],
                  selected: {volume},
                  onSelectionChanged: (v) => setState(() => volume = v.first),
                ),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 200,
              child: AsyncPanel(
                value: ref.watch(exerciseTrendProvider(id)),
                retry: () => ref.invalidate(exerciseTrendProvider(id)),
                loading: const Center(child: CircularProgressIndicator()),
                builder: (points) {
                  if (points.isEmpty) {
                    return const Center(
                      child: Text('No sets for this one yet.'),
                    );
                  }
                  double y(ExercisePoint p) =>
                      volume ? p.volumeKg : p.topWeightKg;
                  final maxY = math.max(
                    1.0,
                    points.map(y).reduce(math.max) * 1.2,
                  );
                  final best = points.map(y).reduce(math.max);
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        volume
                            ? 'Best session volume ${best.toStringAsFixed(0)} kg'
                            : 'Best top set ${best.toStringAsFixed(1)} kg',
                        style: const TextStyle(color: GymTheme.muted),
                      ),
                      const SizedBox(height: 12),
                      Expanded(
                        child: LineChart(
                          LineChartData(
                            minY: 0,
                            maxY: maxY,
                            borderData: FlBorderData(show: false),
                            gridData: _grid,
                            titlesData: _titles(
                              bottom: (v) {
                                final i = v.toInt();
                                if (i >= points.length ||
                                    (points.length > 6 &&
                                        i % (points.length ~/ 5) != 0)) {
                                  return const SizedBox.shrink();
                                }
                                final d = points[i].day.toLocal();
                                return Text(
                                  '${d.day}/${d.month}',
                                  style: const TextStyle(
                                    color: GymTheme.subtle,
                                    fontSize: 10,
                                  ),
                                );
                              },
                            ),
                            lineTouchData: LineTouchData(
                              touchTooltipData: LineTouchTooltipData(
                                getTooltipColor: (_) => GymTheme.surfaceHigh,
                                getTooltipItems: (spots) => [
                                  for (final s in spots)
                                    LineTooltipItem(
                                      '${s.y.toStringAsFixed(1)} kg\n${points[s.x.toInt()].sets} sets · ${points[s.x.toInt()].totalReps} reps',
                                      const TextStyle(
                                        color: GymTheme.text,
                                        fontSize: 12,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            lineBarsData: [
                              LineChartBarData(
                                spots: [
                                  for (var i = 0; i < points.length; i++)
                                    FlSpot(i.toDouble(), y(points[i])),
                                ],
                                isCurved: points.length > 2,
                                preventCurveOverShooting: true,
                                barWidth: 3,
                                color: GymTheme.sky,
                                dotData: FlDotData(
                                  getDotPainter: (s, _, _, _) =>
                                      FlDotCirclePainter(
                                        radius: 4,
                                        color: GymTheme.sky,
                                        strokeColor: GymTheme.bg,
                                        strokeWidth: 2,
                                      ),
                                ),
                                belowBarData: BarAreaData(
                                  show: true,
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      GymTheme.sky.withValues(alpha: .22),
                                      GymTheme.sky.withValues(alpha: 0),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      );
    },
  );
}

class _Readiness extends StatelessWidget {
  final List<TrainingReadiness> readiness;
  const _Readiness(this.readiness);
  @override
  Widget build(BuildContext context) {
    final sorted = [...readiness]
      ..sort((a, b) => b.trainingLoadScore.compareTo(a.trainingLoadScore));
    return Panel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Wrap(
            spacing: 16,
            runSpacing: 8,
            children: [
              _Legend(GymTheme.accent, 'Ready'),
              _Legend(GymTheme.orange, 'Moderate load'),
              _Legend(GymTheme.coral, 'High recent load'),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Bands summarize recent logged effort and elapsed time. They do not measure medical recovery.',
            style: TextStyle(color: GymTheme.subtle, fontSize: 12.5),
          ),
          const SizedBox(height: 20),
          LayoutBuilder(
            builder: (context, c) {
              final columns = c.maxWidth > 760 ? 2 : 1;
              final width = (c.maxWidth - 28 * (columns - 1)) / columns;
              return Wrap(
                spacing: 28,
                runSpacing: 18,
                children: [
                  for (final r in sorted)
                    SizedBox(
                      width: width,
                      child: Tooltip(
                        message: r.explanation,
                        child: MetricBar(
                          label: titleCase(r.muscleName),
                          trailing: r.readinessBand,
                          value: r.trainingLoadScore / 100,
                          color: GymTheme.band(r.readinessBand),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _Legend extends StatelessWidget {
  final Color color;
  final String label;
  const _Legend(this.color, this.label);
  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(3),
        ),
      ),
      const SizedBox(width: 6),
      Text(label, style: const TextStyle(color: GymTheme.muted, fontSize: 12)),
    ],
  );
}

class _FormTrend extends ConsumerWidget {
  const _FormTrend();
  @override
  Widget build(BuildContext context, WidgetRef ref) => AsyncPanel(
    value: ref.watch(formHistoryProvider),
    retry: () => ref.invalidate(formHistoryProvider),
    builder: (history) {
      if (history.isEmpty) {
        return EmptyCard(
          icon: Icons.accessibility_new_rounded,
          title: 'No form checks yet',
          message:
              'Analyze a still photo on your phone to start a technique history.',
          action: OutlinedButton(
            onPressed: () => context.go('/form'),
            child: const Text('Open form coach'),
          ),
        );
      }
      final byCheckpoint = <String, List<FormAnalysis>>{};
      for (final a in history) {
        byCheckpoint.putIfAbsent(a.checkpoint, () => []).add(a);
      }
      return AdaptiveGrid(
        minTileWidth: 260,
        children: [
          for (final entry in byCheckpoint.entries)
            Panel(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          titleCase(entry.key),
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      StatusPill(
                        entry.value.first.resultBand.toUpperCase(),
                        color: GymTheme.status(entry.value.first.resultBand),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${entry.value.length} check${entry.value.length == 1 ? '' : 's'} · '
                    '${entry.value.where((a) => a.resultBand == 'checks passed').length} passed',
                    style: const TextStyle(color: GymTheme.muted),
                  ),
                  const SizedBox(height: 16),
                  // Oldest to newest, most recent eight.
                  Row(
                    children: [
                      for (final a in entry.value.take(8).toList().reversed)
                        Tooltip(
                          message:
                              '${friendlyDate(a.capturedAt)} · ${(a.confidence * 100).round()}% confidence',
                          child: Container(
                            width: 22,
                            height: 22,
                            margin: const EdgeInsets.only(right: 6),
                            decoration: BoxDecoration(
                              color: GymTheme.status(
                                a.resultBand,
                              ).withValues(alpha: .2),
                              borderRadius: BorderRadius.circular(7),
                              border: Border.all(
                                color: GymTheme.status(a.resultBand),
                              ),
                            ),
                            child: Icon(
                              a.resultBand == 'checks passed'
                                  ? Icons.check_rounded
                                  : Icons.priority_high_rounded,
                              size: 13,
                              color: GymTheme.status(a.resultBand),
                            ),
                          ),
                        ),
                    ],
                  ),
                  if (entry.value.length > 1) ...[
                    const SizedBox(height: 12),
                    Text(
                      entry.value.first.resultBand == entry.value[1].resultBand
                          ? 'Same result as your previous check.'
                          : entry.value.first.resultBand == 'checks passed'
                          ? 'Improved since your previous check.'
                          : 'Needs attention again — review the cues.',
                      style: const TextStyle(fontSize: 12.5),
                    ),
                  ],
                ],
              ),
            ),
        ],
      );
    },
  );
}
