// [OWNER] — Use case: Get current weather for a location.
// [DEV] — Single responsibility. Returns Result to keep domain clean.

import '../../../../core/error/failure.dart';
import '../entities/current_weather_entity.dart';
import '../repositories/weather_repository.dart';

class GetCurrentWeatherUseCase {
  final WeatherRepository repository;

  GetCurrentWeatherUseCase(this.repository);

  Future<Result<CurrentWeatherEntity>> call({
    required double latitude,
    required double longitude,
  }) {
    return repository.getCurrentWeather(
      latitude: latitude,
      longitude: longitude,
    );
  }
}
