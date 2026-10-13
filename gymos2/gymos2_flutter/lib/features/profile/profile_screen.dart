import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gymos2_client/gymos2_client.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart'
    hide UserProfile;
import '../../client.dart';
import '../../core/providers.dart';
import '../../core/widgets.dart';
import '../../app/theme.dart';
import '../notifications/notifications_sheet.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  Future<void> edit(BuildContext context, WidgetRef ref, UserProfile p) async {
    final name = TextEditingController(text: p.displayName);
    var duration = p.preferredWorkoutDuration.toDouble();
    var experience = p.experienceLevel;
    var goal = p.primaryGoal;
    final ok = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      constraints: const BoxConstraints(maxWidth: 600),
      builder: (c) => StatefulBuilder(
        builder: (c, set) => Padding(
          padding: EdgeInsets.fromLTRB(
            24,
            0,
            24,
            24 + MediaQuery.viewInsetsOf(c).bottom,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Training preferences',
                  style: Theme.of(c).textTheme.headlineSmall,
                ),
                const SizedBox(height: 18),
                TextField(
                  controller: name,
                  decoration: const InputDecoration(labelText: 'Display name'),
                ),
                const SizedBox(height: 18),
                const Text(
                  'Experience',
                  style: TextStyle(color: GymTheme.muted),
                ),
                const SizedBox(height: 8),
                SegmentedButton<String>(
                  showSelectedIcon: false,
                  segments: const [
                    ButtonSegment(value: 'beginner', label: Text('Beginner')),
                    ButtonSegment(
                      value: 'intermediate',
                      label: Text('Intermediate'),
                    ),
                    ButtonSegment(value: 'advanced', label: Text('Advanced')),
                  ],
                  selected: {experience},
                  onSelectionChanged: (v) => set(() => experience = v.first),
                ),
                const SizedBox(height: 18),
                const Text('Focus', style: TextStyle(color: GymTheme.muted)),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final g in [
                      'general fitness',
                      'strength',
                      'endurance',
                      'mobility',
                      'consistency',
                    ])
                      ChoiceChip(
                        showCheckmark: false,
                        label: Text(titleCase(g)),
                        labelStyle: TextStyle(
                          color: goal == g ? GymTheme.bg : GymTheme.text,
                          fontWeight: FontWeight.w600,
                        ),
                        selected: goal == g,
                        onSelected: (_) => set(() => goal = g),
                      ),
                  ],
                ),
                const SizedBox(height: 18),
                Text(
                  'Session length · ${duration.toInt()} minutes',
                  style: const TextStyle(color: GymTheme.muted),
                ),
                Slider(
                  value: duration,
                  min: 10,
                  max: 90,
                  divisions: 16,
                  label: '${duration.toInt()} min',
                  onChanged: (v) => set(() => duration = v),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () => Navigator.pop(c, true),
                    child: const Text('Save preferences'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    if (ok == true && context.mounted) {
      final saved = await guarded(
        context,
        () => client.profile.updatePreferences(
          name.text,
          experience,
          goal,
          duration.toInt(),
        ),
      );
      if (saved != null) {
        ref.invalidate(profileProvider);
        ref.invalidate(dashboardProvider);
      }
    }
    name.dispose();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageBody(
    children: [
      const PageTitle(
        'Your space',
        'Keep it personal.',
        'Your preferences, community, and privacy in one place.',
      ),
      AsyncPanel(
        value: ref.watch(dashboardProvider),
        retry: () => ref.invalidate(dashboardProvider),
        builder: (d) {
          final admin = d.profile.role == 'admin';
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                child: Panel(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      GymTheme.violet.withValues(alpha: .12),
                      GymTheme.surface,
                      GymTheme.accent.withValues(alpha: .06),
                    ],
                  ),
                  padding: const EdgeInsets.all(26),
                  child: Wrap(
                    spacing: 22,
                    runSpacing: 18,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      AvatarBadge(d.profile.displayName, size: 76),
                      ConstrainedBox(
                        constraints: const BoxConstraints(minWidth: 220),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              d.profile.displayName,
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: [
                                StatusPill(
                                  d.profile.role.toUpperCase(),
                                  color: admin
                                      ? GymTheme.violet
                                      : GymTheme.accent,
                                  icon: admin
                                      ? Icons.verified_user_rounded
                                      : Icons.person_rounded,
                                ),
                                StatusPill(
                                  d.profile.experienceLevel.toUpperCase(),
                                  color: GymTheme.sky,
                                ),
                                StatusPill(
                                  d.profile.primaryGoal.toUpperCase(),
                                  color: GymTheme.mint,
                                ),
                                StatusPill(
                                  '${d.profile.preferredWorkoutDuration} MIN',
                                  color: GymTheme.orange,
                                  icon: Icons.timer_outlined,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      OutlinedButton.icon(
                        onPressed: () => edit(context, ref, d.profile),
                        icon: const Icon(Icons.tune_rounded),
                        label: const Text('Edit preferences'),
                      ),
                    ],
                  ),
                ),
              ),
              ResponsivePair(
                firstFlex: 1,
                secondFlex: 1,
                first: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SectionTitle(
                      'Your community',
                      icon: Icons.home_work_outlined,
                    ),
                    Panel(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            d.society.name,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            d.society.addressLabel,
                            style: const TextStyle(color: GymTheme.muted),
                          ),
                          const SizedBox(height: 18),
                          Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: GymTheme.bgRaised,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(color: GymTheme.line),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'INVITE CODE',
                                        style: TextStyle(
                                          color: GymTheme.subtle,
                                          fontSize: 10.5,
                                          letterSpacing: 1.5,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      SelectableText(
                                        d.society.inviteCode,
                                        style: const TextStyle(
                                          color: GymTheme.accent,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  tooltip: 'Copy invite code',
                                  onPressed: () async {
                                    await Clipboard.setData(
                                      ClipboardData(text: d.society.inviteCode),
                                    );
                                    if (context.mounted) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text('Invite code copied.'),
                                        ),
                                      );
                                    }
                                  },
                                  icon: const Icon(Icons.copy_rounded),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 12),
                          _LinkRow(
                            icon: Icons.sports_gymnastics_rounded,
                            label: admin
                                ? 'Manage equipment and maintenance'
                                : 'Explore your gym',
                            onTap: () => context.go('/equipment'),
                          ),
                          if (admin)
                            _LinkRow(
                              icon: Icons.admin_panel_settings_outlined,
                              label: 'Admin dashboard and members',
                              onTap: () => context.go('/admin'),
                            ),
                          _LinkRow(
                            icon: Icons.notifications_none_rounded,
                            label: 'Notifications',
                            onTap: () => showNotifications(context, ref),
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
                      'Privacy & about',
                      icon: Icons.shield_outlined,
                    ),
                    Panel(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Your movement stays yours.',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 14),
                          for (final (icon, text) in [
                            (
                              Icons.phone_android_rounded,
                              'Form photos are processed on-device and are not uploaded. Only derived metrics are saved.',
                            ),
                            (
                              Icons.lock_outline_rounded,
                              'Workout history and coach chats are private to your account. Admins see aggregates only.',
                            ),
                            (
                              Icons.monitor_heart_outlined,
                              'Readiness is an estimate from logged training, not a medical measurement. Photo checks are technique cues, not safety certification. Live rep counting is not included.',
                            ),
                            (
                              Icons.map_outlined,
                              'Maps use OpenStreetMap. Directions open Google Maps externally. External listings keep their source links.',
                            ),
                          ])
                            Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(icon, size: 18, color: GymTheme.accent),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      text,
                                      style: const TextStyle(
                                        color: GymTheme.muted,
                                        height: 1.55,
                                      ),
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
              const SizedBox(height: 24),
              OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  foregroundColor: GymTheme.coral,
                  side: BorderSide(
                    color: GymTheme.coral.withValues(alpha: .4),
                  ),
                ),
                onPressed: () async {
                  await guarded(context, () => client.auth.signOutDevice());
                },
                icon: const Icon(Icons.logout_rounded),
                label: const Text('Sign out'),
              ),
            ],
          );
        },
      ),
    ],
  );
}

class _LinkRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _LinkRow({
    required this.icon,
    required this.label,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) => ListTile(
    contentPadding: const EdgeInsets.symmetric(horizontal: 4),
    leading: Icon(icon, color: GymTheme.accent),
    title: Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
    trailing: const Icon(Icons.chevron_right_rounded),
    onTap: onTap,
  );
}
