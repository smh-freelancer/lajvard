// [OWNER] — Use case: Get hourly forecast for today.
// [OWNER] — The repository filters out past hours (Rule 13).
// [DEV] — Single responsibility.

import '../../../../core/error/failure.dart';
import '../entities/hourly_forecast_entity.dart';
import '../repositories/weather_repository.dart';

class GetHourlyForecastUseCase {
  final WeatherRepository repository;

  GetHourlyForecastUseCase(this.repository);

  Future<Result<HourlyForecastEntity>> call({
    required double latitude,
    required double longitude,
  }) {
    return repository.getHourlyForecast(
      latitude: latitude,
      longitude: longitude,
    );
  }
}
