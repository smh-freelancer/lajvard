// [OWNER] — Weather condition icon widget.
// [OWNER] — Maps Open-Meteo WMO codes to appropriate icons.
// [DEV] — Uses built-in Material icons to avoid external dependencies (Rule 14).

import 'package:flutter/material.dart';

class WeatherConditionIcon extends StatelessWidget {
  final int weatherCode;
  final double size;
  final bool isDaytime;

  const WeatherConditionIcon({
    super.key,
    required this.weatherCode,
    this.size = 48,
    this.isDaytime = true,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      _getIconData(),
      size: size,
      color: _getColor(context),
    );
  }

  IconData _getIconData() {
    // [DEV] — WMO Weather interpretation codes (WW)
    // [DEV] — https://open-meteo.com/en/docs#weathervariables
    switch (weatherCode) {
      case 0:
        return isDaytime ? Icons.wb_sunny : Icons.nightlight;
      case 1:
        return isDaytime ? Icons.wb_sunny_outlined : Icons.nightlight_outlined;
      case 2:
        return isDaytime ? Icons.cloud_outlined : Icons.cloud_outlined;
      case 3:
        return Icons.cloud;
      case 45:
      case 48:
        return Icons.cloud_queue;
      case 51:
      case 53:
      case 55:
        return Icons.grain;
      case 56:
      case 57:
        return Icons.ac_unit;
      case 61:
      case 63:
      case 65:
      case 66:
      case 67:
        return Icons.water_drop;
      case 71:
      case 73:
      case 75:
      case 77:
        return Icons.severe_cold;
      case 80:
      case 81:
      case 82:
        return Icons.shower;
      case 85:
      case 86:
        return Icons.snowing;
      case 95:
      case 96:
      case 99:
        return Icons.thunderstorm;
      default:
        return Icons.help_outline;
    }
  }

  Color _getColor(BuildContext context) {
    // [DEV] — Use golden accent for sun, white for others
    if (weatherCode == 0 && isDaytime) {
      return const Color(0xFFD4A843); // [DEV] — Lajvard golden accent
    }
    return Colors.white.withValues(alpha: 0.9);
  }
}
