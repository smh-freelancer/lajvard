// [OWNER] — Unit test for GetCurrentWeatherUseCase.
// [DEV] — Tests success and failure paths with manual mocks (no mockito per Rule 23).

import 'package:flutter_test/flutter_test.dart';
import 'package:lajvard/core/error/failure.dart';
import 'package:lajvard/features/weather/domain/entities/current_weather_entity.dart';
import 'package:lajvard/features/weather/domain/entities/hourly_forecast_entity.dart';
import 'package:lajvard/features/weather/domain/entities/daily_forecast_entity.dart';
import 'package:lajvard/features/weather/domain/entities/weather_details_entity.dart';
import 'package:lajvard/features/weather/domain/entities/weather_entity.dart';
import 'package:lajvard/features/weather/domain/repositories/weather_repository.dart';
import 'package:lajvard/features/weather/domain/usecases/get_current_weather_use_case.dart';

// [DEV] — Manual mock for WeatherRepository with strict typing
class MockWeatherRepository implements WeatherRepository {
  bool shouldSucceed = true;

  @override
  Future<Result<CurrentWeatherEntity>> getCurrentWeather({
    required double latitude,
    required double longitude,
  }) async {
    if (shouldSucceed) {
      return Result.success(_createMockEntity());
    } else {
      return Result.failure(const NetworkFailure());
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
  Future<Result<HourlyForecastEntity>> getHourlyForecast({
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

  CurrentWeatherEntity _createMockEntity() {
    return CurrentWeatherEntity(
      temperatureCelsius: 25.0,
      weatherCode: 0,
      feelsLikeCelsius: 26.0,
      windSpeedKph: 10.0,
      windDirectionDegrees: 180,
      humidityPercent: 50,
      pressureHpa: 1012.0,
      dateTime: DateTime(2025, 7, 5, 14),
    );
  }
}

void main() {
  late GetCurrentWeatherUseCase useCase;
  late MockWeatherRepository mockRepo;

  setUp(() {
    mockRepo = MockWeatherRepository();
    useCase = GetCurrentWeatherUseCase(mockRepo);
  });

  test('should return CurrentWeatherEntity on success', () async {
    // Arrange
    mockRepo.shouldSucceed = true;

    // Act
    final result = await useCase.call(latitude: 35.6892, longitude: 51.3890);

    // Assert
    expect(result.isSuccess, true);
    expect(result.value.temperatureCelsius, 25.0);
  });

  test('should return NetworkFailure on failure', () async {
    // Arrange
    mockRepo.shouldSucceed = false;

    // Act
    final result = await useCase.call(latitude: 35.6892, longitude: 51.3890);

    // Assert
    expect(result.isFailure, true);
    expect(result.failure, isA<NetworkFailure>());
  });
}
