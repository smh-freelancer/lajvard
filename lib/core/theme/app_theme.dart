// [OWNER] — Theme module. Generates light and dark Material 3 themes.
// [OWNER] — All visual elements are overridable from AppThemeConfig.
// [DEV] — Fully standalone: copy color/, typography/, and theme/ folders together.
// [DEV] — Theme switching is instant because we pre-build both themes.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../color/app_color_palette.dart';
import '../typography/app_typography.dart';
import 'app_theme_config.dart';
import 'app_theme_extension.dart';

/// [DEV] — Main theme module. Call `AppTheme(colors, typography, config)` to get
/// [DEV] — pre-built light and dark themes with all Lajvard tokens.
class AppTheme {
  final LajvardColors colors;
  final LajvardTypography typography;
  final AppThemeConfig config;

  const AppTheme({
    required this.colors,
    required this.typography,
    this.config = const AppThemeConfig(),
  });

  /// [DEV] — Generates the light ThemeData.
  ThemeData get light => _buildTheme(isDark: false);

  /// [DEV] — Generates the dark ThemeData.
  ThemeData get dark => _buildTheme(isDark: true);

  ThemeData _buildTheme({required bool isDark}) {
    final colorScheme = _buildColorScheme(isDark: isDark);
    final textTheme = typography.toTextTheme(
      color: isDark ? colors.textPrimaryDark : colors.textPrimaryLight,
    );
    final extension = _buildExtension(isDark: isDark);

    return ThemeData(
      useMaterial3: true,
      brightness: isDark ? Brightness.dark : Brightness.light,
      colorScheme: colorScheme,
      textTheme: textTheme,
      extensions: [extension],

      // [DEV] — Scaffold uses gradient background (applied in widget, not here,
      // [DEV] — because Scaffold.backgroundColor doesn't support gradients).
      scaffoldBackgroundColor:
          isDark ? colors.backgroundDarkStart : colors.backgroundLightStart,

      // [DEV] — Card styling with generous border radius.
      cardTheme: CardThemeData(
        color: isDark
            ? colors.surfaceDark.withValues(alpha: config.glassOpacity)
            : colors.surfaceLight.withValues(alpha: config.glassOpacity),
        elevation: config.elevationLow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(config.borderRadiusLarge),
        ),
        clipBehavior: Clip.antiAlias,
      ),

      // [DEV] — AppBar: transparent to show gradient background.
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: textTheme.headlineMedium?.copyWith(
          color: isDark ? colors.textPrimaryDark : colors.textPrimaryLight,
          fontWeight: FontWeight.w600,
        ),
        iconTheme: IconThemeData(
          color: isDark ? colors.textPrimaryDark : colors.textPrimaryLight,
        ),
      ),

      // [DEV] — Input decoration for search fields.
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isDark
            ? colors.surfaceDark.withValues(alpha: 0.3)
            : colors.surfaceLight.withValues(alpha: 0.5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(config.borderRadiusExtraLarge),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        hintStyle: textTheme.bodyLarge?.copyWith(
          color: isDark ? colors.textSecondaryDark : colors.textSecondaryLight,
        ),
      ),

      // [DEV] — Divider subtle styling.
      dividerTheme: DividerThemeData(
        color: (isDark ? colors.textSecondaryDark : colors.textSecondaryLight)
            .withValues(alpha: 0.2),
        thickness: 0.5,
      ),

      // [DEV] — Scrollbar styling.
      scrollbarTheme: ScrollbarThemeData(
        thumbColor: WidgetStatePropertyAll(
          (isDark ? colors.textSecondaryDark : colors.textSecondaryLight)
              .withValues(alpha: 0.4),
        ),
        radius: const Radius.circular(4),
        thickness: const WidgetStatePropertyAll(4),
      ),

      // [DEV] — Bottom navigation bar (if needed in future).
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: isDark
            ? colors.surfaceDark.withValues(alpha: 0.5)
            : colors.surfaceLight.withValues(alpha: 0.7),
        selectedItemColor: colors.accent,
        unselectedItemColor:
            isDark ? colors.textSecondaryDark : colors.textSecondaryLight,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),

      // [DEV] — Page transitions — subtle fade for premium feel.
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
        },
      ),
    );
  }

  ColorScheme _buildColorScheme({required bool isDark}) {
    return ColorScheme(
      brightness: isDark ? Brightness.dark : Brightness.light,
      primary: isDark ? colors.primaryLight : colors.primary,
      onPrimary: isDark ? colors.primaryDark : colors.surfaceLight,
      primaryContainer: isDark ? colors.primaryDark : colors.primaryLight,
      onPrimaryContainer: isDark ? colors.primaryLight : colors.primaryDark,
      secondary: isDark ? colors.secondaryLight : colors.secondary,
      onSecondary: isDark ? colors.secondaryDark : colors.surfaceLight,
      secondaryContainer: isDark ? colors.secondaryDark : colors.secondaryLight,
      onSecondaryContainer:
          isDark ? colors.secondaryLight : colors.secondaryDark,
      tertiary: colors.accent,
      onTertiary: colors.primaryDark,
      tertiaryContainer: colors.accentLight,
      onTertiaryContainer: colors.accentDark,
      error: colors.error,
      onError: colors.surfaceLight,
      errorContainer: colors.error.withValues(alpha: 0.15),
      onErrorContainer: colors.error,
      surface: isDark ? colors.surfaceDark : colors.surfaceLight,
      onSurface: isDark ? colors.textPrimaryDark : colors.textPrimaryLight,
      surfaceContainerHighest: isDark
          ? colors.surfaceDark.withValues(alpha: 0.5)
          : colors.surfaceLight.withValues(alpha: 0.8),
      outline: isDark
          ? colors.textSecondaryDark.withValues(alpha: 0.3)
          : colors.textSecondaryLight.withValues(alpha: 0.3),
      outlineVariant: isDark
          ? colors.textSecondaryDark.withValues(alpha: 0.15)
          : colors.textSecondaryLight.withValues(alpha: 0.15),
    );
  }

  AppThemeExtension _buildExtension({required bool isDark}) {
    return AppThemeExtension(
      backgroundGradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: isDark
            ? [colors.backgroundDarkStart, colors.backgroundDarkEnd]
            : [colors.backgroundLightStart, colors.backgroundLightEnd],
      ),
      cardGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: isDark
            ? [
                colors.surfaceDark.withValues(alpha: 0.25),
                colors.surfaceDark.withValues(alpha: 0.10),
              ]
            : [
                colors.surfaceLight.withValues(alpha: 0.60),
                colors.surfaceLight.withValues(alpha: 0.30),
              ],
      ),
      accentGradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFFD4A843), Color(0xFFE8C96A)],
      ),
      glassFillColor: isDark
          ? colors.surfaceDark.withValues(alpha: config.glassOpacity)
          : colors.surfaceLight.withValues(alpha: config.glassOpacity + 0.15),
      glassBorderColor:
          isDark ? colors.glassBorderDark : colors.glassBorderLight,
      glassBlurSigma: config.glassBlurSigma,
      glassOpacity: config.glassOpacity,
      borderRadiusSmall: BorderRadius.circular(config.borderRadiusSmall),
      borderRadiusMedium: BorderRadius.circular(config.borderRadiusMedium),
      borderRadiusLarge: BorderRadius.circular(config.borderRadiusLarge),
      borderRadiusExtraLarge:
          BorderRadius.circular(config.borderRadiusExtraLarge),
      glassShadow: [
        BoxShadow(
          color: isDark ? colors.glassShadowDark : colors.glassShadowLight,
          blurRadius: config.elevationMedium * 2,
          offset: const Offset(0, 4),
        ),
      ],
      cardShadow: [
        BoxShadow(
          color: isDark ? colors.glassShadowDark : colors.glassShadowLight,
          blurRadius: config.elevationLow * 2,
          offset: const Offset(0, 2),
        ),
      ],
      goldenAccent: colors.accent,
      goldenAccentLight: colors.accentLight,
    );
  }

  /// [DEV] — Resolves the correct theme based on ThemeMode.
  /// [DEV] — Returns dark for ThemeMode.dark, light for ThemeMode.light,
  /// [DEV] — or falls back to platform brightness for ThemeMode.system.
  ThemeData resolveThemeMode(ThemeMode mode, Brightness platformBrightness) {
    switch (mode) {
      case ThemeMode.dark:
        return dark;
      case ThemeMode.light:
        return light;
      case ThemeMode.system:
        return platformBrightness == Brightness.dark ? dark : light;
    }
  }
}
