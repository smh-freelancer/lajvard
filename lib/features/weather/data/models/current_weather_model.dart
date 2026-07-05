// [OWNER] — Current weather data model.
// [OWNER] — Parses the "current" section of the Open-Meteo API response.
// [DEV] — All fields nullable with sensible defaults per Rule 24.

import '../../../../core/error/app_exception.dart';
import '../../../../core/error/json_parser.dart';
import '../../../../core/error/logger.dart';
import '../../domain/entities/current_weather_entity.dart';

class CurrentWeatherModel {
  final double temperatureCelsius;
  final int weatherCode;
  final double feelsLikeCelsius;
  final double windSpeedKph;
  final int windDirectionDegrees;
  final int humidityPercent;
  final double pressureHpa;
  final DateTime dateTime;

  const CurrentWeatherModel({
    required this.temperatureCelsius,
    required this.weatherCode,
    required this.feelsLikeCelsius,
    required this.windSpeedKph,
    required this.windDirectionDegrees,
    required this.humidityPercent,
    required this.pressureHpa,
    required this.dateTime,
  });

  CurrentWeatherEntity toEntity() {
    return CurrentWeatherEntity(
      temperatureCelsius: temperatureCelsius,
      weatherCode: weatherCode,
      feelsLikeCelsius: feelsLikeCelsius,
      windSpeedKph: windSpeedKph,
      windDirectionDegrees: windDirectionDegrees,
      humidityPercent: humidityPercent,
      pressureHpa: pressureHpa,
      dateTime: dateTime,
    );
  }

  /// [DEV] — Extracts current weather from the flat Open-Meteo JSON structure.
  factory CurrentWeatherModel.fromJson(Map<String, dynamic> json) {
    try {
      final currentJson = json['current'] as Map<String, dynamic>? ?? {};
      final timeStr = currentJson['time'] as String? ?? '';

      final parsedDate = DateTime.tryParse(timeStr);

      // [DEV] — Use parsed date if it's valid and reasonably recent (after year 2000).
      // [DEV] — If it fails, fall back to right now. The Jalali converter
      // [DEV] — handles modern dates perfectly.
      DateTime safeDate;
      if (parsedDate != null && parsedDate.year >= 2000) {
        safeDate = parsedDate;
      } else {
        safeDate = DateTime.now();
      }

      return CurrentWeatherModel(
        temperatureCelsius: parseDouble(currentJson['temperature_2m']),
        weatherCode: parseInt(currentJson['weather_code']),
        feelsLikeCelsius: parseDouble(currentJson['apparent_temperature']),
        windSpeedKph: parseDouble(currentJson['wind_speed_10m']),
        windDirectionDegrees: parseInt(currentJson['wind_direction_10m']),
        humidityPercent: parseInt(currentJson['relative_humidity_2m']),
        pressureHpa: parseDouble(currentJson['surface_pressure']),
        dateTime: safeDate,
      );
    } catch (e) {
      AppLogger.instance.error('CurrentWeatherModel parse error', error: e);
      throw const ParseException(message: 'Failed to parse current weather');
    }
  }
}
