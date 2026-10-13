import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import '../client.dart';
import '../core/providers.dart';
import '../core/widgets.dart';
import '../features/admin/admin_screen.dart';
import '../features/auth/auth_screen.dart';
import '../features/notifications/notifications_sheet.dart';
import '../features/onboarding/onboarding_screen.dart';
import '../features/dashboard/home_screen.dart';
import '../features/workouts/workout_screen.dart';
import '../features/workouts/session_screen.dart';
import '../features/form_coach/form_screen.dart';
import '../features/events/discover_screen.dart';
import '../features/profile/profile_screen.dart';
import '../features/equipment/equipment_screen.dart';
import '../features/agent/agent_screen.dart';
import '../features/progress/progress_screen.dart';
import 'theme.dart';

class GymApp extends ConsumerStatefulWidget {
  const GymApp({super.key});
  @override
  ConsumerState<GymApp> createState() => _GymAppState();
}

/// Signed-out users only see `/auth`; signed-in users skip it.
String? authRedirect(bool signedIn, String location) {
  if (!signedIn) return location == '/auth' ? null : '/auth';
  if (location == '/auth') return '/home';
  return null;
}

Page<void> _fade(GoRouterState s, Widget child) => CustomTransitionPage<void>(
  key: s.pageKey,
  child: child,
  transitionDuration: const Duration(milliseconds: 260),
  reverseTransitionDuration: const Duration(milliseconds: 180),
  transitionsBuilder: (context, animation, _, child) => FadeTransition(
    opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
    child: ScaleTransition(
      scale: Tween(begin: .985, end: 1.0).animate(
        CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
      ),
      child: child,
    ),
  ),
);

class _GymAppState extends ConsumerState<GymApp> {
  late final GoRouter router;
  @override
  void initState() {
    super.initState();
    router = GoRouter(
      initialLocation: '/home',
      refreshListenable: client.auth.authInfoListenable,
      redirect: (c, s) =>
          authRedirect(client.auth.isAuthenticated, s.matchedLocation),
      routes: [
        GoRoute(
          path: '/auth',
          pageBuilder: (c, s) => _fade(s, const AuthScreen()),
        ),
        GoRoute(
          path: '/onboarding',
          pageBuilder: (c, s) => _fade(s, const OnboardingScreen()),
        ),
        ShellRoute(
          builder: (c, s, child) => AppShell(path: s.uri.path, child: child),
          routes: [
            GoRoute(
              path: '/home',
              pageBuilder: (c, s) => _fade(s, const HomeScreen()),
            ),
            GoRoute(
              path: '/workout',
              pageBuilder: (c, s) => _fade(
                s,
                WorkoutScreen(
                  key: ValueKey(s.uri.queryParameters['plan']),
                  planId: int.tryParse(s.uri.queryParameters['plan'] ?? ''),
                ),
              ),
            ),
            GoRoute(
              path: '/session/:id',
              pageBuilder: (c, s) => _fade(
                s,
                SessionScreen(id: int.parse(s.pathParameters['id']!)),
              ),
            ),
            GoRoute(
              path: '/form',
              pageBuilder: (c, s) => _fade(s, const FormScreen()),
            ),
            GoRoute(
              path: '/discover',
              pageBuilder: (c, s) => _fade(s, const DiscoverScreen()),
            ),
            GoRoute(
              path: '/profile',
              pageBuilder: (c, s) => _fade(s, const ProfileScreen()),
            ),
            GoRoute(
              path: '/equipment',
              pageBuilder: (c, s) => _fade(s, const EquipmentScreen()),
            ),
            GoRoute(
              path: '/coach',
              pageBuilder: (c, s) => _fade(s, const AgentScreen()),
            ),
            GoRoute(
              path: '/progress',
              pageBuilder: (c, s) => _fade(s, const ProgressScreen()),
            ),
            GoRoute(
              path: '/admin',
              pageBuilder: (c, s) => _fade(s, const AdminScreen()),
            ),
          ],
        ),
      ],
    );
    client.auth.authInfoListenable.addListener(clearUserState);
  }

  void clearUserState() {
    ref.invalidate(profileProvider);
    ref.invalidate(dashboardProvider);
    ref.invalidate(equipmentProvider);
    ref.invalidate(historyProvider);
    ref.invalidate(plansProvider);
    ref.invalidate(readinessProvider);
    ref.invalidate(readinessTrendProvider);
    ref.invalidate(formHistoryProvider);
    ref.invalidate(issuesProvider);
    ref.invalidate(discoverProvider);
    ref.invalidate(planProvider);
    ref.invalidate(sessionProvider);
    ref.invalidate(equipmentStreamProvider);
    ref.invalidate(notificationsProvider);
    ref.invalidate(unreadCountProvider);
    ref.invalidate(adminStatsProvider);
    ref.invalidate(membersProvider);
  }

  @override
  void dispose() {
    client.auth.authInfoListenable.removeListener(clearUserState);
    router.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MaterialApp.router(
    title: 'GymOS • Train together',
    debugShowCheckedModeBanner: false,
    theme: GymTheme.dark,
    routerConfig: router,
  );
}

class AppShell extends ConsumerWidget {
  final String path;
  final Widget child;
  const AppShell({super.key, required this.path, required this.child});
  static const paths = ['/home', '/workout', '/form', '/discover', '/profile'];
  static const labels = ['Home', 'Workout', 'Form', 'Discover', 'Profile'];
  static const icons = [
    Icons.space_dashboard_outlined,
    Icons.fitness_center_rounded,
    Icons.accessibility_new_rounded,
    Icons.explore_outlined,
    Icons.person_outline_rounded,
  ];
  static const selectedIcons = [
    Icons.space_dashboard_rounded,
    Icons.fitness_center_rounded,
    Icons.accessibility_new_rounded,
    Icons.explore_rounded,
    Icons.person_rounded,
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileProvider);
    final index = paths.indexOf(path);
    final selected = index < 0 ? (path.startsWith('/session') ? 1 : 0) : index;
    ref.listen(equipmentStreamProvider, (previous, next) {
      if (next.hasValue) {
        ref.invalidate(equipmentProvider);
        ref.invalidate(issuesProvider);
        ref.invalidate(dashboardProvider);
        ref.invalidate(unreadCountProvider);
        ref.invalidate(notificationsProvider);
      }
    });
    return profile.when(
      loading: () => const Scaffold(
        body: AmbientBackground(
          child: Center(child: CircularProgressIndicator()),
        ),
      ),
      error: (e, _) => Scaffold(
        body: AmbientBackground(
          child: PageBody(
            children: [
              EmptyCard(
                icon: Icons.cloud_off,
                title: 'Unable to load your profile',
                message: errorText(e),
                action: FilledButton(
                  onPressed: () => ref.invalidate(profileProvider),
                  child: const Text('Retry'),
                ),
              ),
            ],
          ),
        ),
      ),
      data: (p) {
        if (p == null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (context.mounted) context.go('/onboarding');
          });
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        final wide = MediaQuery.sizeOf(context).width >= 900;
        final admin = p.role == 'admin';
        return Scaffold(
          backgroundColor: GymTheme.bg,
          extendBody: true,
          appBar: wide
              ? null
              : AppBar(
                  backgroundColor: GymTheme.bg.withValues(alpha: .85),
                  titleSpacing: 18,
                  title: const _Brand(compact: true),
                  actions: [
                    IconButton(
                      tooltip: 'Progress',
                      onPressed: () => context.go('/progress'),
                      icon: const Icon(Icons.insights_outlined),
                    ),
                    const NotificationBell(),
                    const SizedBox(width: 8),
                  ],
                ),
          body: AmbientBackground(
            child: SafeArea(
              bottom: false,
              child: Row(
                children: [
                  if (wide)
                    _Sidebar(
                      path: path,
                      name: p.displayName,
                      role: p.role,
                      admin: admin,
                    ),
                  Expanded(child: child),
                ],
              ),
            ),
          ),
          bottomNavigationBar: wide
              ? null
              : _FloatingNav(
                  selected: selected,
                  onSelect: (i) => context.go(paths[i]),
                ),
          floatingActionButton: path == '/coach'
              ? null
              : _AskButton(onTap: () => context.go('/coach')),
        );
      },
    );
  }
}

class _Brand extends StatelessWidget {
  final bool compact;
  const _Brand({this.compact = false});
  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: compact ? 32 : 40,
        height: compact ? 32 : 40,
        decoration: BoxDecoration(
          gradient: GymTheme.brandGradient,
          borderRadius: BorderRadius.circular(compact ? 10 : 12),
          boxShadow: GymTheme.glow(GymTheme.accent, strength: .3),
        ),
        child: Icon(
          Icons.bolt_rounded,
          color: GymTheme.bg,
          size: compact ? 20 : 26,
        ),
      ),
      const SizedBox(width: 10),
      Text(
        'GymOS',
        style: GymTheme.display(
          TextStyle(
            fontSize: compact ? 20 : 25,
            fontWeight: FontWeight.w700,
            letterSpacing: -.6,
            color: GymTheme.text,
          ),
        ),
      ),
    ],
  );
}

class _Sidebar extends StatelessWidget {
  final String path, name, role;
  final bool admin;
  const _Sidebar({
    required this.path,
    required this.name,
    required this.role,
    required this.admin,
  });
  @override
  Widget build(BuildContext context) {
    final items = [
      for (var i = 0; i < AppShell.paths.length; i++)
        (
          AppShell.paths[i],
          AppShell.labels[i],
          AppShell.icons[i],
          AppShell.selectedIcons[i],
        ),
    ];
    final more = [
      ('/progress', 'Progress', Icons.insights_outlined, Icons.insights),
      (
        '/equipment',
        'Our gym',
        Icons.sports_gymnastics_outlined,
        Icons.sports_gymnastics,
      ),
      if (admin)
        (
          '/admin',
          'Admin',
          Icons.admin_panel_settings_outlined,
          Icons.admin_panel_settings,
        ),
    ];
    bool active(String p) =>
        path == p || (p == '/workout' && path.startsWith('/session'));
    return Container(
      width: 252,
      decoration: BoxDecoration(
        color: GymTheme.bgRaised.withValues(alpha: .7),
        border: const Border(right: BorderSide(color: GymTheme.line)),
      ),
      padding: const EdgeInsets.fromLTRB(18, 26, 18, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 6),
            child: _Brand(),
          ),
          const SizedBox(height: 6),
          const Padding(
            padding: EdgeInsets.only(left: 56),
            child: Text(
              'TRAIN TOGETHER',
              style: TextStyle(
                fontSize: 9,
                letterSpacing: 2.2,
                color: GymTheme.subtle,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 34),
          for (final x in items)
            _NavItem(
              label: x.$2,
              icon: active(x.$1) ? x.$4 : x.$3,
              active: active(x.$1),
              onTap: () => context.go(x.$1),
            ),
          const Padding(
            padding: EdgeInsets.fromLTRB(12, 22, 12, 10),
            child: Text(
              'MORE',
              style: TextStyle(
                fontSize: 10,
                letterSpacing: 2,
                color: GymTheme.subtle,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          for (final x in more)
            _NavItem(
              label: x.$2,
              icon: active(x.$1) ? x.$4 : x.$3,
              active: active(x.$1),
              onTap: () => context.go(x.$1),
            ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: GymTheme.surface,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: GymTheme.line),
            ),
            child: Row(
              children: [
                AvatarBadge(name, size: 38),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        titleCase(role),
                        style: const TextStyle(
                          color: GymTheme.muted,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                const NotificationBell(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatefulWidget {
  final String label;
  final IconData icon;
  final bool active;
  final VoidCallback onTap;
  const _NavItem({
    required this.label,
    required this.icon,
    required this.active,
    required this.onTap,
  });
  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool hover = false;
  @override
  Widget build(BuildContext context) {
    final color = widget.active
        ? GymTheme.accent
        : (hover ? GymTheme.text : GymTheme.muted);
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => hover = true),
        onExit: (_) => setState(() => hover = false),
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 160),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              color: widget.active
                  ? GymTheme.accent.withValues(alpha: .10)
                  : (hover ? GymTheme.surface : Colors.transparent),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: widget.active
                    ? GymTheme.accent.withValues(alpha: .25)
                    : Colors.transparent,
              ),
            ),
            child: Row(
              children: [
                Icon(widget.icon, size: 21, color: color),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    widget.label,
                    style: TextStyle(
                      color: widget.active ? GymTheme.text : color,
                      fontWeight: widget.active
                          ? FontWeight.w700
                          : FontWeight.w500,
                    ),
                  ),
                ),
                if (widget.active)
                  Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: GymTheme.accent,
                      shape: BoxShape.circle,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FloatingNav extends StatelessWidget {
  final int selected;
  final ValueChanged<int> onSelect;
  const _FloatingNav({required this.selected, required this.onSelect});
  @override
  Widget build(BuildContext context) => SafeArea(
    minimum: const EdgeInsets.fromLTRB(12, 0, 12, 10),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(26),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: GymTheme.bgRaised.withValues(alpha: .82),
            borderRadius: BorderRadius.circular(26),
            border: Border.all(color: GymTheme.line),
          ),
          child: NavigationBar(
            selectedIndex: selected,
            onDestinationSelected: onSelect,
            destinations: [
              for (var i = 0; i < AppShell.paths.length; i++)
                NavigationDestination(
                  icon: Icon(AppShell.icons[i]),
                  selectedIcon: Icon(AppShell.selectedIcons[i]),
                  label: AppShell.labels[i],
                ),
            ],
          ),
        ),
      ),
    ),
  );
}

class _AskButton extends StatefulWidget {
  final VoidCallback onTap;
  const _AskButton({required this.onTap});
  @override
  State<_AskButton> createState() => _AskButtonState();
}

class _AskButtonState extends State<_AskButton> {
  bool hover = false;
  @override
  Widget build(BuildContext context) => Semantics(
    button: true,
    label: 'Ask GymOS coach',
    child: MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => hover = true),
      onExit: (_) => setState(() => hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedScale(
          scale: hover ? 1.04 : 1,
          duration: const Duration(milliseconds: 160),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: BoxDecoration(
              gradient: GymTheme.coachGradient,
              borderRadius: BorderRadius.circular(40),
              boxShadow: GymTheme.glow(GymTheme.violet, strength: .45),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.auto_awesome, color: GymTheme.bg, size: 20),
                SizedBox(width: 10),
                Text(
                  'Ask GymOS',
                  style: TextStyle(
                    color: GymTheme.bg,
                    fontWeight: FontWeight.w800,
                    fontSize: 14.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

/// Bell with an unread badge; opens the notification sheet.
class NotificationBell extends ConsumerWidget {
  const NotificationBell({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final unread = ref.watch(unreadCountProvider).value ?? 0;
    return IconButton(
      tooltip: 'Notifications',
      onPressed: () => showNotifications(context, ref),
      icon: Badge(
        isLabelVisible: unread > 0,
        backgroundColor: GymTheme.coral,
        label: Text(unread > 9 ? '9+' : '$unread'),
        child: const Icon(Icons.notifications_none_rounded),
      ),
    );
  }
}
