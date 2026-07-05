// [OWNER] — Single daily forecast row widget.
// [OWNER] — Shows day name, date, icon, condition, and high/low temperature bar.
// [DEV] — Includes the TemperatureBar widget.

import 'package:flutter/material.dart';
import '../../../../core/localization/locale_service.dart';
import '../../../../core/localization/digit_converter.dart';
import '../../domain/entities/daily_item_entity.dart';
import 'temperature_bar.dart';
import 'weather_condition_icon.dart';

class DailyItemRow extends StatelessWidget {
  final DailyItemEntity item;
  final double overallMin;
  final double overallMax;

  const DailyItemRow({
    super.key,
    required this.item,
    required this.overallMin,
    required this.overallMax,
  });

  @override
  Widget build(BuildContext context) {
    final localeService =
        LocaleService(locale: Localizations.localeOf(context));
    final digitConverter =
        DigitConverter(locale: Localizations.localeOf(context));

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          // [DEV] — Day Name & Date
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  localeService.getDayName(item.date),
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                Text(
                  localeService.formatDate(item.date, includeDayName: false),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withValues(alpha: 0.6),
                      ),
                ),
              ],
            ),
          ),

          // [DEV] — Weather Icon
          SizedBox(
            width: 30,
            child: WeatherConditionIcon(
              weatherCode: item.weatherCode,
              size: 24,
            ),
          ),
          const SizedBox(width: 8),

          // [DEV] — Temperature Bar
          Expanded(
            flex: 3,
            child: TemperatureBar(
              min: overallMin,
              max: overallMax,
              currentMin: item.minTemperatureCelsius,
              currentMax: item.maxTemperatureCelsius,
            ),
          ),

          // [DEV] — High / Low Text
          SizedBox(
            width: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  '${digitConverter.convertNumber(item.maxTemperatureCelsius.round())}°',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                ),
                const SizedBox(width: 8),
                Text(
                  '${digitConverter.convertNumber(item.minTemperatureCelsius.round())}°',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withValues(alpha: 0.5),
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
