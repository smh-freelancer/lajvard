// [OWNER] — Unit test for GetDailyForecastUseCase.
// [DEV] — Tests success path and ensures correct repository call.

import 'package:flutter_test/flutter_test.dart';
import 'package:lajvard/core/error/failure.dart';
import 'package:lajvard/features/weather/domain/entities/current_weather_entity.dart';
import 'package:lajvard/features/weather/domain/entities/daily_forecast_entity.dart';
import 'package:lajvard/features/weather/domain/entities/hourly_forecast_entity.dart';
import 'package:lajvard/features/weather/domain/entities/weather_details_entity.dart';
import 'package:lajvard/features/weather/domain/entities/weather_entity.dart';
import 'package:lajvard/features/weather/domain/repositories/weather_repository.dart';
import 'package:lajvard/features/weather/domain/usecases/get_daily_forecast_use_case.dart';

class MockWeatherRepository implements WeatherRepository {
  int callCount = 0;

  @override
  Future<Result<DailyForecastEntity>> getDailyForecast({
    required double latitude,
    required double longitude,
  }) async {
    callCount++;
    return Result.success(const DailyForecastEntity(items: []));
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
  Future<Result<HourlyForecastEntity>> getHourlyForecast({
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
  late GetDailyForecastUseCase useCase;
  late MockWeatherRepository mockRepo;

  setUp(() {
    mockRepo = MockWeatherRepository();
    useCase = GetDailyForecastUseCase(mockRepo);
  });

  test('should call repository exactly once', () async {
    await useCase.call(latitude: 10.0, longitude: 20.0);

    expect(mockRepo.callCount, 1);
  });

  test('should return empty list on success (mocked data)', () async {
    final result = await useCase.call(latitude: 10.0, longitude: 20.0);

    expect(result.isSuccess, true);
    expect(result.value.items.isEmpty, true);
  });
}
