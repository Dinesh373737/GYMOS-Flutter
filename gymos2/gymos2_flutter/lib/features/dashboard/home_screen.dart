import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gymos2_client/gymos2_client.dart';
import '../../app/theme.dart';
import '../../core/providers.dart';
import '../../core/widgets.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  static const weeklyTarget = 3;

  String greeting() {
    final h = DateTime.now().hour;
    return h < 12
        ? 'Good morning'
        : h < 17
        ? 'Good afternoon'
        : 'Good evening';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageBody(
    children: [
      AsyncPanel(
        value: ref.watch(dashboardProvider),
        retry: () => ref.invalidate(dashboardProvider),
        builder: (d) {
          final finished = d.recentSessions.where((s) => s.endedAt != null);
          final weekAgo = DateTime.now().subtract(const Duration(days: 7));
          final thisWeek = finished
              .where((s) => s.startedAt.toLocal().isAfter(weekAgo))
              .length;
          final ready = d.readiness
              .where((r) => r.readinessBand == 'READY')
              .length;
          final available = d.equipment
              .where((e) => e.status == 'available')
              .length;
          final first = d.profile.displayName.split(' ').first;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PageTitle(
                '${friendlyDate(DateTime.now(), time: false)} · ${d.society.name}',
                '${greeting()}, $first.',
                thisWeek == 0
                    ? 'A fresh week. One session gets the momentum going.'
                    : 'You’ve trained $thisWeek time${thisWeek == 1 ? '' : 's'} this week. Keep the rhythm.',
                action: d.profile.role == 'admin'
                    ? OutlinedButton.icon(
                        onPressed: () => context.go('/admin'),
                        icon: const Icon(Icons.admin_panel_settings_outlined),
                        label: const Text('Admin'),
                      )
                    : null,
              ),
              ResponsivePair(
                breakpoint: 820,
                first: _Hero(
                  minutes: d.profile.preferredWorkoutDuration,
                  goal: d.profile.primaryGoal,
                  available: available,
                  total: d.equipment.length,
                ),
                second: _WeekCard(
                  thisWeek: thisWeek,
                  target: weeklyTarget,
                  sessions: finished.toList(),
                ),
              ),
              const SizedBox(height: 18),
              AdaptiveGrid(
                minTileWidth: 190,
                children: [
                  StatTile(
                    icon: Icons.task_alt_rounded,
                    value: '${finished.length}',
                    label: 'Sessions finished',
                    onTap: () => context.go('/progress'),
                  ),
                  StatTile(
                    icon: Icons.stacked_bar_chart_rounded,
                    value: '${d.completedSets}',
                    label: 'Sets logged',
                    color: GymTheme.mint,
                    onTap: () => context.go('/progress'),
                  ),
                  StatTile(
                    icon: Icons.scale_rounded,
                    value: _compact(d.volumeKg),
                    label: 'kg total volume',
                    color: GymTheme.sky,
                    onTap: () => context.go('/progress'),
                  ),
                  StatTile(
                    icon: Icons.battery_charging_full_rounded,
                    value: '$ready/${d.readiness.length}',
                    label: 'Muscle groups ready',
                    color: GymTheme.violet,
                    onTap: () => context.go('/progress'),
                  ),
                ],
              ),
              SectionTitle(
                'Training readiness',
                icon: Icons.monitor_heart_outlined,
                action: TextButton(
                  onPressed: () => context.go('/progress'),
                  child: const Text('See trend →'),
                ),
              ),
              _ReadinessGrid(d.readiness),
              const SizedBox(height: 12),
              const Row(
                children: [
                  Icon(Icons.info_outline, size: 14, color: GymTheme.subtle),
                  SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      'Estimated from your logged training. Not a measure of biological recovery.',
                      style: TextStyle(color: GymTheme.subtle, fontSize: 12),
                    ),
                  ),
                ],
              ),
              ResponsivePair(
                firstFlex: 1,
                secondFlex: 1,
                first: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SectionTitle(
                      'Around your gym',
                      icon: Icons.sports_gymnastics_rounded,
                      action: TextButton(
                        onPressed: () => context.go('/equipment'),
                        child: const Text('See all →'),
                      ),
                    ),
                    _EquipmentNotices(d.equipment),
                  ],
                ),
                second: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SectionTitle(
                      'Better together',
                      icon: Icons.groups_2_outlined,
                      action: TextButton(
                        onPressed: () => context.go('/discover'),
                        child: const Text('Discover →'),
                      ),
                    ),
                    _EventTeaser(d.events),
                  ],
                ),
              ),
              if (d.recentSessions.isNotEmpty) ...[
                SectionTitle(
                  'Recent sessions',
                  icon: Icons.history_rounded,
                  action: TextButton(
                    onPressed: () => context.go('/progress'),
                    child: const Text('All history →'),
                  ),
                ),
                for (final s in d.recentSessions.take(3))
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _SessionRow(s),
                  ),
              ],
            ],
          );
        },
      ),
    ],
  );
}

String _compact(double v) =>
    v >= 10000 ? '${(v / 1000).toStringAsFixed(1)}k' : v.toStringAsFixed(0);

class _Hero extends StatelessWidget {
  final int minutes, available, total;
  final String goal;
  const _Hero({
    required this.minutes,
    required this.goal,
    required this.available,
    required this.total,
  });
  @override
  Widget build(BuildContext context) => Container(
    clipBehavior: Clip.antiAlias,
    decoration: BoxDecoration(
      gradient: GymTheme.brandGradient,
      borderRadius: BorderRadius.circular(30),
      boxShadow: GymTheme.glow(GymTheme.accent, strength: .22),
    ),
    child: Stack(
      children: [
        const Positioned(
          right: -70,
          top: -70,
          child: _Rings(size: 300, color: Color(0x1F0A0D0B)),
        ),
        Positioned(
          right: -18,
          bottom: -26,
          child: Transform.rotate(
            angle: -.35,
            child: const Icon(
              Icons.fitness_center_rounded,
              size: 120,
              color: Color(0x1A0A0D0B),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: GymTheme.bg.withValues(alpha: .1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'TODAY’S SESSION',
                  style: TextStyle(
                    color: GymTheme.bg,
                    fontSize: 10.5,
                    letterSpacing: 2,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(height: 22),
              Text(
                'Your time.\nYour next strong day.',
                style: GymTheme.display(
                  const TextStyle(
                    color: GymTheme.bg,
                    fontSize: 36,
                    height: 1.05,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -1.4,
                  ),
                ),
              ),
              const SizedBox(height: 14),
              const Text(
                'A plan shaped by your experience, recent load, and the equipment that’s free right now.',
                style: TextStyle(
                  color: Color(0xFF26331A),
                  height: 1.55,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 18),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _HeroChip(Icons.timer_outlined, '$minutes min'),
                  _HeroChip(Icons.flag_outlined, titleCase(goal)),
                  _HeroChip(
                    Icons.check_circle_outline,
                    '$available/$total equipment free',
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  FilledButton.icon(
                    style: FilledButton.styleFrom(
                      backgroundColor: GymTheme.bg,
                      foregroundColor: GymTheme.text,
                    ),
                    onPressed: () => context.go('/workout'),
                    icon: const Icon(Icons.arrow_forward_rounded),
                    label: const Text('Build today’s workout'),
                  ),
                  OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: GymTheme.bg,
                      side: BorderSide(
                        color: GymTheme.bg.withValues(alpha: .35),
                      ),
                    ),
                    onPressed: () => context.go('/coach'),
                    icon: const Icon(Icons.auto_awesome),
                    label: const Text('Ask the coach'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class _HeroChip extends StatelessWidget {
  final IconData icon;
  final String text;
  const _HeroChip(this.icon, this.text);
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: .28),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 15, color: GymTheme.bg),
        const SizedBox(width: 6),
        Text(
          text,
          style: const TextStyle(
            color: GymTheme.bg,
            fontWeight: FontWeight.w700,
            fontSize: 12.5,
          ),
        ),
      ],
    ),
  );
}

class _Rings extends StatelessWidget {
  final double size;
  final Color color;
  const _Rings({required this.size, required this.color});
  @override
  Widget build(BuildContext context) => SizedBox(
    width: size,
    height: size,
    child: Stack(
      alignment: Alignment.center,
      children: [
        for (var i = 0; i < 4; i++)
          Container(
            width: size - i * 60,
            height: size - i * 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: color, width: 14),
            ),
          ),
      ],
    ),
  );
}

class _WeekCard extends StatelessWidget {
  final int thisWeek, target;
  final List<WorkoutSession> sessions;
  const _WeekCard({
    required this.thisWeek,
    required this.target,
    required this.sessions,
  });
  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final days = [
      for (var i = 6; i >= 0; i--) today.subtract(Duration(days: i)),
    ];
    bool trained(DateTime day) => sessions.any((s) {
      final x = s.startedAt.toLocal();
      return x.year == day.year && x.month == day.month && x.day == day.day;
    });
    return Panel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const StatusPill('THIS WEEK', dot: true),
          const SizedBox(height: 18),
          Row(
            children: [
              RingGauge(
                value: thisWeek / target,
                size: 108,
                stroke: 11,
                gradient: GymTheme.brandGradient,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '$thisWeek',
                      style: GymTheme.display(
                        const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          color: GymTheme.text,
                          height: 1,
                        ),
                      ),
                    ),
                    Text(
                      'of $target',
                      style: const TextStyle(
                        color: GymTheme.muted,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      thisWeek >= target
                          ? 'Weekly goal reached'
                          : '${math.max(0, target - thisWeek)} to your weekly goal',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Consistency beats intensity. Small sessions count.',
                      style: TextStyle(color: GymTheme.muted, height: 1.5),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (final day in days)
                Column(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: trained(day) ? GymTheme.brandGradient : null,
                        color: trained(day) ? null : GymTheme.bgRaised,
                        border: Border.all(
                          color: day.day == today.day
                              ? GymTheme.accent
                              : GymTheme.line,
                        ),
                      ),
                      child: trained(day)
                          ? const Icon(
                              Icons.check_rounded,
                              size: 16,
                              color: GymTheme.bg,
                            )
                          : null,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'MTWTFSS'[day.weekday - 1],
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: day.day == today.day
                            ? GymTheme.accent
                            : GymTheme.subtle,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ReadinessGrid extends StatelessWidget {
  final List<TrainingReadiness> readiness;
  const _ReadinessGrid(this.readiness);
  @override
  Widget build(BuildContext context) {
    if (readiness.isEmpty) {
      return const EmptyCard(
        icon: Icons.monitor_heart_outlined,
        title: 'No load data yet',
        message: 'Log a workout to see estimated training load by muscle.',
      );
    }
    final sorted = [...readiness]
      ..sort((a, b) => b.trainingLoadScore.compareTo(a.trainingLoadScore));
    return AdaptiveGrid(
      minTileWidth: 200,
      spacing: 12,
      children: [
        for (final r in sorted.take(4))
          Panel(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                RingGauge(
                  value: r.trainingLoadScore / 100,
                  color: GymTheme.band(r.readinessBand),
                  size: 46,
                  stroke: 5,
                  child: Text(
                    r.trainingLoadScore.toStringAsFixed(0),
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        titleCase(r.muscleName),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        r.readinessBand,
                        style: TextStyle(
                          fontSize: 9.5,
                          letterSpacing: .6,
                          fontWeight: FontWeight.w800,
                          color: GymTheme.band(r.readinessBand),
                        ),
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
}

class _EquipmentNotices extends StatelessWidget {
  final List<SocietyEquipment> equipment;
  const _EquipmentNotices(this.equipment);
  @override
  Widget build(BuildContext context) {
    final notices = equipment.where((e) => e.status != 'available').toList();
    return Panel(
      padding: const EdgeInsets.all(20),
      child: notices.isEmpty
          ? const Row(
              children: [
                IconBadge(Icons.verified_rounded),
                SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your gym is ready',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'All listed equipment is available.',
                        style: TextStyle(color: GymTheme.muted),
                      ),
                    ],
                  ),
                ),
              ],
            )
          : Column(
              children: [
                for (final e in notices.take(3))
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Row(
                      children: [
                        IconBadge(
                          Icons.build_outlined,
                          color: GymTheme.status(e.status),
                          size: 40,
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                e.label,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                e.locationLabel,
                                style: const TextStyle(
                                  color: GymTheme.muted,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                        StatusPill(
                          e.status.toUpperCase(),
                          color: GymTheme.status(e.status),
                          dot: true,
                        ),
                      ],
                    ),
                  ),
                if (notices.length > 3)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '+${notices.length - 3} more',
                      style: const TextStyle(color: GymTheme.muted),
                    ),
                  ),
              ],
            ),
    );
  }
}

class _EventTeaser extends StatelessWidget {
  final List<CommunityEvent> events;
  const _EventTeaser(this.events);
  @override
  Widget build(BuildContext context) {
    if (events.isEmpty) {
      return Panel(
        padding: const EdgeInsets.all(20),
        onTap: () => context.go('/discover'),
        child: const Row(
          children: [
            IconBadge(Icons.event_available_outlined, color: GymTheme.sky),
            SizedBox(width: 14),
            Expanded(
              child: Text(
                'No upcoming community events yet. Explore nearby listings.',
                style: TextStyle(color: GymTheme.muted),
              ),
            ),
          ],
        ),
      );
    }
    final e = events.first;
    final (icon, color) = GymTheme.category(e.category);
    return Panel(
      padding: const EdgeInsets.all(20),
      onTap: () => context.go('/discover'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconBadge(icon, color: color),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      e.title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      friendlyDate(e.startsAt),
                      style: const TextStyle(color: GymTheme.muted),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              const Icon(
                Icons.place_outlined,
                size: 16,
                color: GymTheme.subtle,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  e.venueLabel,
                  style: const TextStyle(color: GymTheme.muted),
                ),
              ),
              StatusPill(
                e.isDemo ? 'DEMO' : 'COMMUNITY',
                color: e.isDemo ? GymTheme.orange : color,
              ),
            ],
          ),
          if (events.length > 1) ...[
            const SizedBox(height: 12),
            Text(
              '+${events.length - 1} more coming up',
              style: const TextStyle(color: GymTheme.subtle, fontSize: 12),
            ),
          ],
        ],
      ),
    );
  }
}

class _SessionRow extends StatelessWidget {
  final WorkoutSession s;
  const _SessionRow(this.s);
  @override
  Widget build(BuildContext context) {
    final done = s.endedAt != null;
    return Panel(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      onTap: () => context.go('/session/${s.id}'),
      child: Row(
        children: [
          IconBadge(
            done ? Icons.check_rounded : Icons.play_arrow_rounded,
            color: done ? GymTheme.accent : GymTheme.orange,
            size: 38,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  s.title,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                Text(
                  relativeDay(s.startedAt),
                  style: const TextStyle(color: GymTheme.muted, fontSize: 13),
                ),
              ],
            ),
          ),
          Text(
            done ? '${s.durationMin ?? 0} min' : 'In progress',
            style: TextStyle(
              color: done ? GymTheme.muted : GymTheme.orange,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.chevron_right_rounded, color: GymTheme.subtle),
        ],
      ),
    );
  }
}
