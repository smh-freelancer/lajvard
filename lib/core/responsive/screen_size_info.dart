// [OWNER] — Screen size information holder.
// [OWNER] — Captures current screen metrics and calculates the responsive category.
// [DEV] — Immutable and lightweight. Used by ResponsiveWidget.

import 'package:flutter/material.dart';
import 'breakpoint_strategy.dart';

@immutable
class ScreenSizeInfo {
  final double screenWidth;
  final double screenHeight;
  final double devicePixelRatio;
  final ScreenCategory screenCategory;
  final Orientation orientation;
  final int gridColumns;
  final double horizontalPadding;

  const ScreenSizeInfo({
    required this.screenWidth,
    required this.screenHeight,
    required this.devicePixelRatio,
    required this.screenCategory,
    required this.orientation,
    required this.gridColumns,
    required this.horizontalPadding,
  });

  /// [DEV] — Factory to create from BuildContext using MediaQuery.
  factory ScreenSizeInfo.fromContext(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;
    final category = BreakpointStrategy.fromWidth(size.width);

    return ScreenSizeInfo(
      screenWidth: size.width,
      screenHeight: size.height,
      devicePixelRatio: mediaQuery.devicePixelRatio,
      screenCategory: category,
      orientation: mediaQuery.orientation,
      gridColumns: BreakpointStrategy.gridColumns(size.width),
      horizontalPadding: BreakpointStrategy.horizontalPadding(size.width),
    );
  }

  /// [DEV] — Factory to create from LayoutBuilder constraints.
  factory ScreenSizeInfo.fromConstraints(BoxConstraints constraints) {
    final category = BreakpointStrategy.fromWidth(constraints.maxWidth);
    final orientation = constraints.maxWidth > constraints.maxHeight
        ? Orientation.landscape
        : Orientation.portrait;

    return ScreenSizeInfo(
      screenWidth: constraints.maxWidth,
      screenHeight: constraints.maxHeight,
      devicePixelRatio: 1.0, // Not available in constraints
      screenCategory: category,
      orientation: orientation,
      gridColumns: BreakpointStrategy.gridColumns(constraints.maxWidth),
      horizontalPadding:
          BreakpointStrategy.horizontalPadding(constraints.maxWidth),
    );
  }

  /// [DEV] — Convenience getter for safe area insets.
  EdgeInsets safeAreaPadding(BuildContext context) {
    return MediaQuery.of(context).padding;
  }
}
