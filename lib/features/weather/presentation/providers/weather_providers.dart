// [OWNER] — Granular weather providers.
// [OWNER] — Allows individual widgets to watch only the data they need.
// [DEV] — One concern per provider (Rule 19). Uses modern Riverpod 3.x APIs.

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/current_weather_entity.dart';
import '../../domain/entities/daily_forecast_entity.dart';
import '../../domain/entities/hourly_forecast_entity.dart';
import '../../domain/entities/weather_details_entity.dart';
import '../../domain/entities/weather_entity.dart';
import 'weather_provider.dart';

/// [DEV] — Provides only the current weather header data.
final currentWeatherProvider = Provider<CurrentWeatherEntity?>((ref) {
  final weatherAsync = ref.watch(weatherProvider);
  // [DEV] — Riverpod 3.x pattern matching on AsyncValue
  if (weatherAsync.value case final WeatherEntity weather?) {
    return weather.current;
  }
  return null;
});

/// [DEV] — Provides only the hourly forecast list.
final hourlyForecastProvider = Provider<HourlyForecastEntity?>((ref) {
  final weatherAsync = ref.watch(weatherProvider);
  if (weatherAsync.value case final WeatherEntity weather?) {
    return weather.hourly;
  }
  return null;
});

/// [DEV] — Provides only the daily forecast list.
final dailyForecastProvider = Provider<DailyForecastEntity?>((ref) {
  final weatherAsync = ref.watch(weatherProvider);
  if (weatherAsync.value case final WeatherEntity weather?) {
    return weather.daily;
  }
  return null;
});

/// [DEV] — Provides only the extra weather details.
final weatherDetailsProvider = Provider<WeatherDetailsEntity?>((ref) {
  final weatherAsync = ref.watch(weatherProvider);
  if (weatherAsync.value case final WeatherEntity weather?) {
    return weather.details;
  }
  return null;
});
