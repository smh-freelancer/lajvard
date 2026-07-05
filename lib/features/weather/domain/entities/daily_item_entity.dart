// [OWNER] — Single daily forecast item.
// [OWNER] — Represents the weather for a full day.
// [DEV] — Contains high/low temps for the temperature range bar.

import 'package:flutter/material.dart';

@immutable
class DailyItemEntity {
  final DateTime date;
  final double maxTemperatureCelsius;
  final double minTemperatureCelsius;
  final int weatherCode;
  final double precipitationProbability;

  const DailyItemEntity({
    required this.date,
    required this.maxTemperatureCelsius,
    required this.minTemperatureCelsius,
    required this.weatherCode,
    this.precipitationProbability = 0.0,
  });
}
