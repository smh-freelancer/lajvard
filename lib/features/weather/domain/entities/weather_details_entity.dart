// [OWNER] — Extra weather details entity.
// [OWNER] — Contains additional metrics shown in the detail grid cards.
// [DEV] — Lazy-loaded after main weather data (Rule 25).

import 'package:flutter/material.dart';

@immutable
class WeatherDetailsEntity {
  final double uvIndex;
  final double visibilityKm;
  final double dewPointCelsius;
  final int cloudCoverPercent;

  const WeatherDetailsEntity({
    required this.uvIndex,
    required this.visibilityKm,
    required this.dewPointCelsius,
    required this.cloudCoverPercent,
  });
}
