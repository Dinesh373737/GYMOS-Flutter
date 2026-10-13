import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymos2_client/gymos2_client.dart';
import '../app/theme.dart';

String errorText(Object e) => e is GymException
    ? e.message
    : 'Could not connect. Check your connection and try again.';

class AsyncPanel<T> extends StatelessWidget {
  final AsyncValue<T> value;
  final Widget Function(T) builder;
  final VoidCallback retry;
  final Widget? loading;
  const AsyncPanel({
    super.key,
    required this.value,
    required this.builder,
    required this.retry,
    this.loading,
  });
  @override
  Widget build(BuildContext context) => value.when(
    data: builder,
    loading: () => loading ?? const LoadingSkeleton(),
    error: (e, _) => EmptyCard(
      icon: Icons.cloud_off_outlined,
      title: 'Let’s reconnect',
      message: errorText(e),
      tone: GymTheme.orange,
      action: OutlinedButton.icon(
        onPressed: retry,
        icon: const Icon(Icons.refresh),
        label: const Text('Try again'),
      ),
    ),
  );
}

/// Scrollable page frame with responsive gutters and a staggered entrance.
class PageBody extends StatelessWidget {
  final List<Widget> children;
  const PageBody({super.key, required this.children});
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final side = width > 1000 ? 40.0 : (width > 600 ? 28.0 : 18.0);
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(side, width > 900 ? 32 : 16, side, 120),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1180),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var i = 0; i < children.length; i++)
                FadeSlideIn(
                  delay: Duration(milliseconds: math.min(i, 6) * 45),
                  child: children[i],
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Plays a short fade-and-rise once when first shown.
class FadeSlideIn extends StatefulWidget {
  final Widget child;
  final Duration delay;
  final double offset;
  const FadeSlideIn({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.offset = 14,
  });
  @override
  State<FadeSlideIn> createState() => _FadeSlideInState();
}

class _FadeSlideInState extends State<FadeSlideIn>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation<double> curve;
  @override
  void initState() {
    super.initState();
    const run = Duration(milliseconds: 420);
    final total = widget.delay + run;
    controller = AnimationController(vsync: this, duration: total)..forward();
    curve = CurvedAnimation(
      parent: controller,
      curve: Interval(
        widget.delay.inMilliseconds / total.inMilliseconds,
        1,
        curve: Curves.easeOutCubic,
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: curve,
    child: widget.child,
    builder: (context, child) => Opacity(
      opacity: curve.value,
      child: Transform.translate(
        offset: Offset(0, (1 - curve.value) * widget.offset),
        child: child,
      ),
    ),
  );
}

class PageTitle extends StatelessWidget {
  final String eyebrow, title, subtitle;
  final Widget? action;
  const PageTitle(
    this.eyebrow,
    this.title,
    this.subtitle, {
    super.key,
    this.action,
  });
  @override
  Widget build(BuildContext context) {
    final narrow = MediaQuery.sizeOf(context).width < 600;
    final theme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 28),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Eyebrow(eyebrow),
                const SizedBox(height: 12),
                Text(
                  title,
                  style: (narrow ? theme.headlineMedium : theme.displaySmall)
                      ?.copyWith(fontSize: narrow ? 30 : null),
                ),
                const SizedBox(height: 10),
                Text(
                  subtitle,
                  style: theme.bodyLarge?.copyWith(color: GymTheme.muted),
                ),
              ],
            ),
          ),
          if (action != null) ...[const SizedBox(width: 12), action!],
        ],
      ),
    );
  }
}

class Eyebrow extends StatelessWidget {
  final String text;
  final Color color;
  const Eyebrow(this.text, {super.key, this.color = GymTheme.accent});
  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 18,
        height: 3,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(3),
        ),
      ),
      const SizedBox(width: 10),
      Flexible(
        child: Text(
          text.toUpperCase(),
          style: Theme.of(
            context,
          ).textTheme.labelSmall?.copyWith(color: color),
        ),
      ),
    ],
  );
}

/// Card surface. With [onTap] it lifts and highlights on hover/press.
class Panel extends StatefulWidget {
  final Widget child;
  final Color? color;
  final Gradient? gradient;
  final Color? borderColor;
  final EdgeInsets padding;
  final VoidCallback? onTap;
  final List<BoxShadow>? shadow;
  const Panel({
    super.key,
    required this.child,
    this.color,
    this.gradient,
    this.borderColor,
    this.padding = const EdgeInsets.all(24),
    this.onTap,
    this.shadow,
  });
  @override
  State<Panel> createState() => _PanelState();
}

class _PanelState extends State<Panel> {
  bool hover = false;
  @override
  Widget build(BuildContext context) {
    final interactive = widget.onTap != null;
    final lifted = interactive && hover;
    final body = AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOut,
      transform: Matrix4.translationValues(0, lifted ? -3 : 0, 0),
      decoration: BoxDecoration(
        color: widget.gradient == null
            ? (widget.color ?? GymTheme.surface)
            : null,
        gradient:
            widget.gradient ??
            (widget.color == null ? GymTheme.surfaceGradient : null),
        borderRadius: BorderRadius.circular(GymTheme.radius),
        border: Border.all(
          color: lifted
              ? GymTheme.lineStrong
              : (widget.borderColor ?? GymTheme.line),
        ),
        boxShadow: lifted ? GymTheme.cardShadow : widget.shadow,
      ),
      child: Padding(padding: widget.padding, child: widget.child),
    );
    if (!interactive) return body;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => hover = true),
      onExit: (_) => setState(() => hover = false),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: widget.onTap,
        child: body,
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  final Widget? action;
  final IconData? icon;
  const SectionTitle(this.title, {super.key, this.action, this.icon});
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 34, bottom: 16),
    child: Row(
      children: [
        if (icon != null) ...[
          Icon(icon, size: 20, color: GymTheme.accent),
          const SizedBox(width: 10),
        ],
        Expanded(
          child: Text(title, style: Theme.of(context).textTheme.titleLarge),
        ),
        ?action,
      ],
    ),
  );
}

class StatusPill extends StatelessWidget {
  final String text;
  final Color color;
  final bool dot;
  final IconData? icon;
  const StatusPill(
    this.text, {
    super.key,
    this.color = GymTheme.accent,
    this.dot = false,
    this.icon,
  });
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: color.withValues(alpha: .12),
      borderRadius: BorderRadius.circular(30),
      border: Border.all(color: color.withValues(alpha: .22)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (dot) ...[
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 7),
        ],
        if (icon != null) ...[
          Icon(icon, size: 13, color: color),
          const SizedBox(width: 6),
        ],
        Flexible(
          child: Text(
            text,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 10.5,
              letterSpacing: .6,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ),
      ],
    ),
  );
}

class EmptyCard extends StatelessWidget {
  final IconData icon;
  final String title, message;
  final Widget? action;
  final Color tone;
  const EmptyCard({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
    this.action,
    this.tone = GymTheme.accent,
  });
  @override
  Widget build(BuildContext context) => Panel(
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
    child: Center(
      child: Column(
        children: [
          IconBadge(icon, color: tone, size: 64),
          const SizedBox(height: 18),
          Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 460),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: GymTheme.muted, height: 1.55),
            ),
          ),
          if (action != null) ...[const SizedBox(height: 20), action!],
        ],
      ),
    ),
  );
}

/// Icon on a soft tinted tile.
class IconBadge extends StatelessWidget {
  final IconData icon;
  final Color color;
  final double size;
  const IconBadge(
    this.icon, {
    super.key,
    this.color = GymTheme.accent,
    this.size = 44,
  });
  @override
  Widget build(BuildContext context) => Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(size * .32),
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [color.withValues(alpha: .26), color.withValues(alpha: .08)],
      ),
      border: Border.all(color: color.withValues(alpha: .25)),
    ),
    child: Icon(icon, color: color, size: size * .48),
  );
}

/// Compact metric with an icon, a large value and a caption.
class StatTile extends StatelessWidget {
  final IconData icon;
  final String value, label;
  final Color color;
  final String? hint;
  final VoidCallback? onTap;
  const StatTile({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
    this.color = GymTheme.accent,
    this.hint,
    this.onTap,
  });
  @override
  Widget build(BuildContext context) => Panel(
    onTap: onTap,
    padding: const EdgeInsets.all(18),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            IconBadge(icon, color: color, size: 38),
            const Spacer(),
            if (hint != null)
              Flexible(
                child: Text(
                  hint!,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: GymTheme.subtle, fontSize: 11),
                ),
              ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          value,
          style: GymTheme.display(
            const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w700,
              letterSpacing: -1,
              color: GymTheme.text,
              height: 1,
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(color: GymTheme.muted, fontSize: 13),
        ),
      ],
    ),
  );
}

/// Lays out tiles in an even grid that adapts its column count to width.
class AdaptiveGrid extends StatelessWidget {
  final List<Widget> children;
  final double minTileWidth, spacing;
  const AdaptiveGrid({
    super.key,
    required this.children,
    this.minTileWidth = 200,
    this.spacing = 14,
  });
  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, c) {
      final columns = math.max(
        1,
        ((c.maxWidth + spacing) / (minTileWidth + spacing)).floor(),
      );
      final width = (c.maxWidth - spacing * (columns - 1)) / columns;
      return Wrap(
        spacing: spacing,
        runSpacing: spacing,
        children: [
          for (final child in children) SizedBox(width: width, child: child),
        ],
      );
    },
  );
}

/// Circular progress ring with optional centered content.
class RingGauge extends StatelessWidget {
  final double value;
  final Color color;
  final double size, stroke;
  final Widget? child;
  final Gradient? gradient;

  /// Ticking values such as countdowns should not re-animate every update.
  final bool animate;
  const RingGauge({
    super.key,
    required this.value,
    this.color = GymTheme.accent,
    this.size = 96,
    this.stroke = 9,
    this.child,
    this.gradient,
    this.animate = true,
  });

  Widget _ring(double v) => SizedBox(
    width: size,
    height: size,
    child: CustomPaint(
      painter: _RingPainter(v, color, stroke, gradient),
      child: Center(child: child),
    ),
  );

  @override
  Widget build(BuildContext context) => !animate
      ? _ring(value.clamp(0, 1))
      : TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: value.clamp(0, 1)),
          duration: const Duration(milliseconds: 900),
          curve: Curves.easeOutCubic,
          builder: (context, v, _) => _ring(v),
        );
}

class _RingPainter extends CustomPainter {
  final double value;
  final Color color;
  final double stroke;
  final Gradient? gradient;
  _RingPainter(this.value, this.color, this.stroke, this.gradient);
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final arc = rect.deflate(stroke / 2);
    canvas.drawArc(
      arc,
      0,
      math.pi * 2,
      false,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = stroke
        ..color = GymTheme.line,
    );
    if (value <= 0) return;
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round;
    if (gradient != null) {
      paint.shader = SweepGradient(
        startAngle: -math.pi / 2,
        endAngle: math.pi * 1.5,
        colors: gradient!.colors,
        transform: const GradientRotation(-math.pi / 2),
      ).createShader(rect);
    } else {
      paint.color = color;
    }
    canvas.drawArc(arc, -math.pi / 2, math.pi * 2 * value, false, paint);
  }

  @override
  bool shouldRepaint(_RingPainter old) =>
      old.value != value || old.color != color;
}

/// Shimmering placeholder blocks used while network data loads.
class LoadingSkeleton extends StatefulWidget {
  final int rows;
  const LoadingSkeleton({super.key, this.rows = 3});
  @override
  State<LoadingSkeleton> createState() => _LoadingSkeletonState();
}

class _LoadingSkeletonState extends State<LoadingSkeleton>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1300),
  )..repeat();
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Semantics(
    label: 'Loading',
    child: AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        final t = controller.value;
        Widget block(double h, {double? w}) => Container(
          height: h,
          width: w,
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(GymTheme.radiusSm),
            gradient: LinearGradient(
              begin: Alignment(-1.5 + t * 3, 0),
              end: Alignment(-.5 + t * 3, 0),
              colors: const [
                GymTheme.surface,
                GymTheme.surfaceHigh,
                GymTheme.surface,
              ],
            ),
          ),
        );
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            block(16, w: 140),
            for (var i = 0; i < widget.rows; i++) block(i == 0 ? 120 : 72),
          ],
        );
      },
    ),
  );
}

/// Initial on a gradient disc.
class AvatarBadge extends StatelessWidget {
  final String name;
  final double size;
  final Gradient gradient;
  const AvatarBadge(
    this.name, {
    super.key,
    this.size = 44,
    this.gradient = GymTheme.brandGradient,
  });
  @override
  Widget build(BuildContext context) => Container(
    width: size,
    height: size,
    alignment: Alignment.center,
    decoration: BoxDecoration(gradient: gradient, shape: BoxShape.circle),
    child: Text(
      name.trim().isEmpty ? '?' : name.trim()[0].toUpperCase(),
      style: GymTheme.display(
        TextStyle(
          color: GymTheme.bg,
          fontWeight: FontWeight.w800,
          fontSize: size * .42,
        ),
      ),
    ),
  );
}

/// Soft brand-colored glows behind app content.
class AmbientBackground extends StatelessWidget {
  final Widget child;
  const AmbientBackground({super.key, required this.child});
  @override
  Widget build(BuildContext context) => Stack(
    children: [
      const Positioned.fill(child: ColoredBox(color: GymTheme.bg)),
      Positioned(
        top: -220,
        right: -160,
        child: _Glow(color: GymTheme.accent.withValues(alpha: .10), size: 560),
      ),
      Positioned(
        bottom: -260,
        left: -200,
        child: _Glow(color: GymTheme.mint.withValues(alpha: .07), size: 620),
      ),
      Positioned.fill(child: child),
    ],
  );
}

class _Glow extends StatelessWidget {
  final Color color;
  final double size;
  const _Glow({required this.color, required this.size});
  @override
  Widget build(BuildContext context) => IgnorePointer(
    child: Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(colors: [color, color.withValues(alpha: 0)]),
      ),
    ),
  );
}

/// Horizontal labelled bar for comparing a value against a maximum.
class MetricBar extends StatelessWidget {
  final String label, trailing;
  final double value;
  final Color color;
  const MetricBar({
    super.key,
    required this.label,
    required this.trailing,
    required this.value,
    this.color = GymTheme.accent,
  });
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Text(
            trailing,
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: .5,
            ),
          ),
        ],
      ),
      const SizedBox(height: 8),
      ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: value.clamp(0, 1)),
          duration: const Duration(milliseconds: 700),
          curve: Curves.easeOutCubic,
          builder: (context, v, _) => LinearProgressIndicator(
            value: v,
            minHeight: 7,
            color: color,
            backgroundColor: GymTheme.line,
          ),
        ),
      ),
    ],
  );
}

class ResponsivePair extends StatelessWidget {
  final Widget first, second;
  final double breakpoint;
  final int firstFlex, secondFlex;
  const ResponsivePair({
    super.key,
    required this.first,
    required this.second,
    this.breakpoint = 760,
    this.firstFlex = 3,
    this.secondFlex = 2,
  });
  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (c, b) => b.maxWidth > breakpoint
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: firstFlex, child: first),
              const SizedBox(width: 20),
              Expanded(flex: secondFlex, child: second),
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [first, const SizedBox(height: 20), second],
          ),
  );
}

Future<T?> guarded<T>(BuildContext context, Future<T> Function() action) async {
  try {
    return await action();
  } catch (e) {
    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(errorText(e))));
    }
    return null;
  }
}

const _weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
const _months = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec',
];

String _hm(DateTime x) =>
    '${x.hour.toString().padLeft(2, '0')}:${x.minute.toString().padLeft(2, '0')}';

String shortDate(DateTime d) {
  final x = d.toLocal();
  return '${x.day}/${x.month} • ${_hm(x)}';
}

/// "Tue 14 Oct · 07:30" in local time.
String friendlyDate(DateTime d, {bool time = true}) {
  final x = d.toLocal();
  final day = '${_weekdays[x.weekday - 1]} ${x.day} ${_months[x.month - 1]}';
  return time ? '$day · ${_hm(x)}' : day;
}

/// "Today", "Yesterday", "3 days ago" or a date.
String relativeDay(DateTime d) {
  final now = DateTime.now();
  final x = d.toLocal();
  final days = DateTime(
    now.year,
    now.month,
    now.day,
  ).difference(DateTime(x.year, x.month, x.day)).inDays;
  if (days == 0) return 'Today';
  if (days == 1) return 'Yesterday';
  if (days > 1 && days < 7) return '$days days ago';
  if (days == -1) return 'Tomorrow';
  return friendlyDate(d, time: false);
}

String titleCase(String s) => s
    .split(' ')
    .map((w) => w.isEmpty ? w : w[0].toUpperCase() + w.substring(1))
    .join(' ');
