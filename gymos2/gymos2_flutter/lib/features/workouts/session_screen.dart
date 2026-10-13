import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gymos2_client/gymos2_client.dart';
import '../../client.dart';
import '../../app/theme.dart';
import '../../core/providers.dart';
import '../../core/widgets.dart';
import 'swap_sheet.dart';

class SessionScreen extends ConsumerStatefulWidget {
  final int id;
  const SessionScreen({super.key, required this.id});
  @override
  ConsumerState<SessionScreen> createState() => _State();
}

String _setLine(WorkoutSet s) =>
    'Set ${s.setNumber} • ${s.reps ?? 0} reps × ${_kg(s.weightKg ?? 0)} kg';

String _kg(double v) =>
    v == v.roundToDouble() ? v.toStringAsFixed(0) : v.toStringAsFixed(1);

double _volume(Iterable<WorkoutSet> sets) =>
    sets.fold<double>(0, (v, s) => v + (s.reps ?? 0) * (s.weightKg ?? 0));

class _State extends ConsumerState<SessionScreen> {
  int index = 0, rest = 0, restTotal = 0;
  Timer? timer;
  bool busy = false;
  final reps = TextEditingController(text: '10'),
      weight = TextEditingController(text: '0'),
      seconds = TextEditingController(),
      effort = TextEditingController(text: '6');
  @override
  void dispose() {
    timer?.cancel();
    reps.dispose();
    weight.dispose();
    seconds.dispose();
    effort.dispose();
    super.dispose();
  }

  void restTimer(int n) {
    timer?.cancel();
    setState(() {
      rest = n;
      restTotal = n;
    });
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) return;
      if (rest <= 0) {
        t.cancel();
        return;
      }
      setState(() => rest--);
    });
  }

  void refresh() {
    ref.invalidate(sessionProvider(widget.id));
    ref.invalidate(dashboardProvider);
    ref.invalidate(readinessProvider);
  }

  Future<void> logSet(Exercise ex, WorkoutPlanItem item, int next) async {
    setState(() => busy = true);
    final saved = await guarded(
      context,
      () => client.workout.logSet(
        widget.id,
        ex.id!,
        next,
        int.tryParse(reps.text),
        double.tryParse(weight.text),
        int.tryParse(seconds.text),
        double.tryParse(effort.text),
      ),
    );
    if (!mounted) return;
    setState(() => busy = false);
    if (saved != null) {
      refresh();
      restTimer(item.restSeconds);
    }
  }

  Future<void> finish() async {
    var rpe = double.tryParse(effort.text)?.clamp(1, 10).toDouble() ?? 6;
    final notes = TextEditingController();
    final ok = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      constraints: const BoxConstraints(maxWidth: 560),
      builder: (c) => StatefulBuilder(
        builder: (c, set) => Padding(
          padding: EdgeInsets.fromLTRB(
            24,
            0,
            24,
            24 + MediaQuery.viewInsetsOf(c).bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Wrap up your session',
                style: Theme.of(c).textTheme.headlineSmall,
              ),
              const SizedBox(height: 18),
              Text(
                'How hard did it feel overall? ${rpe.toInt()}/10',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              Slider(
                value: rpe,
                min: 1,
                max: 10,
                divisions: 9,
                label: rpe.toInt().toString(),
                onChanged: (v) => set(() => rpe = v),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: notes,
                maxLines: 2,
                maxLength: 300,
                decoration: const InputDecoration(
                  labelText: 'Notes (optional)',
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: () => Navigator.pop(c, true),
                  icon: const Icon(Icons.flag_rounded),
                  label: const Text('Finish and save'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    final text = notes.text;
    notes.dispose();
    if (ok != true || !mounted) return;
    setState(() => busy = true);
    final result = await guarded(
      context,
      () => client.workout.finish(widget.id, text, rpe),
    );
    if (!mounted) return;
    setState(() => busy = false);
    if (result != null) {
      timer?.cancel();
      refresh();
      ref.invalidate(historyProvider);
      ref.invalidate(plansProvider);
      ref.invalidate(readinessTrendProvider);
    }
  }

  @override
  Widget build(BuildContext context) => PageBody(
    children: [
      AsyncPanel(
        value: ref.watch(sessionProvider(widget.id)),
        retry: () => ref.invalidate(sessionProvider(widget.id)),
        builder: (d) {
          if (d.plan.items.isEmpty || d.plan.exercises.isEmpty) {
            return EmptyCard(
              icon: Icons.fitness_center,
              title: 'No exercises in this session',
              message: 'Return to Workout and create a new plan.',
              action: OutlinedButton(
                onPressed: () => context.go('/workout'),
                child: const Text('Go to Workout'),
              ),
            );
          }
          final finished = d.session.endedAt != null;
          if (finished) return _Summary(d);
          final i = index.clamp(0, d.plan.items.length - 1);
          final item = d.plan.items[i];
          final ex = d.plan.exercises.firstWhere(
            (e) => e.id == item.exerciseId,
          );
          final sets = d.sets.where((s) => s.exerciseId == ex.id).toList();
          final previous = (d.previousSets ?? const <WorkoutSet>[])
              .where((s) => s.exerciseId == ex.id)
              .toList();
          final nextSet =
              sets.fold<int>(0, (n, s) => n > s.setNumber ? n : s.setNumber) +
              1;
          final targetSets = d.plan.items.fold<int>(
            0,
            (n, x) => n + x.targetSets,
          );
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PageTitle(
                'One set at a time',
                d.session.title,
                'Started ${friendlyDate(d.session.startedAt)}. Your sets are saved as you go.',
              ),
              Panel(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    RingGauge(
                      value: targetSets == 0 ? 0 : d.sets.length / targetSets,
                      size: 64,
                      stroke: 7,
                      gradient: GymTheme.brandGradient,
                      child: Text(
                        '${d.sets.length}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const SizedBox(width: 18),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${d.sets.length} of $targetSets planned sets',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${_kg(_volume(d.sets))} kg volume so far',
                            style: const TextStyle(color: GymTheme.muted),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (var j = 0; j < d.plan.items.length; j++)
                    Builder(
                      builder: (context) {
                        final item = d.plan.items[j];
                        final done =
                            d.sets
                                .where((s) => s.exerciseId == item.exerciseId)
                                .length >=
                            item.targetSets;
                        return ChoiceChip(
                          showCheckmark: false,
                          avatar: done
                              ? Icon(
                                  Icons.check_circle_rounded,
                                  size: 16,
                                  color: i == j ? GymTheme.bg : GymTheme.accent,
                                )
                              : null,
                          label: Text(
                            '${j + 1}. ${d.plan.exercises.firstWhere((e) => e.id == item.exerciseId).name}',
                          ),
                          labelStyle: TextStyle(
                            color: i == j ? GymTheme.bg : GymTheme.text,
                            fontWeight: FontWeight.w600,
                          ),
                          selected: i == j,
                          onSelected: (_) => setState(() => index = j),
                        );
                      },
                    ),
                ],
              ),
              const SizedBox(height: 18),
              Panel(
                padding: const EdgeInsets.all(26),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        StatusPill(
                          '${i + 1} / ${d.plan.items.length} EXERCISES',
                          dot: true,
                        ),
                        const Spacer(),
                        if (sets.isEmpty)
                          TextButton.icon(
                            onPressed: () async {
                              final updated = await swapExercise(
                                context,
                                d.plan,
                                item,
                              );
                              if (updated != null) {
                                ref.invalidate(sessionProvider(widget.id));
                              }
                            },
                            icon: const Icon(Icons.swap_horiz_rounded),
                            label: const Text('Alternatives'),
                          ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    Text(
                      ex.name,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      ex.instructions,
                      style: const TextStyle(
                        color: GymTheme.muted,
                        height: 1.55,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        StatusPill(
                          '${item.targetSets} × ${item.targetRepsText}',
                          icon: Icons.repeat_rounded,
                        ),
                        StatusPill(
                          '${item.restSeconds}s rest',
                          color: GymTheme.sky,
                          icon: Icons.timer_outlined,
                        ),
                      ],
                    ),
                    if (previous.isNotEmpty) ...[
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: GymTheme.violet.withValues(alpha: .08),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: GymTheme.violet.withValues(alpha: .25),
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.history_rounded,
                              size: 18,
                              color: GymTheme.violet,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                'Last time: ${previous.map((s) => s.durationSec != null && s.reps == null ? '${s.durationSec}s' : '${s.reps ?? 0}×${_kg(s.weightKg ?? 0)}kg').join(' · ')}',
                                style: const TextStyle(color: GymTheme.text),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    const SizedBox(height: 22),
                    AdaptiveGrid(
                      minTileWidth: 130,
                      spacing: 12,
                      children: [
                        TextField(
                          controller: reps,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(labelText: 'Reps'),
                        ),
                        TextField(
                          controller: weight,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          decoration: const InputDecoration(
                            labelText: 'Weight (kg)',
                          ),
                        ),
                        TextField(
                          controller: seconds,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Seconds (opt.)',
                          ),
                        ),
                        TextField(
                          controller: effort,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Effort 1–10',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    FilledButton.icon(
                      onPressed: busy ? null : () => logSet(ex, item, nextSet),
                      icon: const Icon(Icons.check_rounded),
                      label: Text(busy ? 'Saving…' : 'Log set $nextSet'),
                    ),
                    AnimatedSize(
                      duration: const Duration(milliseconds: 220),
                      child: rest > 0
                          ? Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: Container(
                                padding: const EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                  color: GymTheme.sky.withValues(alpha: .08),
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: GymTheme.sky.withValues(alpha: .25),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    RingGauge(
                                      value: restTotal == 0
                                          ? 0
                                          : rest / restTotal,
                                      color: GymTheme.sky,
                                      size: 42,
                                      stroke: 4,
                                      animate: false,
                                      child: const Icon(
                                        Icons.timer_outlined,
                                        size: 18,
                                        color: GymTheme.sky,
                                      ),
                                    ),
                                    const SizedBox(width: 14),
                                    Expanded(
                                      child: Text(
                                        'Take a breath • ${rest}s rest',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        timer?.cancel();
                                        setState(() => rest = 0);
                                      },
                                      child: const Text('Skip'),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : const SizedBox(width: double.infinity),
                    ),
                    const SizedBox(height: 18),
                    for (final s in sets)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: GymTheme.bgRaised,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: GymTheme.line),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.check_circle_rounded,
                                color: GymTheme.accent,
                                size: 20,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _setLine(s),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    if (s.durationSec != null || s.rpe != null)
                                      Text(
                                        [
                                          if (s.durationSec != null)
                                            '${s.durationSec} seconds',
                                          if (s.rpe != null)
                                            'effort ${s.rpe!.toStringAsFixed(0)}',
                                        ].join(' · '),
                                        style: const TextStyle(
                                          color: GymTheme.muted,
                                          fontSize: 12,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              IconButton(
                                tooltip: 'Remove set',
                                icon: const Icon(Icons.delete_outline_rounded),
                                onPressed: () async {
                                  await guarded(
                                    context,
                                    () => client.workout.deleteSet(s.id!),
                                  );
                                  ref.invalidate(sessionProvider(widget.id));
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    if (sets.isEmpty)
                      const Text(
                        'No sets logged for this exercise yet.',
                        style: TextStyle(color: GymTheme.muted),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  if (i > 0)
                    OutlinedButton.icon(
                      onPressed: () => setState(() => index = i - 1),
                      icon: const Icon(Icons.arrow_back_rounded),
                      label: const Text('Previous'),
                    ),
                  const Spacer(),
                  if (i < d.plan.items.length - 1)
                    OutlinedButton.icon(
                      onPressed: () => setState(() => index = i + 1),
                      icon: const Icon(Icons.arrow_forward_rounded),
                      label: const Text('Next exercise'),
                    ),
                ],
              ),
              const SizedBox(height: 22),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  FilledButton.icon(
                    onPressed: busy ? null : finish,
                    icon: const Icon(Icons.flag_rounded),
                    label: const Text('Finish workout'),
                  ),
                  OutlinedButton.icon(
                    onPressed: () =>
                        context.go('/workout?plan=${d.plan.plan.id}'),
                    icon: const Icon(Icons.list_alt_outlined),
                    label: const Text('View workout plan'),
                  ),
                  OutlinedButton.icon(
                    onPressed: () => context.go('/form'),
                    icon: const Icon(Icons.accessibility_new_rounded),
                    label: const Text('Open form coach'),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    ],
  );
}

class _Summary extends StatelessWidget {
  final SessionDetail d;
  const _Summary(this.d);
  @override
  Widget build(BuildContext context) {
    final volume = _volume(d.sets);
    final exercises = d.sets.map((s) => s.exerciseId).toSet();
    final previous = d.previousSets ?? const <WorkoutSet>[];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PageTitle(
          'SESSION COMPLETE',
          'That’s time well spent.',
          '${d.sets.length} sets saved • ${d.session.durationMin} minutes',
        ),
        Panel(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [GymTheme.accent.withValues(alpha: .16), GymTheme.surface],
          ),
          borderColor: GymTheme.accent.withValues(alpha: .3),
          child: Row(
            children: [
              const IconBadge(Icons.emoji_events_rounded, size: 56),
              const SizedBox(width: 18),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${_kg(volume)} kg total logged volume',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Your training-load estimate now reflects this session.',
                      style: TextStyle(color: GymTheme.muted),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        AdaptiveGrid(
          minTileWidth: 170,
          children: [
            StatTile(
              icon: Icons.timer_outlined,
              value: '${d.session.durationMin ?? 0}',
              label: 'minutes',
              color: GymTheme.sky,
            ),
            StatTile(
              icon: Icons.stacked_bar_chart_rounded,
              value: '${d.sets.length}',
              label: 'sets',
            ),
            StatTile(
              icon: Icons.fitness_center_rounded,
              value: '${exercises.length}/${d.plan.items.length}',
              label: 'exercises',
              color: GymTheme.mint,
            ),
            StatTile(
              icon: Icons.speed_rounded,
              value: d.session.perceivedEffort?.toStringAsFixed(0) ?? '—',
              label: 'session effort',
              color: GymTheme.orange,
            ),
          ],
        ),
        const SectionTitle('Exercise breakdown', icon: Icons.list_rounded),
        for (final item in d.plan.items)
          Builder(
            builder: (context) {
              final ex = d.plan.exercises
                  .where((e) => e.id == item.exerciseId)
                  .firstOrNull;
              final sets = d.sets
                  .where((s) => s.exerciseId == item.exerciseId)
                  .toList();
              final now = _volume(sets);
              final before = _volume(
                previous.where((s) => s.exerciseId == item.exerciseId),
              );
              final delta = before > 0 && now > 0
                  ? ((now - before) / before * 100).round()
                  : null;
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Panel(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              ex?.name ?? 'Exercise',
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          if (delta != null)
                            StatusPill(
                              '${delta >= 0 ? '+' : ''}$delta% VS LAST',
                              color: delta >= 0
                                  ? GymTheme.accent
                                  : GymTheme.orange,
                              icon: delta >= 0
                                  ? Icons.trending_up_rounded
                                  : Icons.trending_down_rounded,
                            )
                          else if (sets.isEmpty)
                            const StatusPill('SKIPPED', color: GymTheme.muted),
                        ],
                      ),
                      for (final s in sets) ...[
                        const SizedBox(height: 6),
                        Text(
                          _setLine(s),
                          style: const TextStyle(color: GymTheme.muted),
                        ),
                      ],
                    ],
                  ),
                ),
              );
            },
          ),
        if (d.session.notes.isNotEmpty) ...[
          const SectionTitle('Notes', icon: Icons.edit_note_rounded),
          Panel(child: Text(d.session.notes)),
        ],
        const SizedBox(height: 20),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            FilledButton(
              onPressed: () => context.go('/home'),
              child: const Text('Back to home'),
            ),
            OutlinedButton.icon(
              onPressed: () => context.go('/progress'),
              icon: const Icon(Icons.insights_outlined),
              label: const Text('See progress'),
            ),
            OutlinedButton.icon(
              onPressed: () => context.go('/form'),
              icon: const Icon(Icons.accessibility_new_rounded),
              label: const Text('Open form coach'),
            ),
          ],
        ),
      ],
    );
  }
}
