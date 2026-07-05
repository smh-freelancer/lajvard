// [OWNER] — Single hourly forecast item widget.
// [OWNER] — Displays hour, icon, and temperature in a small glass card.
// [DEV] — Updated to use the modular GlassCard.

import 'package:flutter/material.dart';

import '../../../../core/glassmorphism/glass_card.dart';
import '../../../../core/glassmorphism/glass_config.dart';
import '../../../../core/localization/digit_converter.dart';
import '../../../../core/localization/locale_service.dart';
import '../../domain/entities/hourly_item_entity.dart';
import 'weather_condition_icon.dart';

class HourlyItemCard extends StatelessWidget {
  final HourlyItemEntity item;

  const HourlyItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final localeService =
        LocaleService(locale: Localizations.localeOf(context));
    final digitConverter =
        DigitConverter(locale: Localizations.localeOf(context));
    final isNow = _isCurrentHour(item.time);

    return GlassCard(
      config: GlassConfig.dark().copyWith(
        opacity: isNow ? 0.25 : 0.10,
        borderRadius: 20.0,
      ),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      margin: const EdgeInsets.only(right: 12),
      child: SizedBox(
        width: 64,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              isNow ? 'Now' : localeService.formatTime(item.time),
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontWeight: isNow ? FontWeight.bold : FontWeight.normal,
                  ),
            ),
            WeatherConditionIcon(
              weatherCode: item.weatherCode,
              size: 28,
              isDaytime: _isDaytime(item.time),
            ),
            Text(
              '${digitConverter.convertNumber(item.temperatureCelsius.round())}°',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  bool _isCurrentHour(DateTime time) {
    final now = DateTime.now();
    return time.hour == now.hour &&
        time.day == now.day &&
        time.month == now.month;
  }

  bool _isDaytime(DateTime time) {
    final hour = time.hour;
    return hour >= 6 && hour < 18;
  }
}
