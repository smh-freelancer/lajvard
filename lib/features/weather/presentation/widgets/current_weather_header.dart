// [OWNER] — Current weather header widget.
// [OWNER] — Shows city name, current temp, condition icon, high/low, and date.
// [DEV] — Updated to add a search icon button to change city manually.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/animation/fade_in_animation.dart';
import '../../../../core/localization/digit_converter.dart';
import '../../../../core/localization/locale_service.dart';
import '../../../location/domain/entities/location_entity.dart';
import '../providers/weather_provider.dart';
import '../providers/weather_providers.dart';
import 'weather_condition_icon.dart';

class CurrentWeatherHeader extends ConsumerWidget {
  const CurrentWeatherHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final current = ref.watch(currentWeatherProvider);
    final dailyItems = ref.watch(dailyForecastProvider)?.items;
    final location = ref.read(weatherLocationProvider);
    final localeService =
        LocaleService(locale: Localizations.localeOf(context));
    final digitConverter =
        DigitConverter(locale: Localizations.localeOf(context));

    if (current == null) return const SizedBox.shrink();
    debugPrint(
      'CurrentWeatherHeader location---> ${location.cityName}',
    );

    final todayHigh = dailyItems != null && dailyItems.isNotEmpty
        ? dailyItems.first.maxTemperatureCelsius
        : current.temperatureCelsius;
    final todayLow = dailyItems != null && dailyItems.isNotEmpty
        ? dailyItems.first.minTemperatureCelsius
        : current.temperatureCelsius;

    return FadeInAnimation(
      delayFactor: 0.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // [DEV] — City Name Row with Search Button
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                location.cityName,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(width: 12),
              InkWell(
                // onTap: () => context.push('/location-search'),
                onTap: () async {
                  final picked =
                      await context.push<LocationEntity>('/location-search');
                  if (picked != null && context.mounted) {
                    await ref.read(weatherProvider.notifier).updateLocation(
                          picked.latitude,
                          picked.longitude,
                          picked.name,
                        );
                    await ref.read(weatherProvider.notifier).refresh();
                  }
                },
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.search,
                    color: Colors.white70,
                    size: 22,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          WeatherConditionIcon(
            weatherCode: current.weatherCode,
            size: 80,
            isDaytime: _isDaytime(current.dateTime),
          ),
          const SizedBox(height: 8),
          Text(
            '${digitConverter.convertNumber(current.temperatureCelsius.round())}°',
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.w200,
                ),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'H:${digitConverter.convertNumber(todayHigh.round())}°',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withValues(alpha: 0.8),
                    ),
              ),
              const SizedBox(width: 16),
              Text(
                'L:${digitConverter.convertNumber(todayLow.round())}°',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withValues(alpha: 0.6),
                    ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            localeService.formatDate(current.dateTime),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withValues(alpha: 0.7),
                ),
          ),
        ],
      ),
    );
  }

  bool _isDaytime(DateTime time) {
    final hour = time.hour;
    return hour >= 6 && hour < 18;
  }
}
