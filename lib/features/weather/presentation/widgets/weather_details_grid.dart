// [OWNER] — Weather details grid widget.
// [OWNER] — Displays extra details (wind, humidity, UV, etc.) in a responsive grid.
// [DEV] — Fixed: Removed broken safeNum helper and added proper spacing.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/responsive/breakpoint_strategy.dart';
import '../../../../core/localization/locale_service.dart';
import '../../../../core/localization/digit_converter.dart';
import '../../domain/entities/weather_details_entity.dart';
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

    final screenWidth = MediaQuery.of(context).size.width;
    final columns = BreakpointStrategy.gridColumns(screenWidth);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Text(
            localeService.convertDigits('📊 Details'),
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.9),
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: columns,
          childAspectRatio: 1.4,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          children: [
            WeatherDetailCard(
              icon: Icons.air,
              title: localeService.convertDigits('Wind'),
              value:
                  '${digitConverter.convertNumber(current.windSpeedKph.round())} ${localeService.convertDigits('km/h')}',
            ),
            WeatherDetailCard(
              icon: Icons.water_drop,
              title: localeService.convertDigits('Humidity'),
              value:
                  '${digitConverter.convertNumber(current.humidityPercent)}%',
            ),
            WeatherDetailCard(
              icon: Icons.sunny,
              title: localeService.convertDigits('UV Index'),
              value: digitConverter.convert(details.uvIndex.toStringAsFixed(1)),
            ),
            WeatherDetailCard(
              icon: Icons.speed,
              title: localeService.convertDigits('Pressure'),
              value:
                  '${digitConverter.convertNumber(current.pressureHpa.round())} hPa',
            ),
            WeatherDetailCard(
              icon: Icons.visibility,
              title: localeService.convertDigits('Visibility'),
              value:
                  '${digitConverter.convertNumber(details.visibilityKm.round())} km',
            ),
            WeatherDetailCard(
              icon: Icons.thermostat,
              title: localeService.convertDigits('Feels Like'),
              value:
                  '${digitConverter.convertNumber(current.feelsLikeCelsius.round())}°',
            ),
          ],
        ),
      ],
    );
  }
}
