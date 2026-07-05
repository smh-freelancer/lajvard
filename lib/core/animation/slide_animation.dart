// [OWNER] — Reusable slide animation widget.
// [DEV] — Fully standalone. Respects reduceMotion setting.

import 'package:flutter/material.dart';
import 'animation_config.dart';

enum SlideDirection { up, down, left, right }

class SlideAnimation extends StatefulWidget {
  final Widget child;
  final SlideDirection direction;
  final Duration? duration;
  final Curve? curve;

  const SlideAnimation({
    super.key,
    required this.child,
    this.direction = SlideDirection.up,
    this.duration,
    this.curve,
  });

  @override
  State<SlideAnimation> createState() => _SlideAnimationState();
}

class _SlideAnimationState extends State<SlideAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    const config = AnimationConfig();

    _controller = AnimationController(
      vsync: this,
      duration: widget.duration ?? config.mediumDuration,
    );

    Offset beginOffset;
    switch (widget.direction) {
      case SlideDirection.up:
        beginOffset = const Offset(0, 0.2);
        break;
      case SlideDirection.down:
        beginOffset = const Offset(0, -0.2);
        break;
      case SlideDirection.left:
        beginOffset = const Offset(0.2, 0);
        break;
      case SlideDirection.right:
        beginOffset = const Offset(-0.2, 0);
        break;
    }

    _slideAnimation =
        Tween<Offset>(begin: beginOffset, end: Offset.zero).animate(
      CurvedAnimation(
        parent: _controller,
        curve: widget.curve ?? config.defaultCurve,
      ),
    );

    if (config.shouldAnimate) {
      _controller.forward();
    } else {
      _controller.value = 1.0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: widget.child,
    );
  }
}
