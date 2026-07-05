// [OWNER] — Current weather entity.
// [OWNER] — Represents the weather right now at the user's location.
// [DEV] — Immutable. Used by presentation layer to render the header section.

import 'package:flutter/material.dart';

@immutable
class CurrentWeatherEntity {
  final double temperatureCelsius;
  final int weatherCode;
  final double feelsLikeCelsius;
  final double windSpeedKph;
  final int windDirectionDegrees;
  final int humidityPercent;
  final double pressureHpa;
  final DateTime dateTime;

  const CurrentWeatherEntity({
    required this.temperatureCelsius,
    required this.weatherCode,
    required this.feelsLikeCelsius,
    required this.windSpeedKph,
    required this.windDirectionDegrees,
    required this.humidityPercent,
    required this.pressureHpa,
    required this.dateTime,
  });
}
