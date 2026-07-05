// [OWNER] — Use case: Get extra weather details.
// [DEV] — Can be lazy-loaded after current/hourly/daily (Rule 25).

import '../../../../core/error/failure.dart';
import '../entities/weather_details_entity.dart';
import '../repositories/weather_repository.dart';

class GetWeatherDetailsUseCase {
  final WeatherRepository repository;

  GetWeatherDetailsUseCase(this.repository);

  Future<Result<WeatherDetailsEntity>> call({
    required double latitude,
    required double longitude,
  }) {
    return repository.getWeatherDetails(
      latitude: latitude,
      longitude: longitude,
    );
  }
}
