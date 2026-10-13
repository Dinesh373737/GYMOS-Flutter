import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gymos2_client/gymos2_client.dart';
import '../../client.dart';
import '../../app/theme.dart';
import '../../core/providers.dart';
import '../../core/widgets.dart';
import 'swap_sheet.dart';

class WorkoutScreen extends ConsumerStatefulWidget {
  final int? planId;
  const WorkoutScreen({super.key, this.planId});
  @override
  ConsumerState<WorkoutScreen> createState() => _State();
}

class _State extends ConsumerState<WorkoutScreen> {
  static const focuses = [
    ('full body', Icons.accessibility_new_rounded),
    ('push', Icons.north_east_rounded),
    ('pull', Icons.south_west_rounded),
    ('squat', Icons.airline_seat_legroom_extra_rounded),
    ('hinge', Icons.sports_gymnastics_rounded),
    ('core', Icons.center_focus_strong_rounded),
    ('cardio', Icons.monitor_heart_outlined),
  ];
  double minutes = 40;
  String focus = 'full body';
  bool busy = false;
  PlanDetail? plan;
  @override
  void initState() {
    super.initState();
    if (widget.planId != null) load(widget.planId!);
  }

  Future<void> load(int id) async {
    final result = await guarded(context, () => client.workout.getPlan(id));
    if (mounted) setState(() => plan = result);
  }

  Future<void> swap(WorkoutPlanItem item) async {
    final result = await swapExercise(context, plan!, item);
    if (mounted && result != null) setState(() => plan = result);
  }

  Future<void> generate() async {
    setState(() => busy = true);
    final result = await guarded(
      context,
      () => client.workout.generate(minutes.toInt(), focus),
    );
    if (mounted) {
      setState(() {
        busy = false;
        if (result != null) plan = result;
      });
    }
    ref.invalidate(plansProvider);
  }

  @override
  Widget build(BuildContext context) => PageBody(
    children: [
      const PageTitle(
        'Show up for yourself',
        'A session that fits.',
        'Choose your time and focus. The planner checks equipment, recent load and history.',
      ),
      ResponsivePair(
        first: Panel(
          padding: const EdgeInsets.all(26),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${minutes.toInt()}',
                    style: GymTheme.display(
                      const TextStyle(
                        fontSize: 54,
                        fontWeight: FontWeight.w700,
                        color: GymTheme.text,
                        height: 1,
                        letterSpacing: -2,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 8, bottom: 8),
                    child: Text(
                      'minutes',
                      style: TextStyle(color: GymTheme.muted, fontSize: 16),
                    ),
                  ),
                  const Spacer(),
                  const StatusPill('TIME BUDGET', color: GymTheme.mint),
                ],
              ),
              Slider(
                value: minutes,
                min: 10,
                max: 90,
                divisions: 16,
                label: '${minutes.toInt()} minutes',
                onChanged: (v) => setState(() => minutes = v),
              ),
              const SizedBox(height: 8),
              const Text(
                'FOCUS',
                style: TextStyle(
                  color: GymTheme.subtle,
                  fontSize: 11,
                  letterSpacing: 1.6,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final (f, icon) in focuses)
                    ChoiceChip(
                      showCheckmark: false,
                      avatar: Icon(
                        icon,
                        size: 16,
                        color: focus == f ? GymTheme.bg : GymTheme.muted,
                      ),
                      label: Text(f),
                      labelStyle: TextStyle(
                        color: focus == f ? GymTheme.bg : GymTheme.text,
                        fontWeight: FontWeight.w600,
                      ),
                      selected: focus == f,
                      onSelected: (_) => setState(() => focus = f),
                    ),
                ],
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: busy ? null : generate,
                  icon: busy
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.auto_awesome),
                  label: Text(
                    busy ? 'Building your session…' : 'Generate my workout',
                  ),
                ),
              ),
            ],
          ),
        ),
        second: Panel(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'How your plan is built',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 18),
              for (final (icon, color, title, body) in [
                (
                  Icons.sports_gymnastics_rounded,
                  GymTheme.sky,
                  'Available equipment',
                  'Items under maintenance are excluded automatically.',
                ),
                (
                  Icons.monitor_heart_outlined,
                  GymTheme.orange,
                  'Recent training load',
                  'Muscles with high recent load are given a rest.',
                ),
                (
                  Icons.history_rounded,
                  GymTheme.violet,
                  'Your history',
                  'Favors variety and ranks recently skipped moves lower.',
                ),
                (
                  Icons.accessibility_new_rounded,
                  GymTheme.mint,
                  'Form-check cues',
                  'Moves needing attention get a technique note.',
                ),
              ])
                Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconBadge(icon, color: color, size: 36),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              body,
                              style: const TextStyle(
                                color: GymTheme.muted,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
      if (plan != null) ...[
        const SizedBox(height: 30),
        SizedBox(width: double.infinity, child: _PlanHeader(plan!)),
        const SizedBox(height: 16),
        for (var i = 0; i < plan!.items.length; i++)
          _PlanItem(
            index: i,
            last: i == plan!.items.length - 1,
            item: plan!.items[i],
            exercise: plan!.exercises
                .where((e) => e.id == plan!.items[i].exerciseId)
                .firstOrNull,
            onSwap: plan!.plan.status == 'draft'
                ? () => swap(plan!.items[i])
                : null,
          ),
        const SizedBox(height: 8),
        if (plan!.plan.status != 'completed')
          FilledButton.icon(
            onPressed: busy
                ? null
                : () async {
                    setState(() => busy = true);
                    final session = await guarded(
                      context,
                      () => client.workout.start(plan!.plan.id!),
                    );
                    if (mounted) {
                      setState(() => busy = false);
                      if (session != null && context.mounted) {
                        context.go('/session/${session.id}');
                      }
                    }
                  },
            icon: const Icon(Icons.play_arrow_rounded),
            label: Text(
              plan!.plan.status == 'active'
                  ? 'Resume workout'
                  : 'Start this workout',
            ),
          ),
      ] else ...[
        const SectionTitle(
          'Your next session starts here',
          icon: Icons.bolt_rounded,
        ),
        const EmptyCard(
          icon: Icons.fitness_center,
          title: 'A plan with a reason',
          message:
              'Every exercise comes with a short rationale based on your gym, your load and your history.',
        ),
      ],
      ResponsivePair(
        firstFlex: 1,
        secondFlex: 1,
        first: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionTitle('Saved plans', icon: Icons.bookmark_outline),
            AsyncPanel(
              value: ref.watch(plansProvider),
              retry: () => ref.invalidate(plansProvider),
              builder: (plans) => plans.isEmpty
                  ? const Text(
                      'Your generated plans will appear here.',
                      style: TextStyle(color: GymTheme.muted),
                    )
                  : Column(
                      children: [
                        for (final p in plans.take(6))
                          _ListRow(
                            icon: p.createdByType == 'agent'
                                ? Icons.auto_awesome
                                : Icons.list_alt_rounded,
                            color: p.createdByType == 'agent'
                                ? GymTheme.violet
                                : GymTheme.accent,
                            title: p.title,
                            subtitle: relativeDay(p.createdAt),
                            trailing: StatusPill(
                              p.status.toUpperCase(),
                              color: GymTheme.status(p.status),
                            ),
                            onTap: () => load(p.id!),
                          ),
                      ],
                    ),
            ),
          ],
        ),
        second: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionTitle(
              'Your training journal',
              icon: Icons.menu_book_outlined,
            ),
            AsyncPanel(
              value: ref.watch(historyProvider),
              retry: () => ref.invalidate(historyProvider),
              builder: (list) => list.isEmpty
                  ? const Text(
                      'Finish your first session to begin your journal.',
                      style: TextStyle(color: GymTheme.muted),
                    )
                  : Column(
                      children: [
                        for (final x in list.take(6))
                          _ListRow(
                            icon: x.endedAt == null
                                ? Icons.play_arrow_rounded
                                : Icons.check_rounded,
                            color: x.endedAt == null
                                ? GymTheme.orange
                                : GymTheme.accent,
                            title: x.title,
                            subtitle: relativeDay(x.startedAt),
                            trailing: Text(
                              x.endedAt == null
                                  ? 'In progress'
                                  : '${x.durationMin} min',
                              style: const TextStyle(color: GymTheme.muted),
                            ),
                            onTap: () => context.go('/session/${x.id}'),
                          ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    ],
  );
}

class _PlanHeader extends StatelessWidget {
  final PlanDetail plan;
  const _PlanHeader(this.plan);
  @override
  Widget build(BuildContext context) {
    final sets = plan.items.fold<int>(0, (n, i) => n + i.targetSets);
    return Panel(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [GymTheme.accent.withValues(alpha: .12), GymTheme.surface],
      ),
      borderColor: GymTheme.accent.withValues(alpha: .25),
      child: Wrap(
        spacing: 24,
        runSpacing: 16,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  StatusPill(
                    plan.plan.status.toUpperCase(),
                    color: GymTheme.status(plan.plan.status),
                    dot: true,
                  ),
                  if (plan.plan.createdByType == 'agent') ...[
                    const SizedBox(width: 8),
                    const StatusPill(
                      'BY COACH',
                      color: GymTheme.violet,
                      icon: Icons.auto_awesome,
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 10),
              Text(
                plan.plan.title,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
          for (final (value, label) in [
            ('${plan.plan.plannedDurationMin}', 'minutes'),
            ('${plan.items.length}', 'exercises'),
            ('$sets', 'sets'),
          ])
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: GymTheme.display(
                    const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: GymTheme.text,
                    ),
                  ),
                ),
                Text(label, style: const TextStyle(color: GymTheme.muted)),
              ],
            ),
        ],
      ),
    );
  }
}

class _PlanItem extends StatelessWidget {
  final int index;
  final bool last;
  final WorkoutPlanItem item;
  final Exercise? exercise;
  final VoidCallback? onSwap;
  const _PlanItem({
    required this.index,
    required this.last,
    required this.item,
    required this.exercise,
    required this.onSwap,
  });
  @override
  Widget build(BuildContext context) => IntrinsicHeight(
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          width: 44,
          child: Column(
            children: [
              Container(
                width: 36,
                height: 36,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: GymTheme.brandGradient,
                  shape: BoxShape.circle,
                  boxShadow: GymTheme.glow(GymTheme.accent, strength: .2),
                ),
                child: Text(
                  '${index + 1}'.padLeft(2, '0'),
                  style: const TextStyle(
                    color: GymTheme.bg,
                    fontWeight: FontWeight.w800,
                    fontSize: 12,
                  ),
                ),
              ),
              if (!last)
                Expanded(
                  child: Container(
                    width: 2,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    color: GymTheme.line,
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Panel(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          exercise?.name ?? 'Exercise',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      if (onSwap != null)
                        IconButton.filledTonal(
                          tooltip: 'Swap exercise',
                          onPressed: onSwap,
                          icon: const Icon(Icons.swap_horiz_rounded),
                        ),
                    ],
                  ),
                  const SizedBox(height: 10),
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
                      if (exercise != null) ...[
                        StatusPill(
                          exercise!.movementPattern.toUpperCase(),
                          color: GymTheme.muted,
                        ),
                        StatusPill(
                          exercise!.difficulty.toUpperCase(),
                          color: GymTheme.muted,
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    item.rationale,
                    style: const TextStyle(color: GymTheme.muted, height: 1.5),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

class _ListRow extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title, subtitle;
  final Widget trailing;
  final VoidCallback onTap;
  const _ListRow({
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
    required this.trailing,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Panel(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      onTap: onTap,
      child: Row(
        children: [
          IconBadge(icon, color: color, size: 36),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(color: GymTheme.muted, fontSize: 12.5),
                ),
              ],
            ),
          ),
          trailing,
        ],
      ),
    ),
  );
}
