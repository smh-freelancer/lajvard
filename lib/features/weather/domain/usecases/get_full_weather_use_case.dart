// [OWNER] — Facade use case: Gets all weather data at once.
// [OWNER] — Calls current, hourly, daily, and details use cases.
// [DEV] — Facade pattern. Simplifies the interface for the presentation layer.

import '../../../../core/error/failure.dart';
import '../entities/weather_entity.dart';
import '../repositories/weather_repository.dart';

class GetFullWeatherUseCase {
  final WeatherRepository repository;

  GetFullWeatherUseCase(this.repository);

  Future<Result<WeatherEntity>> call({
    required double latitude,
    required double longitude,
  }) {
    return repository.getFullWeather(
      latitude: latitude,
      longitude: longitude,
    );
  }
}
