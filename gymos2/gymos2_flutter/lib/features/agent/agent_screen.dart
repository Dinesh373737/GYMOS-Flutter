import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gymos2_client/gymos2_client.dart';
import '../../client.dart';
import '../../core/widgets.dart';
import '../../app/theme.dart';

class AgentScreen extends StatefulWidget {
  const AgentScreen({super.key});
  @override
  State<AgentScreen> createState() => _State();
}

class _State extends State<AgentScreen> {
  static const suggestions = [
    (
      Icons.bolt_rounded,
      'I have 40 minutes. What should I train today?',
      GymTheme.accent,
    ),
    (
      Icons.sports_gymnastics_rounded,
      'What equipment is available?',
      GymTheme.sky,
    ),
    (
      Icons.monitor_heart_outlined,
      'Explain my recent training load.',
      GymTheme.orange,
    ),
    (Icons.event_outlined, 'Any community events coming up?', GymTheme.violet),
  ];

  final input = TextEditingController();
  final messages = <({bool user, String text, AgentReply? reply})>[];
  int? conversation;
  bool busy = false;
  @override
  void dispose() {
    input.dispose();
    super.dispose();
  }

  Future<void> send(String text) async {
    if (text.trim().isEmpty || busy) return;
    setState(() {
      busy = true;
      messages.add((user: true, text: text, reply: null));
      input.clear();
    });
    try {
      final reply = await client.agent.sendMessage(text, conversation);
      if (mounted) {
        setState(() {
          conversation = reply.conversationId;
          messages.add((user: false, text: reply.message, reply: reply));
        });
      }
    } catch (e) {
      if (mounted) {
        setState(
          () => messages.add((user: false, text: errorText(e), reply: null)),
        );
      }
    } finally {
      if (mounted) setState(() => busy = false);
    }
  }

  Future<void> history() async {
    final list = await guarded(context, () => client.agent.conversations());
    if (!mounted || list == null) return;
    final chosen = await showModalBottomSheet<AgentConversation>(
      context: context,
      constraints: const BoxConstraints(maxWidth: 600),
      builder: (c) => SafeArea(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
          children: [
            Text(
              'Previous conversations',
              style: Theme.of(c).textTheme.headlineSmall,
            ),
            const SizedBox(height: 14),
            if (list.isEmpty)
              const Text(
                'No conversations yet.',
                style: TextStyle(color: GymTheme.muted),
              ),
            for (final x in list)
              ListTile(
                leading: const Icon(Icons.chat_bubble_outline_rounded),
                title: Text(
                  x.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(relativeDay(x.updatedAt)),
                onTap: () => Navigator.pop(c, x),
              ),
          ],
        ),
      ),
    );
    if (chosen == null || !mounted) return;
    final past = await guarded(
      context,
      () => client.agent.messages(chosen.id!),
    );
    if (mounted && past != null) {
      setState(() {
        conversation = chosen.id;
        messages
          ..clear()
          ..addAll(
            past.map(
              (x) => (user: x.role == 'user', text: x.content, reply: null),
            ),
          );
      });
    }
  }

  @override
  Widget build(BuildContext context) => PageBody(
    children: [
      PageTitle(
        'Your training copilot',
        'A coach with context.',
        'Grounded in your workouts, your equipment, and your day — using real GymOS tools.',
        action: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (messages.isNotEmpty)
              IconButton(
                tooltip: 'New conversation',
                onPressed: busy
                    ? null
                    : () => setState(() {
                        messages.clear();
                        conversation = null;
                      }),
                icon: const Icon(Icons.add_comment_outlined),
              ),
            IconButton(
              tooltip: 'Previous conversations',
              onPressed: history,
              icon: const Icon(Icons.history),
            ),
          ],
        ),
      ),
      if (messages.isEmpty)
        Panel(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [GymTheme.violet.withValues(alpha: .14), GymTheme.surface],
          ),
          borderColor: GymTheme.violet.withValues(alpha: .25),
          padding: const EdgeInsets.all(28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _CoachAvatar(size: 56),
              const SizedBox(height: 20),
              Text(
                'What feels right for today?',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 10),
              const Text(
                'I can check your recent training, find available equipment, swap exercises and build a practical workout draft.',
                style: TextStyle(color: GymTheme.muted, height: 1.55),
              ),
              const SizedBox(height: 24),
              AdaptiveGrid(
                minTileWidth: 240,
                spacing: 10,
                children: [
                  for (final (icon, text, color) in suggestions)
                    Panel(
                      padding: const EdgeInsets.all(16),
                      onTap: () => send(text),
                      child: Row(
                        children: [
                          IconBadge(icon, color: color, size: 36),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              text,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      for (final m in messages) _Bubble(m.user, m.text, m.reply),
      if (busy)
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Row(
            children: [
              _CoachAvatar(size: 34),
              SizedBox(width: 14),
              _TypingDots(),
              SizedBox(width: 12),
              Flexible(
                child: Text(
                  'Checking your training context…',
                  style: TextStyle(color: GymTheme.muted),
                ),
              ),
            ],
          ),
        ),
      const SizedBox(height: 18),
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          boxShadow: GymTheme.cardShadow,
        ),
        child: TextField(
          controller: input,
          minLines: 1,
          maxLines: 4,
          enabled: !busy,
          onSubmitted: send,
          decoration: InputDecoration(
            hintText: 'Ask about your training…',
            prefixIcon: const Icon(Icons.auto_awesome, color: GymTheme.violet),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: const BorderSide(color: GymTheme.lineStrong),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: const BorderSide(color: GymTheme.lineStrong),
            ),
            suffixIcon: Padding(
              padding: const EdgeInsets.all(6),
              child: IconButton.filled(
                tooltip: 'Send message',
                onPressed: busy ? null : () => send(input.text),
                icon: const Icon(Icons.arrow_upward_rounded),
              ),
            ),
          ),
        ),
      ),
      const SizedBox(height: 12),
      const Row(
        children: [
          Icon(
            Icons.health_and_safety_outlined,
            size: 14,
            color: GymTheme.subtle,
          ),
          SizedBox(width: 6),
          Expanded(
            child: Text(
              'General fitness guidance. If a movement hurts, stop and seek qualified guidance.',
              style: TextStyle(color: GymTheme.subtle, fontSize: 12),
            ),
          ),
        ],
      ),
    ],
  );
}

class _CoachAvatar extends StatelessWidget {
  final double size;
  const _CoachAvatar({this.size = 40});
  @override
  Widget build(BuildContext context) => Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      gradient: GymTheme.coachGradient,
      shape: BoxShape.circle,
      boxShadow: GymTheme.glow(GymTheme.violet, strength: .35),
    ),
    child: Icon(Icons.auto_awesome, color: GymTheme.bg, size: size * .5),
  );
}

class _Bubble extends StatelessWidget {
  final bool user;
  final String text;
  final AgentReply? reply;
  const _Bubble(this.user, this.text, this.reply);
  @override
  Widget build(BuildContext context) {
    final bubble = ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 720),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: user
              ? GymTheme.accent.withValues(alpha: .12)
              : GymTheme.surface,
          border: Border.all(
            color: user ? GymTheme.accent.withValues(alpha: .3) : GymTheme.line,
          ),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(20),
            topRight: const Radius.circular(20),
            bottomLeft: Radius.circular(user ? 20 : 6),
            bottomRight: Radius.circular(user ? 6 : 20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SelectableText(text, style: const TextStyle(height: 1.65)),
            if (reply != null && reply!.actions.isNotEmpty) ...[
              const SizedBox(height: 14),
              const Text(
                'TOOLS USED',
                style: TextStyle(
                  color: GymTheme.subtle,
                  fontSize: 10,
                  letterSpacing: 1.4,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  for (final a in reply!.actions)
                    Tooltip(
                      message: '${a.resultSummary} · ${a.durationMs} ms',
                      child: StatusPill(
                        a.toolName.replaceAll('_', ' '),
                        color: a.status == 'success'
                            ? GymTheme.violet
                            : GymTheme.orange,
                        icon: a.status == 'success'
                            ? Icons.check_rounded
                            : Icons.error_outline_rounded,
                      ),
                    ),
                ],
              ),
            ],
            if (reply?.planId != null) ...[
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: () => context.go('/workout?plan=${reply!.planId}'),
                icon: const Icon(Icons.arrow_forward_rounded),
                label: const Text('Open workout draft'),
              ),
            ],
          ],
        ),
      ),
    );
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: user
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!user) ...[
            const _CoachAvatar(size: 34),
            const SizedBox(width: 12),
          ],
          Flexible(child: bubble),
        ],
      ),
    );
  }
}

class _TypingDots extends StatefulWidget {
  const _TypingDots();
  @override
  State<_TypingDots> createState() => _TypingDotsState();
}

class _TypingDotsState extends State<_TypingDots>
    with SingleTickerProviderStateMixin {
  late final AnimationController c = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1100),
  )..repeat();
  @override
  void dispose() {
    c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: c,
    builder: (context, _) => Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < 3; i++)
          Container(
            width: 7,
            height: 7,
            margin: const EdgeInsets.only(right: 4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: GymTheme.violet.withValues(
                alpha: .3 + .7 * (((c.value * 3 - i) % 3) < 1 ? 1 : 0),
              ),
            ),
          ),
      ],
    ),
  );
}
