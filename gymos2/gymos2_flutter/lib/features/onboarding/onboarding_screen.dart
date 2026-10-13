import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../app/theme.dart';
import '../../client.dart';
import '../../core/providers.dart';
import '../../core/widgets.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});
  @override
  ConsumerState<OnboardingScreen> createState() => _State();
}

class _State extends ConsumerState<OnboardingScreen> {
  final name = TextEditingController(), invite = TextEditingController();
  String experience = 'beginner', goal = 'general fitness';
  double duration = 40;
  bool demo = true, busy = false;

  static const levels = [
    ('beginner', 'Beginner', 'New or returning', Icons.spa_outlined),
    ('intermediate', 'Intermediate', 'Train most weeks', Icons.trending_up),
    ('advanced', 'Advanced', 'Years of practice', Icons.whatshot_outlined),
  ];
  static const goals = [
    ('general fitness', Icons.favorite_outline),
    ('strength', Icons.fitness_center_rounded),
    ('endurance', Icons.directions_run_rounded),
    ('mobility', Icons.self_improvement_rounded),
    ('consistency', Icons.event_repeat_rounded),
  ];

  @override
  void dispose() {
    name.dispose();
    invite.dispose();
    super.dispose();
  }

  Future<void> submit() async {
    setState(() => busy = true);
    final p = await guarded(
      context,
      () => client.profile.completeOnboarding(
        name.text,
        invite.text,
        demo,
        experience,
        goal,
        duration.toInt(),
      ),
    );
    if (!mounted) return;
    setState(() => busy = false);
    if (p != null) {
      ref.invalidate(profileProvider);
      ref.invalidate(dashboardProvider);
      if (mounted) context.go('/home');
    }
  }

  Widget step(int n, String title, Widget child) => Padding(
    padding: const EdgeInsets.only(bottom: 26),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 26,
              height: 26,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                gradient: GymTheme.brandGradient,
                shape: BoxShape.circle,
              ),
              child: Text(
                '$n',
                style: const TextStyle(
                  color: GymTheme.bg,
                  fontWeight: FontWeight.w800,
                  fontSize: 13,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(title, style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
        const SizedBox(height: 14),
        child,
      ],
    ),
  );

  @override
  Widget build(BuildContext context) => Scaffold(
    body: AmbientBackground(
      child: PageBody(
        children: [
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 680),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const PageTitle(
                    'Make it yours',
                    'Train on your terms.',
                    'A few details help us build sessions that fit your day. You can change them any time.',
                  ),
                  Panel(
                    padding: const EdgeInsets.all(28),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        step(
                          1,
                          'What should we call you?',
                          TextField(
                            controller: name,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                              labelText: 'Your name',
                              prefixIcon: Icon(Icons.badge_outlined),
                            ),
                          ),
                        ),
                        step(
                          2,
                          'Your training experience',
                          AdaptiveGrid(
                            minTileWidth: 170,
                            spacing: 10,
                            children: [
                              for (final (value, label, hint, icon) in levels)
                                _Choice(
                                  icon: icon,
                                  title: label,
                                  subtitle: hint,
                                  selected: experience == value,
                                  onTap: () =>
                                      setState(() => experience = value),
                                ),
                            ],
                          ),
                        ),
                        step(
                          3,
                          'Your focus',
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              for (final (value, icon) in goals)
                                ChoiceChip(
                                  showCheckmark: false,
                                  avatar: Icon(
                                    icon,
                                    size: 17,
                                    color: goal == value
                                        ? GymTheme.bg
                                        : GymTheme.muted,
                                  ),
                                  label: Text(titleCase(value)),
                                  labelStyle: TextStyle(
                                    color: goal == value
                                        ? GymTheme.bg
                                        : GymTheme.text,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  selected: goal == value,
                                  onSelected: (_) =>
                                      setState(() => goal = value),
                                ),
                            ],
                          ),
                        ),
                        step(
                          4,
                          'Preferred session length',
                          Row(
                            children: [
                              Text(
                                '${duration.toInt()}',
                                style: GymTheme.display(
                                  const TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.w700,
                                    color: GymTheme.accent,
                                    letterSpacing: -1.5,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 6),
                              const Text(
                                'min',
                                style: TextStyle(color: GymTheme.muted),
                              ),
                              Expanded(
                                child: Slider(
                                  value: duration,
                                  min: 10,
                                  max: 90,
                                  divisions: 16,
                                  label: '${duration.toInt()} min',
                                  onChanged: (v) =>
                                      setState(() => duration = v),
                                ),
                              ),
                            ],
                          ),
                        ),
                        step(
                          5,
                          'Your community',
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              AdaptiveGrid(
                                minTileWidth: 240,
                                spacing: 10,
                                children: [
                                  _Choice(
                                    icon: Icons.add_home_work_outlined,
                                    title: 'Create my demo community',
                                    subtitle:
                                        'Own a demo gym with labeled sample equipment and events.',
                                    selected: demo,
                                    onTap: () => setState(() => demo = true),
                                  ),
                                  _Choice(
                                    icon: Icons.vpn_key_outlined,
                                    title: 'Join with an invite code',
                                    subtitle:
                                        'Your society admin shares this from their profile.',
                                    selected: !demo,
                                    onTap: () => setState(() => demo = false),
                                  ),
                                ],
                              ),
                              AnimatedSize(
                                duration: const Duration(milliseconds: 200),
                                child: demo
                                    ? const SizedBox(width: double.infinity)
                                    : Padding(
                                        padding: const EdgeInsets.only(
                                          top: 14,
                                        ),
                                        child: TextField(
                                          controller: invite,
                                          decoration: const InputDecoration(
                                            labelText: 'Society invite code',
                                            prefixIcon: Icon(Icons.key_rounded),
                                          ),
                                        ),
                                      ),
                              ),
                            ],
                          ),
                        ),
                        FilledButton.icon(
                          onPressed: busy ? null : submit,
                          icon: busy
                              ? const SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Icon(Icons.arrow_forward_rounded),
                          label: Text(
                            busy ? 'Setting things up…' : 'Let’s get moving',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

class _Choice extends StatelessWidget {
  final IconData icon;
  final String title, subtitle;
  final bool selected;
  final VoidCallback onTap;
  const _Choice({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.selected,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) => Semantics(
    selected: selected,
    button: true,
    child: Panel(
      onTap: onTap,
      padding: const EdgeInsets.all(16),
      color: selected ? GymTheme.accent.withValues(alpha: .08) : null,
      borderColor: selected ? GymTheme.accent : null,
      child: Row(
        children: [
          IconBadge(
            icon,
            color: selected ? GymTheme.accent : GymTheme.muted,
            size: 40,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(color: GymTheme.muted, fontSize: 12.5),
                ),
              ],
            ),
          ),
          if (selected)
            const Icon(Icons.check_circle_rounded, color: GymTheme.accent),
        ],
      ),
    ),
  );
}
