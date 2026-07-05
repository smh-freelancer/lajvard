// [OWNER] — Reusable fade-in animation widget.
// [DEV] — Fully standalone. Respects reduceMotion setting.

import 'package:flutter/material.dart';
import 'animation_config.dart';

class FadeInAnimation extends StatefulWidget {
  final Widget child;
  final Duration? duration;
  final Curve? curve;
  final double delayFactor;

  const FadeInAnimation({
    super.key,
    required this.child,
    this.duration,
    this.curve,
    this.delayFactor = 0.0,
  });

  @override
  State<FadeInAnimation> createState() => _FadeInAnimationState();
}

class _FadeInAnimationState extends State<FadeInAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    const config = AnimationConfig();

    _controller = AnimationController(
      vsync: this,
      duration: widget.duration ?? config.mediumDuration,
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: widget.curve ?? config.defaultCurve,
      ),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _controller,
        curve: widget.curve ?? config.defaultCurve,
      ),
    );

    if (config.shouldAnimate) {
      Future.delayed(
        Duration(milliseconds: (widget.delayFactor * 200).round()),
        () => mounted ? _controller.forward() : null,
      );
    } else {
      _controller.value = 1.0; // [DEV] — Skip animation immediately
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _opacityAnimation.value,
          child: Transform.translate(
            offset: _slideAnimation.value,
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}
