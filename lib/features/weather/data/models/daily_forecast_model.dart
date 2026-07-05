// [OWNER] — Daily forecast data model.
// [OWNER] — Parses the "daily" section. Excludes today, starts from tomorrow.
// [DEV] — Implements Rule 13: 7 days starting from TOMORROW.

import '../../../../core/error/app_exception.dart';
import '../../../../core/error/json_parser.dart';
import '../../../../core/error/logger.dart';
import '../../domain/entities/daily_forecast_entity.dart';
import 'daily_item_model.dart';

class DailyForecastModel {
  final List<DailyItemModel> items;

  const DailyForecastModel({required this.items});

  DailyForecastEntity toEntity() {
    return DailyForecastEntity(
      items: items.map((e) => e.toEntity()).toList(),
    );
  }

  factory DailyForecastModel.fromJson(Map<String, dynamic> json) {
    try {
      final dailyJson = json['daily'] as Map<String, dynamic>? ?? {};
      final times = (dailyJson['time'] as List<dynamic>?)?.cast<String>() ?? [];
      final maxTemps =
          (dailyJson['temperature_2m_max'] as List<dynamic>?) ?? [];
      final minTemps =
          (dailyJson['temperature_2m_min'] as List<dynamic>?) ?? [];
      final codes = (dailyJson['weather_code'] as List<dynamic>?) ?? [];
      final precip =
          (dailyJson['precipitation_probability_max'] as List<dynamic>?) ?? [];

      final now = DateTime.now();
      final startOfToday = DateTime(now.year, now.month, now.day);
      final startOfTomorrow = startOfToday.add(const Duration(days: 1));

      final List<DailyItemModel> filteredItems = [];

      for (int i = 0; i < times.length; i++) {
        final date = DateTime.tryParse(times[i]);
        if (date == null) continue;

        if (date.isAtSameMomentAs(startOfTomorrow) ||
            date.isAfter(startOfTomorrow)) {
          if (filteredItems.length >= 7) break;

          filteredItems.add(
            DailyItemModel(
              date: date,
              maxTemperatureCelsius: parseDouble(maxTemps[i]),
              minTemperatureCelsius: parseDouble(minTemps[i]),
              weatherCode: parseInt(codes[i]),
              precipitationProbability: parseDouble(precip[i]),
            ),
          );
        }
      }

      return DailyForecastModel(items: filteredItems);
    } catch (e) {
      AppLogger.instance.error('DailyForecastModel parse error', error: e);
      throw const ParseException(message: 'Failed to parse daily forecast');
    }
  }
}
