import 'package:flutter/material.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import '../../client.dart';
import '../../app/theme.dart';
import '../../core/widgets.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  static const features = [
    (
      Icons.auto_awesome,
      'A coach with context',
      'Plans built from your history, load and the equipment that’s free.',
      GymTheme.violet,
    ),
    (
      Icons.accessibility_new_rounded,
      'Photo form checks',
      'On-device pose analysis. Photos never leave your phone.',
      GymTheme.mint,
    ),
    (
      Icons.groups_2_rounded,
      'Train together',
      'Community sessions and nearby events on one map.',
      GymTheme.sky,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final narrow = width < 860;
    final textTheme = Theme.of(context).textTheme;
    final pitch = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                gradient: GymTheme.brandGradient,
                borderRadius: BorderRadius.circular(14),
                boxShadow: GymTheme.glow(GymTheme.accent),
              ),
              child: const Icon(Icons.bolt_rounded, color: GymTheme.bg),
            ),
            const SizedBox(width: 12),
            Text(
              'GymOS',
              style: GymTheme.display(
                const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: GymTheme.text,
                  letterSpacing: -.6,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: narrow ? 32 : 56),
        const Eyebrow('Your everyday training companion'),
        const SizedBox(height: 18),
        ShaderMask(
          shaderCallback: (r) => const LinearGradient(
            colors: [GymTheme.text, GymTheme.text, GymTheme.accent],
            stops: [0, .55, 1],
          ).createShader(r),
          child: Text(
            'A little stronger.\nA lot more together.',
            style: (narrow ? textTheme.displaySmall : textTheme.displayLarge)
                ?.copyWith(color: Colors.white),
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'Thoughtful workouts, clear technique cues, and a community that keeps you moving.',
          style: TextStyle(fontSize: 17, color: GymTheme.muted, height: 1.6),
        ),
        const SizedBox(height: 32),
        for (final (icon, title, body, color) in features)
          Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: Row(
              children: [
                IconBadge(icon, color: color, size: 46),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15.5,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        body,
                        style: const TextStyle(
                          color: GymTheme.muted,
                          fontSize: 13.5,
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
    final form = Panel(
      padding: const EdgeInsets.all(30),
      shadow: GymTheme.cardShadow,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your next chapter starts here.',
            style: textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          const Text(
            'Sign in or create your account.',
            style: TextStyle(color: GymTheme.muted),
          ),
          const SizedBox(height: 24),
          SignInWidget(
            client: client,
            onAuthenticated: () {},
            onError: (e) => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Sign-in failed. Check your details and try again.',
                ),
              ),
            ),
          ),
          const SizedBox(height: 18),
          const Row(
            children: [
              Icon(
                Icons.lock_outline_rounded,
                size: 14,
                color: GymTheme.subtle,
              ),
              SizedBox(width: 6),
              Expanded(
                child: Text(
                  'Development sign-up codes appear in the local server console.',
                  style: TextStyle(color: GymTheme.subtle, fontSize: 12),
                ),
              ),
            ],
          ),
        ],
      ),
    );
    return Scaffold(
      body: AmbientBackground(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: narrow ? 20 : 48,
              vertical: 32,
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1120),
              child: narrow
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        FadeSlideIn(child: pitch),
                        const SizedBox(height: 28),
                        FadeSlideIn(
                          delay: const Duration(milliseconds: 120),
                          child: form,
                        ),
                      ],
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(flex: 11, child: FadeSlideIn(child: pitch)),
                        const SizedBox(width: 64),
                        Expanded(
                          flex: 9,
                          child: FadeSlideIn(
                            delay: const Duration(milliseconds: 120),
                            child: form,
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
}
