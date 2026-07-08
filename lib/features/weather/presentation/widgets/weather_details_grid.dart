// [OWNER] — Weather details grid widget.
// [OWNER] — Displays extra details (wind, humidity, UV, etc.) in a responsive grid.
// [DEV] — Fixed: Removed broken safeNum helper and added proper spacing.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/localization/digit_converter.dart';
import '../../../../core/localization/generated/app_localizations.dart';
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

    final screenWidth = MediaQuery.of(context).size.width;
    // final columns = BreakpointStrategy.gridColumns(screenWidth);
    final columns =
        BreakpointStrategy.fromWidth(screenWidth) == ScreenCategory.phone
            ? 2
            : BreakpointStrategy.gridColumns(screenWidth);

    final l10n = AppLocalizations.of(context);
    String windDirectionLabel(AppLocalizations l10n, int degrees) {
      final index = ((degrees + 22.5) % 360 / 45).floor();
      final labels = [
        l10n.north,
        l10n.northEast,
        l10n.east,
        l10n.southEast,
        l10n.south,
        l10n.southWest,
        l10n.west,
        l10n.northWest,
      ];
      return labels[index];
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
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
          // crossAxisCount: columns,
          // childAspectRatio: 1.4,
          // padding: const EdgeInsets.symmetric(horizontal: 16.0),
          // mainAxisSpacing: 12,
          // crossAxisSpacing: 12,
          crossAxisCount: columns, // 1 on phone
          childAspectRatio: 1.6, // wider than tall — compact tiles
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          children: [
            WeatherDetailCard(
              icon: Icons.air,
              title: l10n.wind,
              value:
                  '${digitConverter.convertNumber(current.windSpeedKph.round())} ${l10n.windSpeedUnit}',
              // subtitle: windDirectionLabel(l10n, current.windDirectionDegrees),
            ),

            WeatherDetailCard(
              icon: Icons.water_drop,
              title: l10n.humidity,
              value:
                  '${digitConverter.convertNumber(current.humidityPercent.round())} ${l10n.humidityUnit}',
              // subtitle: windDirectionLabel(l10n, current.humidityPercent),
            ),
            WeatherDetailCard(
              icon: Icons.sunny,
              title: l10n.uvIndex,
              value:
                  '${digitConverter.convertNumber(details.uvIndex.round())} ${l10n.uvIndex}',
              // subtitle:
              // digitConverter.convert(details.uvIndex.toStringAsFixed(1)),
            ),
            WeatherDetailCard(
              icon: Icons.speed,
              title: l10n.pressure,
              value:
                  '${digitConverter.convertNumber(current.pressureHpa.round())} ${l10n.pressureUnit}',
              // subtitle:
              //     '${digitConverter.convertNumber(current.pressureHpa.round())} ${l10n.pressureUnit}',
            ),
            WeatherDetailCard(
              icon: Icons.visibility,
              title: l10n.visibility,
              value:
                  '${digitConverter.convertNumber(details.visibilityKm.round())} ${l10n.visibilityUnit}',
              // subtitle:
              //     '${digitConverter.convertNumber(details.visibilityKm.round())} ${l10n.visibilityUnit}',
            ),
            WeatherDetailCard(
              icon: Icons.thermostat,
              title: l10n.feelsLike,
              value:
                  '${digitConverter.convertNumber(current.feelsLikeCelsius.round())} ${l10n.temperatureUnit}',
              // subtitle: digitConverter
              //     .convertNumber(current.feelsLikeCelsius.round()),
            ),
            // WeatherDetailCard(
            //   icon: Icons.air,
            //   title: localeService.convertDigits('Wind'),
            //   value:
            //       '${digitConverter.convertNumber(current.windSpeedKph.round())} ${localeService.convertDigits('km/h')}',
            // ),
            // WeatherDetailCard(
            //   icon: Icons.water_drop,
            //   title: localeService.convertDigits('Humidity'),
            //   value:
            //       '${digitConverter.convertNumber(current.humidityPercent)}%',
            // ),
            // WeatherDetailCard(
            //   icon: Icons.sunny,
            //   title: localeService.convertDigits('UV Index'),
            //   value: digitConverter.convert(details.uvIndex.toStringAsFixed(1)),
            // ),
            // WeatherDetailCard(
            //   icon: Icons.speed,
            //   title: localeService.convertDigits('Pressure'),
            //   value:
            //       '${digitConverter.convertNumber(current.pressureHpa.round())} hPa',
            // ),
            // WeatherDetailCard(
            //   icon: Icons.visibility,
            //   title: localeService.convertDigits('Visibility'),
            //   value:
            //       '${digitConverter.convertNumber(details.visibilityKm.round())} km',
            // ),
            // WeatherDetailCard(
            //   icon: Icons.thermostat,
            //   title: localeService.convertDigits('Feels Like'),
            //   value:
            //       '${digitConverter.convertNumber(current.feelsLikeCelsius.round())}°',
            // ),
          ],
        ),
      ],
    );
  }
}
