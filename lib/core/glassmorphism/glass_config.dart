// [OWNER] — Glassmorphism configuration class.
// [OWNER] — Controls blur, opacity, borders, and shadows for glass effects.
// [DEV] — Fully standalone: copy this file to tweak glass appearance app-wide.

import 'package:flutter/material.dart';

class GlassConfig {
  final double blurSigma;
  final double opacity;
  final Color fillColor;
  final Color borderColor;
  final double borderWidth;
  final double borderRadius;
  final List<BoxShadow> shadows;

  const GlassConfig({
    this.blurSigma = 20.0,
    this.opacity = 0.15,
    this.fillColor = Colors.white,
    this.borderColor = Colors.white,
    this.borderWidth = 0.5,
    this.borderRadius = 20.0,
    this.shadows = const [],
  });

  /// [DEV] — Dark mode preset
  factory GlassConfig.dark({Color accent = Colors.white}) {
    return GlassConfig(
      opacity: 0.10,
      fillColor: accent,
      borderColor: accent.withValues(alpha: 0.2),
      shadows: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.3),
          blurRadius: 16,
          offset: const Offset(0, 8),
        ),
      ],
    );
  }

  /// [DEV] — Light mode preset
  factory GlassConfig.light({Color accent = Colors.white}) {
    return GlassConfig(
      blurSigma: 25.0,
      opacity: 0.60,
      fillColor: accent,
      borderColor: accent.withValues(alpha: 0.6),
      shadows: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }

  GlassConfig copyWith({
    double? blurSigma,
    double? opacity,
    Color? fillColor,
    Color? borderColor,
    double? borderWidth,
    double? borderRadius,
    List<BoxShadow>? shadows,
  }) {
    return GlassConfig(
      blurSigma: blurSigma ?? this.blurSigma,
      opacity: opacity ?? this.opacity,
      fillColor: fillColor ?? this.fillColor,
      borderColor: borderColor ?? this.borderColor,
      borderWidth: borderWidth ?? this.borderWidth,
      borderRadius: borderRadius ?? this.borderRadius,
      shadows: shadows ?? this.shadows,
    );
  }
}
