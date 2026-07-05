// [OWNER] — Weather details grid widget.
// [OWNER] — Displays extra details (wind, humidity, UV, etc.) in a responsive grid.
// [DEV] — Uses the responsive module to switch between 1, 2, or 3 columns.
// [DEV] — Fixed: Changed convertNumber to convert for decimal string formatting.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/error/json_parser.dart';
import '../../../../core/localization/digit_converter.dart';
import '../../../../core/localization/locale_service.dart';
import '../../../../core/responsive/breakpoint_strategy.dart';
import '../providers/weather_providers.dart';
import 'weather_detail_card.dart';

class WeatherDetailsGrid extends ConsumerWidget {
  const WeatherDetailsGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final details = ref.watch(weatherDetailsProvider);
    final current = ref.watch(currentWeatherProvider);
    final localeService =
        LocaleService(locale: Localizations.localeOf(context));
    final digitConverter =
        DigitConverter(locale: Localizations.localeOf(context));

    if (details == null || current == null) {
      return const SizedBox.shrink();
    }

    // [DEV] — Safely format numbers to prevent any lingering String cast errors
    String safeNum(dynamic value, {int decimals = 0}) {
      final safeDouble = (value is num) ? value.toDouble() : parseDouble(value);
      if (decimals == 0) {
        return digitConverter.convertNumber(safeDouble.round());
      }
      // [DEV] — Use convert() instead of convertNumber() because toStringAsFixed returns a String
      return digitConverter.convert(safeDouble.toStringAsFixed(decimals));
    }

    // [DEV] — Determine column count based on screen width
    final screenWidth = MediaQuery.of(context).size.width;
    final columns = BreakpointStrategy.gridColumns(screenWidth);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            localeService.convertDigits('📊 Details'),
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withValues(alpha: 0.9),
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: columns,
          childAspectRatio: 1.5,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          children: [
            WeatherDetailCard(
              icon: Icons.air,
              title: localeService.convertDigits('Wind'),
              value:
                  '${safeNum(current.windSpeedKph)} ${localeService.convertDigits('km/h')}',
            ),
            WeatherDetailCard(
              icon: Icons.water_drop,
              title: localeService.convertDigits('Humidity'),
              value: '${safeNum(current.humidityPercent)}%',
            ),
            WeatherDetailCard(
              icon: Icons.sunny,
              title: localeService.convertDigits('UV Index'),
              value: safeNum(details.uvIndex, decimals: 1),
            ),
            WeatherDetailCard(
              icon: Icons.speed,
              title: localeService.convertDigits('Pressure'),
              value: '${safeNum(current.pressureHpa)} hPa',
            ),
            WeatherDetailCard(
              icon: Icons.visibility,
              title: localeService.convertDigits('Visibility'),
              value: '${safeNum(details.visibilityKm)} km',
            ),
            WeatherDetailCard(
              icon: Icons.thermostat,
              title: localeService.convertDigits('Feels Like'),
              value: '${safeNum(current.feelsLikeCelsius)}°',
            ),
          ],
        ),
      ],
    );
  }
}
