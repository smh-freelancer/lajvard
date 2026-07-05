// [OWNER] — Single weather detail card widget.
// [OWNER] — Displays a title, icon, and value in a glassmorphism card.
// [DEV] — Uses the modular GlassCard.

import 'package:flutter/material.dart';
import '../../../../core/glassmorphism/glass_card.dart';
import '../../../../core/glassmorphism/glass_config.dart';

class WeatherDetailCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const WeatherDetailCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      config: GlassConfig.dark(accent: Colors.white).copyWith(
        borderRadius: 20.0,
        opacity: 0.15,
      ),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.white.withValues(alpha: 0.8), size: 18),
              const SizedBox(width: 6),
              Text(
                title,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.8),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
