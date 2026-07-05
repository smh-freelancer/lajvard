// [OWNER] — Main weather data model.
// [OWNER] — Maps the complete Open-Meteo JSON response to WeatherEntity.
// [DEV] — Adapter pattern: converts complex API structure to clean domain objects.
// [DEV] — Fixed: Correctly maps all 4 required sub-models from the JSON.

import '../../../../core/error/app_exception.dart';
import '../../../../core/error/logger.dart';
import '../../domain/entities/weather_entity.dart';
import 'current_weather_model.dart';
import 'daily_forecast_model.dart';
import 'hourly_forecast_model.dart';
import 'weather_details_model.dart';

class WeatherModel {
  final CurrentWeatherModel current;
  final HourlyForecastModel hourly;
  final DailyForecastModel daily;
  final WeatherDetailsModel details;

  const WeatherModel({
    required this.current,
    required this.hourly,
    required this.daily,
    required this.details,
  });

  /// [DEV] — Maps Data Model -> Domain Entity
  WeatherEntity toEntity() {
    return WeatherEntity(
      current: current.toEntity(),
      hourly: hourly.toEntity(),
      daily: daily.toEntity(),
      details: details.toEntity(),
    );
  }

  /// [DEV] — Parses the full Open-Meteo response JSON.
  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    try {
      return WeatherModel(
        current: CurrentWeatherModel.fromJson(json),
        hourly: HourlyForecastModel.fromJson(json),
        daily: DailyForecastModel.fromJson(json),
        details: WeatherDetailsModel.fromJson(json),
      );
    } catch (e) {
      AppLogger.instance.error('WeatherModel parse error', error: e);
      throw ParseException(
          message: 'Failed to parse weather data', originalError: e);
    }
  }
}
