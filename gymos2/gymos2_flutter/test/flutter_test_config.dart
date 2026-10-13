import 'dart:async';

import 'package:gymos2_flutter/app/theme.dart';

/// Widget tests run offline, so the theme must not fetch fonts.
Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  GymTheme.useGoogleFonts = false;
  await testMain();
}
