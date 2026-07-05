// [OWNER] — Custom theme extension for Lajvard-specific design tokens.
// [OWNER] — These are values that Material 3 doesn't provide by default.
// [DEV] — Accessed via: `Theme.of(context).extension<AppThemeExtension>()`.
// [DEV] — Automatically switches between light/dark when theme changes.

import 'package:flutter/material.dart';

@immutable
class AppThemeExtension extends ThemeExtension<AppThemeExtension> {
  // ── Gradients ─────────────────────────────────────────────────────
  final LinearGradient backgroundGradient;
  final LinearGradient cardGradient;
  final LinearGradient accentGradient;

  // ── Glass ─────────────────────────────────────────────────────────
  final Color glassFillColor;
  final Color glassBorderColor;
  final double glassBlurSigma;
  final double glassOpacity;

  // ── Border Radius ─────────────────────────────────────────────────
  final BorderRadius borderRadiusSmall;
  final BorderRadius borderRadiusMedium;
  final BorderRadius borderRadiusLarge;
  final BorderRadius borderRadiusExtraLarge;

  // ── Shadows ───────────────────────────────────────────────────────
  final List<BoxShadow> glassShadow;
  final List<BoxShadow> cardShadow;

  // ── Accent ────────────────────────────────────────────────────────
  final Color goldenAccent;
  final Color goldenAccentLight;

  const AppThemeExtension({
    required this.backgroundGradient,
    required this.cardGradient,
    required this.accentGradient,
    required this.glassFillColor,
    required this.glassBorderColor,
    required this.glassBlurSigma,
    required this.glassOpacity,
    required this.borderRadiusSmall,
    required this.borderRadiusMedium,
    required this.borderRadiusLarge,
    required this.borderRadiusExtraLarge,
    required this.glassShadow,
    required this.cardShadow,
    required this.goldenAccent,
    required this.goldenAccentLight,
  });

  @override
  AppThemeExtension copyWith({
    LinearGradient? backgroundGradient,
    LinearGradient? cardGradient,
    LinearGradient? accentGradient,
    Color? glassFillColor,
    Color? glassBorderColor,
    double? glassBlurSigma,
    double? glassOpacity,
    BorderRadius? borderRadiusSmall,
    BorderRadius? borderRadiusMedium,
    BorderRadius? borderRadiusLarge,
    BorderRadius? borderRadiusExtraLarge,
    List<BoxShadow>? glassShadow,
    List<BoxShadow>? cardShadow,
    Color? goldenAccent,
    Color? goldenAccentLight,
  }) {
    return AppThemeExtension(
      backgroundGradient: backgroundGradient ?? this.backgroundGradient,
      cardGradient: cardGradient ?? this.cardGradient,
      accentGradient: accentGradient ?? this.accentGradient,
      glassFillColor: glassFillColor ?? this.glassFillColor,
      glassBorderColor: glassBorderColor ?? this.glassBorderColor,
      glassBlurSigma: glassBlurSigma ?? this.glassBlurSigma,
      glassOpacity: glassOpacity ?? this.glassOpacity,
      borderRadiusSmall: borderRadiusSmall ?? this.borderRadiusSmall,
      borderRadiusMedium: borderRadiusMedium ?? this.borderRadiusMedium,
      borderRadiusLarge: borderRadiusLarge ?? this.borderRadiusLarge,
      borderRadiusExtraLarge:
          borderRadiusExtraLarge ?? this.borderRadiusExtraLarge,
      glassShadow: glassShadow ?? this.glassShadow,
      cardShadow: cardShadow ?? this.cardShadow,
      goldenAccent: goldenAccent ?? this.goldenAccent,
      goldenAccentLight: goldenAccentLight ?? this.goldenAccentLight,
    );
  }

  @override
  AppThemeExtension lerp(covariant AppThemeExtension? other, double t) {
    if (other == null) return this;
    return AppThemeExtension(
      backgroundGradient: Gradient.lerp(
        backgroundGradient,
        other.backgroundGradient,
        t,
      ) as LinearGradient,
      cardGradient:
          Gradient.lerp(cardGradient, other.cardGradient, t) as LinearGradient,
      accentGradient: Gradient.lerp(
        accentGradient,
        other.accentGradient,
        t,
      ) as LinearGradient,
      glassFillColor: Color.lerp(glassFillColor, other.glassFillColor, t)!,
      glassBorderColor:
          Color.lerp(glassBorderColor, other.glassBorderColor, t)!,
      glassBlurSigma:
          glassBlurSigma + (other.glassBlurSigma - glassBlurSigma) * t,
      glassOpacity: glassOpacity + (other.glassOpacity - glassOpacity) * t,
      borderRadiusSmall:
          BorderRadius.lerp(borderRadiusSmall, other.borderRadiusSmall, t)!,
      borderRadiusMedium:
          BorderRadius.lerp(borderRadiusMedium, other.borderRadiusMedium, t)!,
      borderRadiusLarge:
          BorderRadius.lerp(borderRadiusLarge, other.borderRadiusLarge, t)!,
      borderRadiusExtraLarge: BorderRadius.lerp(
        borderRadiusExtraLarge,
        other.borderRadiusExtraLarge,
        t,
      )!,
      glassShadow: _lerpShadowList(glassShadow, other.glassShadow, t),
      cardShadow: _lerpShadowList(cardShadow, other.cardShadow, t),
      goldenAccent: Color.lerp(goldenAccent, other.goldenAccent, t)!,
      goldenAccentLight:
          Color.lerp(goldenAccentLight, other.goldenAccentLight, t)!,
    );
  }

  /// [DEV] — Helper to lerp between two shadow lists.
  static List<BoxShadow> _lerpShadowList(
    List<BoxShadow> a,
    List<BoxShadow> b,
    double t,
  ) {
    if (a.length != b.length) return t < 0.5 ? a : b;
    return List.generate(a.length, (i) {
      return BoxShadow(
        color: Color.lerp(a[i].color, b[i].color, t) ?? a[i].color,
        offset: Offset.lerp(a[i].offset, b[i].offset, t) ?? a[i].offset,
        blurRadius: a[i].blurRadius + (b[i].blurRadius - a[i].blurRadius) * t,
        spreadRadius:
            a[i].spreadRadius + (b[i].spreadRadius - a[i].spreadRadius) * t,
      );
    });
  }
}
