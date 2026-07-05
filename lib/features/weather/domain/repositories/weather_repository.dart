// [OWNER] — Weather repository interface.
// [OWNER] — Defines what data operations the domain layer needs.
// [DEV] — The data layer implements this. Domain layer never knows about APIs.
// [DEV] — Uses the custom Result type from core/error to avoid leaking exceptions.

import '../../../../core/error/failure.dart';
import '../entities/current_weather_entity.dart';
import '../entities/daily_forecast_entity.dart';
import '../entities/hourly_forecast_entity.dart';
import '../entities/weather_details_entity.dart';
import '../entities/weather_entity.dart';

abstract class WeatherRepository {
  Future<Result<CurrentWeatherEntity>> getCurrentWeather({
    required double latitude,
    required double longitude,
  });

  Future<Result<HourlyForecastEntity>> getHourlyForecast({
    required double latitude,
    required double longitude,
  });

  Future<Result<DailyForecastEntity>> getDailyForecast({
    required double latitude,
    required double longitude,
  });

  Future<Result<WeatherDetailsEntity>> getWeatherDetails({
    required double latitude,
    required double longitude,
  });

  /// [DEV] — Convenience method for the Facade use case.
  Future<Result<WeatherEntity>> getFullWeather({
    required double latitude,
    required double longitude,
  });
}
