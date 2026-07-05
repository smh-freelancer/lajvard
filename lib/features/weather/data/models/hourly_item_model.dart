// [OWNER] — Single hourly forecast item model.
// [DEV] — Lightweight, maps directly to HourlyItemEntity.

import '../../domain/entities/hourly_item_entity.dart';

class HourlyItemModel {
  final DateTime time;
  final double temperatureCelsius;
  final int weatherCode;
  final double precipitationProbability;

  const HourlyItemModel({
    required this.time,
    required this.temperatureCelsius,
    required this.weatherCode,
    required this.precipitationProbability,
  });

  HourlyItemEntity toEntity() {
    return HourlyItemEntity(
      time: time,
      temperatureCelsius: temperatureCelsius,
      weatherCode: weatherCode,
      precipitationProbability: precipitationProbability,
    );
  }
}
