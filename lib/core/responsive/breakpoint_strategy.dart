// [OWNER] — Responsive breakpoint definitions.
// [OWNER] — Defines screen size categories for adaptive layout.
// [DEV] — Strategy pattern: pass this to layout widgets to switch behavior.
// [DEV] — Fully standalone: copy this file, import, use the constants.

import 'package:flutter/material.dart';

/// [DEV] — Breakpoint thresholds in logical pixels.
class Breakpoints {
  static const double phone = 600;
  static const double tablet = 840;
}

/// [DEV] — Screen size category enum.
enum ScreenCategory {
  phone,
  tablet,
  large,
}

/// [DEV] — Strategy class to determine layout based on screen width.
class BreakpointStrategy {
  /// [DEV] — Returns the screen category based on width.
  static ScreenCategory fromWidth(double width) {
    if (width < Breakpoints.phone) {
      return ScreenCategory.phone;
    } else if (width < Breakpoints.tablet) {
      return ScreenCategory.tablet;
    } else {
      return ScreenCategory.large;
    }
  }

  /// [DEV] — Returns the number of columns for detail grids.
  static int gridColumns(double width) {
    switch (fromWidth(width)) {
      case ScreenCategory.phone:
        return 1;
      case ScreenCategory.tablet:
        return 2;
      case ScreenCategory.large:
        return 3;
    }
  }

  /// [DEV] — Returns horizontal padding for the screen.
  static double horizontalPadding(double width) {
    switch (fromWidth(width)) {
      case ScreenCategory.phone:
        return 16.0;
      case ScreenCategory.tablet:
        return 24.0;
      case ScreenCategory.large:
        return 32.0;
    }
  }

  /// [DEV] — Returns whether the device is currently in landscape orientation.
  static bool isLandscape(BoxConstraints constraints) {
    return constraints.maxWidth > constraints.maxHeight;
  }
}
