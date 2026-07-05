// [OWNER] — Single daily forecast item model.
// [DEV] — Lightweight, maps directly to DailyItemEntity.

import '../../domain/entities/daily_item_entity.dart';

class DailyItemModel {
  final DateTime date;
  final double maxTemperatureCelsius;
  final double minTemperatureCelsius;
  final int weatherCode;
  final double precipitationProbability;

  const DailyItemModel({
    required this.date,
    required this.maxTemperatureCelsius,
    required this.minTemperatureCelsius,
    required this.weatherCode,
    required this.precipitationProbability,
  });

  DailyItemEntity toEntity() {
    return DailyItemEntity(
      date: date,
      maxTemperatureCelsius: maxTemperatureCelsius,
      minTemperatureCelsius: minTemperatureCelsius,
      weatherCode: weatherCode,
      precipitationProbability: precipitationProbability,
    );
  }
}
