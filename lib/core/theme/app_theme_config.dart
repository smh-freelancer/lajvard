// [OWNER] — Single configuration class that controls every visual aspect of the theme.
// [OWNER] — If you want to change how the app looks, modify values here.
// [DEV] — Used by AppTheme to generate light/dark ThemeData.
// [DEV] — All properties have sensible defaults matching the Lajvard identity.

import 'package:flutter/material.dart';

class AppThemeConfig {
  // ── Colors ────────────────────────────────────────────────────────
  final Color seedColor;
  final Color scaffoldBackgroundLight;
  final Color scaffoldBackgroundDark;
  final Color cardColorLight;
  final Color cardColorDark;

  // ── Shapes ────────────────────────────────────────────────────────
  final double borderRadiusSmall;
  final double borderRadiusMedium;
  final double borderRadiusLarge;
  final double borderRadiusExtraLarge;

  // ── Elevation ─────────────────────────────────────────────────────
  final double elevationLow;
  final double elevationMedium;
  final double elevationHigh;

  // ── Glassmorphism ─────────────────────────────────────────────────
  final double glassBlurSigma;
  final double glassOpacity;
  final Color glassBorderLight;
  final Color glassBorderDark;

  // ── Animation ─────────────────────────────────────────────────────
  final Duration themeAnimationDuration;

  const AppThemeConfig({
    this.seedColor = const Color(0xFF1E3A5F),
    this.scaffoldBackgroundLight = const Color(0xFFD6E6F5),
    this.scaffoldBackgroundDark = const Color(0xFF0A1628),
    this.cardColorLight = const Color(0xE6FFFFFF),
    this.cardColorDark = const Color(0x1A2A4080),
    this.borderRadiusSmall = 8.0,
    this.borderRadiusMedium = 16.0,
    this.borderRadiusLarge = 20.0,
    this.borderRadiusExtraLarge = 28.0,
    this.elevationLow = 2.0,
    this.elevationMedium = 4.0,
    this.elevationHigh = 8.0,
    this.glassBlurSigma = 20.0,
    this.glassOpacity = 0.18,
    this.glassBorderLight = const Color(0x40FFFFFF),
    this.glassBorderDark = const Color(0x30FFFFFF),
    this.themeAnimationDuration = const Duration(milliseconds: 300),
  });

  /// [DEV] — Creates a copy with optional overrides.
  AppThemeConfig copyWith({
    Color? seedColor,
    Color? scaffoldBackgroundLight,
    Color? scaffoldBackgroundDark,
    Color? cardColorLight,
    Color? cardColorDark,
    double? borderRadiusSmall,
    double? borderRadiusMedium,
    double? borderRadiusLarge,
    double? borderRadiusExtraLarge,
    double? elevationLow,
    double? elevationMedium,
    double? elevationHigh,
    double? glassBlurSigma,
    double? glassOpacity,
    Color? glassBorderLight,
    Color? glassBorderDark,
    Duration? themeAnimationDuration,
  }) {
    return AppThemeConfig(
      seedColor: seedColor ?? this.seedColor,
      scaffoldBackgroundLight:
          scaffoldBackgroundLight ?? this.scaffoldBackgroundLight,
      scaffoldBackgroundDark:
          scaffoldBackgroundDark ?? this.scaffoldBackgroundDark,
      cardColorLight: cardColorLight ?? this.cardColorLight,
      cardColorDark: cardColorDark ?? this.cardColorDark,
      borderRadiusSmall: borderRadiusSmall ?? this.borderRadiusSmall,
      borderRadiusMedium: borderRadiusMedium ?? this.borderRadiusMedium,
      borderRadiusLarge: borderRadiusLarge ?? this.borderRadiusLarge,
      borderRadiusExtraLarge:
          borderRadiusExtraLarge ?? this.borderRadiusExtraLarge,
      elevationLow: elevationLow ?? this.elevationLow,
      elevationMedium: elevationMedium ?? this.elevationMedium,
      elevationHigh: elevationHigh ?? this.elevationHigh,
      glassBlurSigma: glassBlurSigma ?? this.glassBlurSigma,
      glassOpacity: glassOpacity ?? this.glassOpacity,
      glassBorderLight: glassBorderLight ?? this.glassBorderLight,
      glassBorderDark: glassBorderDark ?? this.glassBorderDark,
      themeAnimationDuration:
          themeAnimationDuration ?? this.themeAnimationDuration,
    );
  }
}
