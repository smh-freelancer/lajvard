// [OWNER] — Single hourly forecast item.
// [OWNER] — Represents the weather at a specific hour.
// [DEV] — Lightweight entity for ListView.builder items.

import 'package:flutter/material.dart';

@immutable
class HourlyItemEntity {
  final DateTime time;
  final double temperatureCelsius;
  final int weatherCode;
  final double precipitationProbability;

  const HourlyItemEntity({
    required this.time,
    required this.temperatureCelsius,
    required this.weatherCode,
    this.precipitationProbability = 0.0,
  });
}
