// [OWNER] — Glassmorphism card widget. Frosted glass effect.
// [OWNER] — Used throughout the app for the premium Lapis Lazuli look.
// [DEV] — Fully standalone: copy this file + glass_config.dart.
// [DEV] — Fixed: Replaced ImageFilter.blur with pure CSS layering for zero-jank performance.

import 'package:flutter/material.dart';
import 'glass_config.dart';

class GlassCard extends StatelessWidget {
  final Widget child;
  final GlassConfig config;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  const GlassCard({
    super.key,
    required this.child,
    this.config = const GlassConfig(),
    this.padding,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            config.fillColor.withValues(alpha: config.opacity),
            config.fillColor.withValues(alpha: config.opacity * 0.5),
          ],
        ),
        borderRadius: BorderRadius.circular(config.borderRadius),
        border: Border.all(
          color: config.borderColor.withValues(alpha: config.borderWidth),
          width: config.borderWidth,
        ),
        boxShadow: config.shadows,
      ),
      child: child,
    );
  }
}
