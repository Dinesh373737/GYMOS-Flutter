import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gymos2_client/gymos2_client.dart';
import '../../app/theme.dart';
import '../../client.dart';
import '../../core/providers.dart';
import '../../core/widgets.dart';

class AdminScreen extends ConsumerWidget {
  const AdminScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final admin = ref.watch(profileProvider).value?.role == 'admin';
    return PageBody(
      children: [
        PageTitle(
          'Society admin',
          'Your community at a glance.',
          'Members, equipment health, maintenance and events. Aggregates only — private workouts stay private.',
          action: IconButton.filledTonal(
            tooltip: 'Refresh',
            onPressed: () {
              ref.invalidate(adminStatsProvider);
              ref.invalidate(membersProvider);
            },
            icon: const Icon(Icons.refresh_rounded),
          ),
        ),
        if (!admin)
          const EmptyCard(
            icon: Icons.lock_outline_rounded,
            title: 'Admins only',
            message:
                'Society administrators can manage members and equipment here.',
          )
        else ...[
          AsyncPanel(
            value: ref.watch(adminStatsProvider),
            retry: () => ref.invalidate(adminStatsProvider),
            builder: (s) => _Overview(s),
          ),
          const SectionTitle('Members', icon: Icons.groups_rounded),
          AsyncPanel(
            value: ref.watch(membersProvider),
            retry: () => ref.invalidate(membersProvider),
            builder: (list) => _Members(list),
          ),
        ],
      ],
    );
  }
}

class _Overview extends StatelessWidget {
  final AdminStats s;
  const _Overview(this.s);
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      AdaptiveGrid(
        minTileWidth: 200,
        children: [
          StatTile(
            icon: Icons.groups_2_rounded,
            value: '${s.activeMembers}',
            label: 'Active members',
            hint: '${s.adminCount} admin${s.adminCount == 1 ? '' : 's'}',
          ),
          StatTile(
            icon: Icons.local_fire_department_rounded,
            value: '${s.workoutsThisWeek}',
            label: 'Workouts this week',
            color: GymTheme.mint,
            hint: '${s.activeTrainersThisWeek} training',
          ),
          StatTile(
            icon: Icons.fitness_center_rounded,
            value: '${s.equipmentAvailable}/${s.equipmentTotal}',
            label: 'Equipment available',
            color: GymTheme.sky,
            onTap: () => context.go('/equipment'),
          ),
          StatTile(
            icon: Icons.build_circle_outlined,
            value: '${s.openIssues + s.inProgressIssues}',
            label: 'Open maintenance',
            color: s.highSeverityOpen > 0 ? GymTheme.coral : GymTheme.orange,
            hint: s.highSeverityOpen > 0 ? '${s.highSeverityOpen} high' : null,
            onTap: () => context.go('/equipment'),
          ),
          StatTile(
            icon: Icons.event_available_rounded,
            value: '${s.upcomingEvents}',
            label: 'Upcoming events',
            color: GymTheme.violet,
            hint: '${s.eventParticipants} joined',
            onTap: () => context.go('/discover'),
          ),
        ],
      ),
      const SizedBox(height: 18),
      ResponsivePair(
        first: Panel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Community activity',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 4),
              const Text(
                'Finished workouts across the society, last 14 days',
                style: TextStyle(color: GymTheme.muted),
              ),
              const SizedBox(height: 24),
              SizedBox(height: 180, child: _ActivityChart(s.dailyWorkouts)),
            ],
          ),
        ),
        second: Panel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Equipment health',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 20),
              for (final (label, count, color) in [
                ('Available', s.equipmentAvailable, GymTheme.accent),
                ('Under maintenance', s.equipmentMaintenance, GymTheme.orange),
                ('Unavailable', s.equipmentUnavailable, GymTheme.coral),
              ])
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: MetricBar(
                    label: label,
                    trailing: '$count',
                    value: s.equipmentTotal == 0 ? 0 : count / s.equipmentTotal,
                    color: color,
                  ),
                ),
              const Divider(height: 22),
              Text(
                '${s.resolvedIssues30d} issue${s.resolvedIssues30d == 1 ? '' : 's'} resolved in the last 30 days',
                style: const TextStyle(color: GymTheme.muted),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () => context.go('/equipment'),
                child: const Text('Open maintenance board →'),
              ),
            ],
          ),
        ),
      ),
      const SizedBox(height: 18),
      Panel(
        child: Row(
          children: [
            const IconBadge(Icons.key_rounded, color: GymTheme.violet),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'INVITE CODE',
                    style: TextStyle(
                      color: GymTheme.muted,
                      fontSize: 11,
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  SelectableText(
                    s.society.inviteCode,
                    style: GymTheme.display(
                      const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: GymTheme.text,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            OutlinedButton.icon(
              onPressed: () async {
                await Clipboard.setData(
                  ClipboardData(text: s.society.inviteCode),
                );
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Invite code copied.')),
                  );
                }
              },
              icon: const Icon(Icons.copy_rounded, size: 18),
              label: const Text('Copy'),
            ),
          ],
        ),
      ),
    ],
  );
}

class _ActivityChart extends StatelessWidget {
  final List<int> daily;
  const _ActivityChart(this.daily);
  @override
  Widget build(BuildContext context) {
    final max = daily.fold<int>(0, (a, b) => a > b ? a : b);
    final start = DateTime.now().subtract(Duration(days: daily.length - 1));
    return BarChart(
      BarChartData(
        maxY: (max + 1).toDouble(),
        borderData: FlBorderData(show: false),
        gridData: FlGridData(
          drawVerticalLine: false,
          horizontalInterval: max < 4 ? 1 : (max / 4).ceilToDouble(),
          getDrawingHorizontalLine: (_) =>
              const FlLine(color: GymTheme.line, strokeWidth: 1),
        ),
        titlesData: FlTitlesData(
          topTitles: const AxisTitles(),
          rightTitles: const AxisTitles(),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 26,
              interval: max < 4 ? 1 : (max / 4).ceilToDouble(),
              getTitlesWidget: (v, _) => Text(
                v.toInt().toString(),
                style: const TextStyle(color: GymTheme.subtle, fontSize: 11),
              ),
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 24,
              getTitlesWidget: (v, _) {
                final i = v.toInt();
                if (i % 2 != 0) return const SizedBox.shrink();
                final d = start.add(Duration(days: i));
                return Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(
                    '${d.day}/${d.month}',
                    style: const TextStyle(
                      color: GymTheme.subtle,
                      fontSize: 10,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
            getTooltipColor: (_) => GymTheme.surfaceHigh,
            getTooltipItem: (group, _, rod, _) => BarTooltipItem(
              '${rod.toY.toInt()} workouts',
              const TextStyle(color: GymTheme.text, fontSize: 12),
            ),
          ),
        ),
        barGroups: [
          for (var i = 0; i < daily.length; i++)
            BarChartGroupData(
              x: i,
              barRods: [
                BarChartRodData(
                  toY: daily[i].toDouble(),
                  width: 14,
                  gradient: const LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [GymTheme.mint, GymTheme.accent],
                  ),
                  borderRadius: BorderRadius.circular(5),
                  backDrawRodData: BackgroundBarChartRodData(
                    show: true,
                    toY: (max + 1).toDouble(),
                    color: GymTheme.bgRaised,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class _Members extends ConsumerWidget {
  final List<MemberSummary> members;
  const _Members(this.members);

  Future<void> update(
    BuildContext context,
    WidgetRef ref,
    MemberSummary m, {
    String? role,
    bool? active,
  }) async {
    final result = await guarded(
      context,
      () => client.admin.updateMember(
        m.profileId,
        role ?? m.role,
        active ?? m.isActive,
      ),
    );
    if (result != null) {
      ref.invalidate(membersProvider);
      ref.invalidate(adminStatsProvider);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${m.displayName} updated.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final me = ref.watch(profileProvider).value?.id;
    if (members.isEmpty) {
      return const EmptyCard(
        icon: Icons.group_add_outlined,
        title: 'No members yet',
        message: 'Share the invite code so residents can join.',
      );
    }
    return Panel(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Column(
        children: [
          for (var i = 0; i < members.length; i++) ...[
            if (i > 0) const Divider(height: 1),
            LayoutBuilder(
              builder: (context, c) {
                final m = members[i];
                final narrow = c.maxWidth < 560;
                final controls = Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SegmentedButton<String>(
                      showSelectedIcon: false,
                      segments: const [
                        ButtonSegment(value: 'resident', label: Text('Member')),
                        ButtonSegment(value: 'admin', label: Text('Admin')),
                      ],
                      selected: {m.role == 'admin' ? 'admin' : 'resident'},
                      onSelectionChanged: (v) =>
                          update(context, ref, m, role: v.first),
                    ),
                    const SizedBox(width: 10),
                    Tooltip(
                      message: m.isActive
                          ? 'Pause membership'
                          : 'Reactivate membership',
                      child: Switch(
                        value: m.isActive,
                        onChanged: m.profileId == me
                            ? null
                            : (v) => update(context, ref, m, active: v),
                      ),
                    ),
                  ],
                );
                final info = Row(
                  children: [
                    AvatarBadge(
                      m.displayName,
                      size: 40,
                      gradient: m.role == 'admin'
                          ? GymTheme.coachGradient
                          : GymTheme.brandGradient,
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  m.displayName,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              if (m.profileId == me) ...[
                                const SizedBox(width: 8),
                                const StatusPill('YOU', color: GymTheme.sky),
                              ],
                              if (!m.isActive) ...[
                                const SizedBox(width: 8),
                                const StatusPill(
                                  'PAUSED',
                                  color: GymTheme.coral,
                                ),
                              ],
                            ],
                          ),
                          const SizedBox(height: 3),
                          Text(
                            'Joined ${friendlyDate(m.joinedAt, time: false)} · ${m.workoutsLast30Days} workouts in 30 days',
                            style: const TextStyle(
                              color: GymTheme.muted,
                              fontSize: 12.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  child: narrow
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            info,
                            const SizedBox(height: 12),
                            controls,
                          ],
                        )
                      : Row(
                          children: [
                            Expanded(child: info),
                            controls,
                          ],
                        ),
                );
              },
            ),
          ],
        ],
      ),
    );
  }
}
