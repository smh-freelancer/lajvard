// [OWNER] — Lapis Lazuli color palette module.
// [OWNER] — All colors are inspired by the deep blue gemstone: primary blues,
// [OWNER] — golden pyrite accents, and translucent surfaces for glass effects.
// [DEV] — Fully standalone: copy this file, import it, call `LajvardColors()`.
// [DEV] — All light/dark variants are provided. Colors meet WCAG AA contrast.

import 'package:flutter/material.dart';

/// [DEV] — Represents the complete Lapis Lazuli color palette.
/// [DEV] — Constructor accepts optional overrides for full customization.
class LajvardColors {
  // ── Primary: Deep Lapis Blue ──────────────────────────────────────
  final Color primaryLight;
  final Color primary;
  final Color primaryDark;

  // ── Secondary: Ultramarine Blue ───────────────────────────────────
  final Color secondaryLight;
  final Color secondary;
  final Color secondaryDark;

  // ── Accent: Golden Pyrite Flecks ──────────────────────────────────
  final Color accentLight;
  final Color accent;
  final Color accentDark;

  // ── Surface: Translucent Whites/Blues for Glass Effect ────────────
  final Color surfaceLight;
  final Color surface;
  final Color surfaceDark;

  // ── Background: Gradient Endpoints ────────────────────────────────
  final Color backgroundLightStart;
  final Color backgroundLightEnd;
  final Color backgroundDarkStart;
  final Color backgroundDarkEnd;

  // ── Text ──────────────────────────────────────────────────────────
  final Color textPrimaryLight;
  final Color textPrimaryDark;
  final Color textSecondaryLight;
  final Color textSecondaryDark;

  // ── Status ────────────────────────────────────────────────────────
  final Color success;
  final Color warning;
  final Color error;
  final Color info;

  // ── Glass Specific ────────────────────────────────────────────────
  final Color glassBorderLight;
  final Color glassBorderDark;
  final Color glassShadowLight;
  final Color glassShadowDark;

  const LajvardColors({
    // Primary
    this.primaryLight = const Color(0xFF4A7FB5),
    this.primary = const Color(0xFF1E3A5F),
    this.primaryDark = const Color(0xFF0F1F33),
    // Secondary
    this.secondaryLight = const Color(0xFF6B8AC4),
    this.secondary = const Color(0xFF3B5998),
    this.secondaryDark = const Color(0xFF243B6A),
    // Accent
    this.accentLight = const Color(0xFFE8C96A),
    this.accent = const Color(0xFFD4A843),
    this.accentDark = const Color(0xFFA17E2E),
    // Surface
    this.surfaceLight = const Color(0xFFFFFFFF),
    this.surface = const Color(0x00e6edf5),
    this.surfaceDark = const Color(0xFF1A2A40),
    // Background
    this.backgroundLightStart = const Color(0xFFD6E6F5),
    this.backgroundLightEnd = const Color(0xFFA8C8E8),
    this.backgroundDarkStart = const Color(0xFF0A1628),
    this.backgroundDarkEnd = const Color(0xFF162D50),
    // Text
    this.textPrimaryLight = const Color(0xFF1A2A40),
    this.textPrimaryDark = const Color(0xFFF0F4F8),
    this.textSecondaryLight = const Color(0xFF4A6280),
    this.textSecondaryDark = const Color(0xFFA0B4CC),
    // Status
    this.success = const Color(0xFF34C759),
    this.warning = const Color(0xFFFF9500),
    this.error = const Color(0xFFFF3B30),
    this.info = const Color(0xFF5AC8FA),
    // Glass
    this.glassBorderLight = const Color(0x40FFFFFF),
    this.glassBorderDark = const Color(0x30FFFFFF),
    this.glassShadowLight = const Color(0x1A000000),
    this.glassShadowDark = const Color(0x33000000),
  });

  /// [DEV] — Convenience getter: returns light-mode text colors.
  Color get textPrimary => textPrimaryLight;
  Color get textSecondary => textSecondaryLight;

  /// [DEV] — Creates a copy with overridden fields. Useful for runtime customization.
  LajvardColors copyWith({
    Color? primaryLight,
    Color? primary,
    Color? primaryDark,
    Color? secondaryLight,
    Color? secondary,
    Color? secondaryDark,
    Color? accentLight,
    Color? accent,
    Color? accentDark,
    Color? surfaceLight,
    Color? surface,
    Color? surfaceDark,
    Color? backgroundLightStart,
    Color? backgroundLightEnd,
    Color? backgroundDarkStart,
    Color? backgroundDarkEnd,
    Color? textPrimaryLight,
    Color? textPrimaryDark,
    Color? textSecondaryLight,
    Color? textSecondaryDark,
    Color? success,
    Color? warning,
    Color? error,
    Color? info,
    Color? glassBorderLight,
    Color? glassBorderDark,
    Color? glassShadowLight,
    Color? glassShadowDark,
  }) {
    return LajvardColors(
      primaryLight: primaryLight ?? this.primaryLight,
      primary: primary ?? this.primary,
      primaryDark: primaryDark ?? this.primaryDark,
      secondaryLight: secondaryLight ?? this.secondaryLight,
      secondary: secondary ?? this.secondary,
      secondaryDark: secondaryDark ?? this.secondaryDark,
      accentLight: accentLight ?? this.accentLight,
      accent: accent ?? this.accent,
      accentDark: accentDark ?? this.accentDark,
      surfaceLight: surfaceLight ?? this.surfaceLight,
      surface: surface ?? this.surface,
      surfaceDark: surfaceDark ?? this.surfaceDark,
      backgroundLightStart: backgroundLightStart ?? this.backgroundLightStart,
      backgroundLightEnd: backgroundLightEnd ?? this.backgroundLightEnd,
      backgroundDarkStart: backgroundDarkStart ?? this.backgroundDarkStart,
      backgroundDarkEnd: backgroundDarkEnd ?? this.backgroundDarkEnd,
      textPrimaryLight: textPrimaryLight ?? this.textPrimaryLight,
      textPrimaryDark: textPrimaryDark ?? this.textPrimaryDark,
      textSecondaryLight: textSecondaryLight ?? this.textSecondaryLight,
      textSecondaryDark: textSecondaryDark ?? this.textSecondaryDark,
      success: success ?? this.success,
      warning: warning ?? this.warning,
      error: error ?? this.error,
      info: info ?? this.info,
      glassBorderLight: glassBorderLight ?? this.glassBorderLight,
      glassBorderDark: glassBorderDark ?? this.glassBorderDark,
      glassShadowLight: glassShadowLight ?? this.glassShadowLight,
      glassShadowDark: glassShadowDark ?? this.glassShadowDark,
    );
  }
}
