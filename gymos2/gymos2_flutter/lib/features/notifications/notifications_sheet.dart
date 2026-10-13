import 'package:flutter/material.dart' hide Notification;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gymos2_client/gymos2_client.dart';
import '../../app/theme.dart';
import '../../client.dart';
import '../../core/providers.dart';
import '../../core/widgets.dart';

Future<void> showNotifications(BuildContext context, WidgetRef ref) async {
  ref.invalidate(notificationsProvider);
  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    constraints: const BoxConstraints(maxWidth: 640),
    builder: (c) => const _NotificationsSheet(),
  );
  // Opening the sheet counts as reading everything shown.
  try {
    await client.notification.markAllRead();
  } catch (_) {
    // Badge state simply stays until the next successful refresh.
  }
  ref.invalidate(unreadCountProvider);
  ref.invalidate(notificationsProvider);
}

class _NotificationsSheet extends ConsumerWidget {
  const _NotificationsSheet();
  @override
  Widget build(BuildContext context, WidgetRef ref) => SafeArea(
    child: ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height * .75,
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const IconBadge(Icons.notifications_rounded, size: 40),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    'Notifications',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Flexible(
              child: AsyncPanel(
                value: ref.watch(notificationsProvider),
                retry: () => ref.invalidate(notificationsProvider),
                builder: (list) => list.isEmpty
                    ? const EmptyCard(
                        icon: Icons.notifications_off_outlined,
                        title: 'You’re all caught up',
                        message:
                            'Maintenance updates and membership changes appear here.',
                      )
                    : ListView.separated(
                        shrinkWrap: true,
                        itemCount: list.length,
                        separatorBuilder: (_, _) => const SizedBox(height: 10),
                        itemBuilder: (c, i) => _Item(list[i]),
                      ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class _Item extends StatelessWidget {
  final Notification n;
  const _Item(this.n);
  @override
  Widget build(BuildContext context) {
    final (icon, color) = switch (n.type) {
      'maintenance' => (Icons.build_circle_outlined, GymTheme.orange),
      'membership' => (Icons.verified_user_outlined, GymTheme.violet),
      _ => (Icons.notifications_outlined, GymTheme.accent),
    };
    return Panel(
      padding: const EdgeInsets.all(16),
      borderColor: n.readAt == null ? color.withValues(alpha: .35) : null,
      onTap: n.link == null
          ? null
          : () {
              Navigator.pop(context);
              context.go(n.link!);
            },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconBadge(icon, color: color, size: 38),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  n.title,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 4),
                Text(n.body, style: const TextStyle(color: GymTheme.muted)),
                const SizedBox(height: 8),
                Text(
                  '${relativeDay(n.createdAt)} · ${friendlyDate(n.createdAt).split(' · ').last}',
                  style: const TextStyle(color: GymTheme.subtle, fontSize: 12),
                ),
              ],
            ),
          ),
          if (n.readAt == null)
            Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.only(top: 6),
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
        ],
      ),
    );
  }
}
