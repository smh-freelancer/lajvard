// [OWNER] — Unit test for GetHourlyForecastUseCase.
// [DEV] — Tests success and failure paths.

import 'package:flutter_test/flutter_test.dart';
import 'package:lajvard/core/error/failure.dart';
import 'package:lajvard/features/weather/domain/entities/current_weather_entity.dart';
import 'package:lajvard/features/weather/domain/entities/hourly_forecast_entity.dart';
import 'package:lajvard/features/weather/domain/entities/daily_forecast_entity.dart';
import 'package:lajvard/features/weather/domain/entities/weather_details_entity.dart';
import 'package:lajvard/features/weather/domain/entities/weather_entity.dart';
import 'package:lajvard/features/weather/domain/repositories/weather_repository.dart';
import 'package:lajvard/features/weather/domain/usecases/get_hourly_forecast_use_case.dart';

// [DEV] — Manual mock for WeatherRepository with strict typing
class MockWeatherRepository implements WeatherRepository {
  double? capturedLat;
  double? capturedLon;
  bool shouldSucceed = true;

  @override
  Future<Result<HourlyForecastEntity>> getHourlyForecast({
    required double latitude,
    required double longitude,
  }) async {
    capturedLat = latitude;
    capturedLon = longitude;

    if (shouldSucceed) {
      return Result.success(const HourlyForecastEntity(items: []));
    } else {
      return Result.failure(const ServerFailure());
    }
  }

  // [DEV] — Stubs with EXACT type parameters to satisfy @override rules
  @override
  Future<Result<WeatherEntity>> getFullWeather({
    required double latitude,
    required double longitude,
  }) {
    return Future.value(Result.failure(const UnknownFailure()));
  }

  @override
  Future<Result<CurrentWeatherEntity>> getCurrentWeather({
    required double latitude,
    required double longitude,
  }) {
    return Future.value(Result.failure(const UnknownFailure()));
  }

  @override
  Future<Result<DailyForecastEntity>> getDailyForecast({
    required double latitude,
    required double longitude,
  }) {
    return Future.value(Result.failure(const UnknownFailure()));
  }

  @override
  Future<Result<WeatherDetailsEntity>> getWeatherDetails({
    required double latitude,
    required double longitude,
  }) {
    return Future.value(Result.failure(const UnknownFailure()));
  }
}

void main() {
  late GetHourlyForecastUseCase useCase;
  late MockWeatherRepository mockRepo;

  setUp(() {
    mockRepo = MockWeatherRepository();
    useCase = GetHourlyForecastUseCase(mockRepo);
  });

  test('should pass correct coordinates to repository', () async {
    await useCase.call(latitude: 32.0, longitude: 53.0);

    expect(mockRepo.capturedLat, 32.0);
    expect(mockRepo.capturedLon, 53.0);
  });

  test('should return ServerFailure on failure', () async {
    mockRepo.shouldSucceed = false;

    final result = await useCase.call(latitude: 0, longitude: 0);

    expect(result.isFailure, true);
    expect(result.failure, isA<ServerFailure>());
  });
}
