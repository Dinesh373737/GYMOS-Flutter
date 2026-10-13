import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// GymOS design system: one place for colors, gradients, spacing, radii,
/// typography and component styling.
class GymTheme {
  /// Widget tests disable runtime font fetching; the app keeps it on.
  static bool useGoogleFonts = true;

  // Surfaces
  static const bg = Color(0xFF0A0D0B),
      bgRaised = Color(0xFF0F1411),
      surface = Color(0xFF141A16),
      surfaceHigh = Color(0xFF1B231E),
      line = Color(0xFF243029),
      lineStrong = Color(0xFF33423A);

  // Text
  static const text = Color(0xFFF1F5EE),
      muted = Color(0xFF9AA89F),
      subtle = Color(0xFF66746B);

  // Brand + semantic
  static const accent = Color(0xFFCDF46A),
      accentDeep = Color(0xFF94C23A),
      mint = Color(0xFF63E6BE),
      sky = Color(0xFF79C3FF),
      violet = Color(0xFFB59DFF),
      orange = Color(0xFFFFB86B),
      coral = Color(0xFFFF7D7D);

  static const gap = 20.0, radius = 24.0, radiusSm = 14.0;

  static const brandGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFD9F77A), Color(0xFFA6EE8A), Color(0xFF63E6BE)],
  );
  static const coachGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFB59DFF), Color(0xFF79C3FF)],
  );
  static const surfaceGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF18201B), Color(0xFF121814)],
  );

  static List<BoxShadow> glow(Color c, {double strength = .28}) => [
    BoxShadow(
      color: c.withValues(alpha: strength),
      blurRadius: 32,
      spreadRadius: -6,
      offset: const Offset(0, 12),
    ),
  ];

  static const cardShadow = [
    BoxShadow(color: Color(0x66000000), blurRadius: 24, offset: Offset(0, 10)),
  ];

  /// Display face for headlines and numbers.
  static TextStyle display(TextStyle base) =>
      useGoogleFonts ? GoogleFonts.spaceGrotesk(textStyle: base) : base;

  static TextTheme _text() {
    const t = TextTheme(
      displayLarge: TextStyle(
        fontSize: 56,
        fontWeight: FontWeight.w700,
        letterSpacing: -2.2,
        height: 1.02,
      ),
      displayMedium: TextStyle(
        fontSize: 46,
        fontWeight: FontWeight.w700,
        letterSpacing: -1.8,
        height: 1.05,
      ),
      displaySmall: TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.w700,
        letterSpacing: -1.3,
        height: 1.1,
      ),
      headlineMedium: TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.w700,
        letterSpacing: -.7,
        height: 1.2,
      ),
      headlineSmall: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        letterSpacing: -.4,
      ),
      titleLarge: TextStyle(
        fontSize: 19,
        fontWeight: FontWeight.w700,
        letterSpacing: -.2,
      ),
      titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      bodyLarge: TextStyle(fontSize: 16, height: 1.55),
      bodyMedium: TextStyle(fontSize: 14, height: 1.5),
      bodySmall: TextStyle(fontSize: 12.5, height: 1.45, color: muted),
      labelLarge: TextStyle(fontSize: 14.5, fontWeight: FontWeight.w700),
      labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
      labelSmall: TextStyle(
        fontSize: 11,
        letterSpacing: 1.6,
        fontWeight: FontWeight.w700,
      ),
    );
    final body = useGoogleFonts ? GoogleFonts.interTextTheme(t) : t;
    TextStyle? d(TextStyle? s) => s == null ? null : display(s);
    return body
        .copyWith(
          displayLarge: d(body.displayLarge),
          displayMedium: d(body.displayMedium),
          displaySmall: d(body.displaySmall),
          headlineMedium: d(body.headlineMedium),
          headlineSmall: d(body.headlineSmall),
          titleLarge: d(body.titleLarge),
        )
        .apply(bodyColor: text, displayColor: text);
  }

  static ThemeData get dark {
    final textTheme = _text();
    final rounded = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radiusSm),
    );
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: bg,
      canvasColor: bg,
      colorScheme: const ColorScheme.dark(
        primary: accent,
        onPrimary: bg,
        primaryContainer: Color(0xFF2C3A16),
        onPrimaryContainer: accent,
        secondary: mint,
        onSecondary: bg,
        tertiary: violet,
        surface: surface,
        onSurface: text,
        onSurfaceVariant: muted,
        surfaceContainerLowest: bg,
        surfaceContainerLow: bgRaised,
        surfaceContainer: surface,
        surfaceContainerHigh: surfaceHigh,
        surfaceContainerHighest: Color(0xFF222C26),
        outline: lineStrong,
        outlineVariant: line,
        error: coral,
      ),
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: bg,
        surfaceTintColor: Colors.transparent,
        centerTitle: false,
        titleTextStyle: textTheme.titleLarge,
      ),
      cardTheme: CardThemeData(
        color: surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
          side: const BorderSide(color: line),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: bgRaised,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 16,
        ),
        labelStyle: const TextStyle(color: muted),
        hintStyle: const TextStyle(color: subtle),
        prefixIconColor: muted,
        suffixIconColor: muted,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusSm),
          borderSide: const BorderSide(color: line),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusSm),
          borderSide: const BorderSide(color: line),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusSm),
          borderSide: const BorderSide(color: accent, width: 1.4),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusSm),
          borderSide: const BorderSide(color: coral),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: accent,
          foregroundColor: bg,
          disabledBackgroundColor: surfaceHigh,
          disabledForegroundColor: subtle,
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
          shape: rounded,
          textStyle: textTheme.labelLarge,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: text,
          side: const BorderSide(color: lineStrong),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 17),
          shape: rounded,
          textStyle: textTheme.labelLarge,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: accent,
          shape: rounded,
          textStyle: textTheme.labelLarge,
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(foregroundColor: text),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: accent,
        foregroundColor: bg,
        elevation: 0,
        highlightElevation: 0,
        extendedTextStyle: textTheme.labelLarge,
        shape: const StadiumBorder(),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: bgRaised,
        selectedColor: accent,
        disabledColor: surface,
        side: const BorderSide(color: line),
        shape: const StadiumBorder(),
        labelStyle: textTheme.labelMedium?.copyWith(color: text),
        secondaryLabelStyle: textTheme.labelMedium?.copyWith(color: bg),
        checkmarkColor: bg,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      ),
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: SegmentedButton.styleFrom(
          backgroundColor: bgRaised,
          selectedBackgroundColor: accent,
          selectedForegroundColor: bg,
          foregroundColor: muted,
          side: const BorderSide(color: line),
          textStyle: textTheme.labelMedium,
        ),
      ),
      sliderTheme: const SliderThemeData(
        activeTrackColor: accent,
        inactiveTrackColor: line,
        thumbColor: accent,
        overlayColor: Color(0x22CDF46A),
        trackHeight: 6,
        valueIndicatorColor: accent,
        valueIndicatorTextStyle: TextStyle(
          color: bg,
          fontWeight: FontWeight.w700,
        ),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected) ? bg : muted,
        ),
        trackColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected)
              ? accent.withValues(
                  alpha: s.contains(WidgetState.disabled) ? .35 : 1,
                )
              : surfaceHigh,
        ),
        trackOutlineColor: WidgetStateProperty.all(line),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: accent,
        linearTrackColor: line,
        circularTrackColor: line,
      ),
      listTileTheme: ListTileThemeData(
        iconColor: muted,
        textColor: text,
        subtitleTextStyle: textTheme.bodySmall,
        shape: rounded,
      ),
      dividerTheme: const DividerThemeData(color: line, space: 1),
      dividerColor: line,
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: bgRaised,
        surfaceTintColor: Colors.transparent,
        showDragHandle: true,
        dragHandleColor: lineStrong,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: bgRaised,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
          side: const BorderSide(color: line),
        ),
        titleTextStyle: textTheme.headlineSmall,
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: surfaceHigh,
        contentTextStyle: textTheme.bodyMedium,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusSm),
          side: const BorderSide(color: lineStrong),
        ),
      ),
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: surfaceHigh,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: lineStrong),
        ),
        textStyle: textTheme.labelMedium?.copyWith(color: text),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        indicatorColor: accent,
        height: 68,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        labelTextStyle: WidgetStateProperty.resolveWith(
          (s) => textTheme.labelMedium?.copyWith(
            color: s.contains(WidgetState.selected) ? text : muted,
          ),
        ),
        iconTheme: WidgetStateProperty.resolveWith(
          (s) => IconThemeData(
            color: s.contains(WidgetState.selected) ? bg : muted,
          ),
        ),
      ),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: FadeForwardsPageTransitionsBuilder(),
          TargetPlatform.iOS: FadeForwardsPageTransitionsBuilder(),
          TargetPlatform.windows: FadeForwardsPageTransitionsBuilder(),
          TargetPlatform.macOS: FadeForwardsPageTransitionsBuilder(),
          TargetPlatform.linux: FadeForwardsPageTransitionsBuilder(),
        },
      ),
    );
  }

  /// Color for an estimated training-load band.
  static Color band(String band) => switch (band) {
    'HIGH RECENT LOAD' => coral,
    'MODERATE LOAD' => orange,
    _ => accent,
  };

  /// Visual identity for event categories.
  static (IconData, Color) category(String c) => switch (c) {
    'running' => (Icons.directions_run_rounded, accent),
    'cycling' => (Icons.directions_bike_rounded, sky),
    'yoga' => (Icons.self_improvement_rounded, violet),
    'sports' => (Icons.sports_tennis_rounded, orange),
    _ => (Icons.fitness_center_rounded, mint),
  };

  static Color status(String s) => switch (s) {
    'available' || 'resolved' || 'checks passed' || 'completed' => accent,
    'maintenance' || 'in progress' || 'needs attention' || 'active' => orange,
    'unavailable' || 'open' || 'high' => coral,
    _ => muted,
  };
}
