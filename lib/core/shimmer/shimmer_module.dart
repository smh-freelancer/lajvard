// [OWNER] — Shimmer loading placeholder module.
// [OWNER] — Wraps the shimmer package to provide a consistent loading style.
// [DEV] — Fully standalone: copy this file, import, use ShimmerModule.placeholder().

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerModule {
  ShimmerModule._();

  /// [DEV] — Provides a standard shimmer wrapper matching the Lajvard dark theme.
  static Widget placeholder({required Widget child}) {
    return Shimmer.fromColors(
      baseColor: Colors.white.withValues(alpha: 0.1),
      highlightColor: Colors.white.withValues(alpha: 0.2),
      child: child,
    );
  }
}
