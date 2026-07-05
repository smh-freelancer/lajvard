// [OWNER] — Temperature range bar widget.
// [OWNER] — Visually shows the min-to-max range of a day within the week's range.
// [DEV] — Uses a gradient to represent the temperature spectrum.

import 'package:flutter/material.dart';

class TemperatureBar extends StatelessWidget {
  final double min; // [DEV] — Week's overall minimum
  final double max; // [DEV] — Week's overall maximum
  final double currentMin; // [DEV] — This day's minimum
  final double currentMax; // [DEV] — This day's maximum

  const TemperatureBar({
    super.key,
    required this.min,
    required this.max,
    required this.currentMin,
    required this.currentMax,
  });

  @override
  Widget build(BuildContext context) {
    // [DEV] — Prevent division by zero if all temps are the same
    if (max - min == 0) {
      return Container(
        height: 4,
        decoration: BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.circular(2),
        ),
      );
    }

    // [DEV] — Calculate start and end percentages for this day's range
    final startPercent = ((currentMin - min) / (max - min)).clamp(0.0, 1.0);
    final endPercent = ((currentMax - min) / (max - min)).clamp(0.0, 1.0);

    return LayoutBuilder(
      builder: (context, constraints) {
        final totalWidth = constraints.maxWidth;

        return SizedBox(
          height: 4,
          width: totalWidth,
          child: Stack(
            children: [
              // [DEV] — Background track
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              // [DEV] — Active range
              Positioned(
                left: totalWidth * startPercent,
                width: totalWidth * (endPercent - startPercent),
                top: 0,
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).colorScheme.primary,
                        Colors.orange,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
