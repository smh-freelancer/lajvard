// [OWNER] — Main weather entity. Contains all weather data for the UI.
// [OWNER] — This is what the presentation layer receives from the Facade use case.
// [DEV] — Pure domain object. No dependencies on any framework or external package.

import 'package:flutter/material.dart';

import 'current_weather_entity.dart';
import 'daily_forecast_entity.dart';
import 'hourly_forecast_entity.dart';
import 'weather_details_entity.dart';

@immutable
class WeatherEntity {
  final CurrentWeatherEntity current;
  final HourlyForecastEntity hourly;
  final DailyForecastEntity daily;
  final WeatherDetailsEntity details;

  const WeatherEntity({
    required this.current,
    required this.hourly,
    required this.daily,
    required this.details,
  });

  WeatherEntity copyWith({
    CurrentWeatherEntity? current,
    HourlyForecastEntity? hourly,
    DailyForecastEntity? daily,
    WeatherDetailsEntity? details,
  }) {
    return WeatherEntity(
      current: current ?? this.current,
      hourly: hourly ?? this.hourly,
      daily: daily ?? this.daily,
      details: details ?? this.details,
    );
  }
}
