// [OWNER] — Hourly forecast data model.
// [OWNER] — Parses the "hourly" section and filters out past hours.
// [DEV] — Implements Rule 13: only remaining hours of TODAY are included.

import '../../../../core/error/app_exception.dart';
import '../../../../core/error/json_parser.dart';
import '../../../../core/error/logger.dart';
import '../../domain/entities/hourly_forecast_entity.dart';
import 'hourly_item_model.dart';

class HourlyForecastModel {
  final List<HourlyItemModel> items;

  const HourlyForecastModel({required this.items});

  HourlyForecastEntity toEntity() {
    return HourlyForecastEntity(
      items: items.map((e) => e.toEntity()).toList(),
    );
  }

  factory HourlyForecastModel.fromJson(Map<String, dynamic> json) {
    try {
      final hourlyJson = json['hourly'] as Map<String, dynamic>? ?? {};
      final times =
          (hourlyJson['time'] as List<dynamic>?)?.cast<String>() ?? [];
      final temps = (hourlyJson['temperature_2m'] as List<dynamic>?) ?? [];
      final codes = (hourlyJson['weather_code'] as List<dynamic>?) ?? [];
      final precip =
          (hourlyJson['precipitation_probability'] as List<dynamic>?) ?? [];

      final now = DateTime.now();
      final startOfToday = DateTime(now.year, now.month, now.day);
      final endOfToday = startOfToday.add(const Duration(days: 1));

      final List<HourlyItemModel> filteredItems = [];

      for (int i = 0; i < times.length; i++) {
        final time = DateTime.tryParse(times[i]);
        if (time == null) continue;

        if (time.isAfter(now.subtract(const Duration(minutes: 1))) &&
            time.isBefore(endOfToday)) {
          filteredItems.add(
            HourlyItemModel(
              time: time,
              temperatureCelsius: parseDouble(temps[i]),
              weatherCode: parseInt(codes[i]),
              precipitationProbability: parseDouble(precip[i]),
            ),
          );
        }
      }

      return HourlyForecastModel(items: filteredItems);
    } catch (e) {
      AppLogger.instance.error('HourlyForecastModel parse error', error: e);
      throw const ParseException(message: 'Failed to parse hourly forecast');
    }
  }
}
