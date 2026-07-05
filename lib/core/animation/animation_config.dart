// [OWNER] — Animation configuration.
// [OWNER] — Default durations, curves, and accessibility checks.
// [DEV] — Fully standalone: copy this file to control all app animations.

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class AnimationConfig {
  final Duration fastDuration;
  final Duration mediumDuration;
  final Duration slowDuration;
  final Curve defaultCurve;

  const AnimationConfig({
    this.fastDuration = const Duration(milliseconds: 200),
    this.mediumDuration = const Duration(milliseconds: 400),
    this.slowDuration = const Duration(milliseconds: 800),
    this.defaultCurve = Curves.easeOutCubic,
  });

  /// [DEV] — Returns 0 if user has "Reduce Motion" enabled in system settings.
  /// [DEV] — Use this to multiply durations or skip animations entirely.
  double get motionMultiplier {
    // [DEV] — Binding.instance is the standard way to access platform accessibility.
    // Note: ignore: invalid_use_of_visible_for_testing_member is suppressed
    // because in app code (not tests) this is the correct approach.
    final disableAnimations = SchedulerBinding
        .instance.platformDispatcher.accessibilityFeatures.disableAnimations;
    return disableAnimations ? 0.0 : 1.0;
  }

  bool get shouldAnimate => motionMultiplier > 0;
}
