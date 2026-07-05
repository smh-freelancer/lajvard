// [OWNER] — Use case: Get 7-day daily forecast starting from tomorrow.
// [DEV] — Single responsibility.

import '../../../../core/error/failure.dart';
import '../entities/daily_forecast_entity.dart';
import '../repositories/weather_repository.dart';

class GetDailyForecastUseCase {
  final WeatherRepository repository;

  GetDailyForecastUseCase(this.repository);

  Future<Result<DailyForecastEntity>> call({
    required double latitude,
    required double longitude,
  }) {
    return repository.getDailyForecast(
      latitude: latitude,
      longitude: longitude,
    );
  }
}
