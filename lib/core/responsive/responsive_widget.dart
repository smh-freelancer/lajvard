// [OWNER] — Responsive wrapper widget.
// [OWNER] — Automatically detects screen size and passes the correct builder.
// [DEV] — Builder pattern: pass different builders for phone/tablet/large.
// [DEV] — Fully standalone: copy this file + breakpoint_strategy.dart + screen_size_info.dart.

import 'package:flutter/material.dart';
import 'breakpoint_strategy.dart';
import 'screen_size_info.dart';

/// [DEV] — A widget that builds different layouts based on screen size.
/// [DEV] — Usage:
/// [DEV] ```dart
/// [DEV] ResponsiveWidget(
/// [DEV]   phone: (ctx, info) => PhoneLayout(),
/// [DEV]   tablet: (ctx, info) => TabletLayout(),
/// [DEV]   large: (ctx, info) => LargeLayout(),
/// [DEV] )
/// [DEV] ```
class ResponsiveWidget extends StatelessWidget {
  final ResponsiveBuilder phone;
  final ResponsiveBuilder? tablet;
  final ResponsiveBuilder? large;

  const ResponsiveWidget({
    super.key,
    required this.phone,
    this.tablet,
    this.large,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final info = ScreenSizeInfo.fromConstraints(constraints);

        switch (info.screenCategory) {
          case ScreenCategory.phone:
            return phone(context, info);
          case ScreenCategory.tablet:
            return (tablet ?? phone)(context, info);
          case ScreenCategory.large:
            return (large ?? tablet ?? phone)(context, info);
        }
      },
    );
  }
}

/// [DEV] — Typedef for builders that receive context and screen info.
typedef ResponsiveBuilder = Widget Function(
  BuildContext context,
  ScreenSizeInfo info,
);

/// [DEV] — A simpler version that just provides ScreenSizeInfo to a single builder.
class ScreenSizeWidget extends StatelessWidget {
  final Widget Function(BuildContext context, ScreenSizeInfo info) builder;

  const ScreenSizeWidget({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final info = ScreenSizeInfo.fromConstraints(constraints);
        return builder(context, info);
      },
    );
  }
}
