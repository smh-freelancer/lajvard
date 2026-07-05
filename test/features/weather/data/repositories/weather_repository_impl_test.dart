// [OWNER] — Unit test for WeatherRepositoryImpl.
// [DEV] — Tests adapter pattern: API response -> domain entity conversion.
// [DEV] — Tests exception to failure mapping.

import 'package:flutter_test/flutter_test.dart';
import 'package:lajvard/core/error/app_exception.dart';
import 'package:lajvard/core/error/failure.dart';
import 'package:lajvard/core/network/network_response.dart';
import 'package:lajvard/features/weather/data/datasources/weather_remote_data_source.dart';
import 'package:lajvard/features/weather/data/models/current_weather_model.dart';
import 'package:lajvard/features/weather/data/models/daily_forecast_model.dart';
// [DEV] — Import models for mock data
import 'package:lajvard/features/weather/data/models/hourly_forecast_model.dart';
import 'package:lajvard/features/weather/data/models/weather_details_model.dart';
import 'package:lajvard/features/weather/data/models/weather_model.dart';
import 'package:lajvard/features/weather/data/repositories/weather_repository_impl.dart';

// [DEV] — Manual mock for remote data source
class MockWeatherRemoteDataSource implements WeatherRemoteDataSource {
  bool shouldThrowNetworkException = false;
  bool shouldThrowParseException = false;
  bool shouldReturnHttpError = false;

  @override
  Future<NetworkResponse<WeatherModel>> getFullWeather({
    required double latitude,
    required double longitude,
  }) async {
    if (shouldThrowNetworkException) {
      throw const NetworkException(message: 'No internet');
    }
    if (shouldThrowParseException) {
      throw const ParseException(message: 'Bad JSON');
    }
    if (shouldReturnHttpError) {
      return const ApiResponseFailure(message: 'Server Error', statusCode: 500);
    }

    // [DEV] — Return a valid mock model
    return ApiResponseSuccess(
      data: WeatherModel(
        current: CurrentWeatherModel(
          temperatureCelsius: 30.0,
          weatherCode: 2,
          feelsLikeCelsius: 32.0,
          windSpeedKph: 15.0,
          windDirectionDegrees: 90,
          humidityPercent: 40,
          pressureHpa: 1015.0,
          dateTime: DateTime(2025, 7, 5, 14),
        ),
        hourly: const HourlyForecastModel(items: []),
        daily: const DailyForecastModel(items: []),
        details: const WeatherDetailsModel(
          uvIndex: 5.0,
          visibilityKm: 10.0,
          dewPointCelsius: 15.0,
          cloudCoverPercent: 20,
        ),
      ),
      statusCode: 200,
    );
  }
}

void main() {
  late WeatherRepositoryImpl repository;
  late MockWeatherRemoteDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockWeatherRemoteDataSource();
    repository = WeatherRepositoryImpl(remoteDataSource: mockDataSource);
  });

  test('should map successful API response to WeatherEntity', () async {
    // Act
    final result =
        await repository.getFullWeather(latitude: 35.0, longitude: 51.0);

    // Assert
    expect(result.isSuccess, true);
    expect(result.value.current.temperatureCelsius, 30.0);
    expect(result.value.current.weatherCode, 2);
  });

  test('should map NetworkException to NetworkFailure', () async {
    // Arrange
    mockDataSource.shouldThrowNetworkException = true;

    // Act
    final result =
        await repository.getFullWeather(latitude: 35.0, longitude: 51.0);

    // Assert
    expect(result.isFailure, true);
    expect(result.failure, isA<NetworkFailure>());
  });

  test('should map ParseException to ParseFailure', () async {
    // Arrange
    mockDataSource.shouldThrowParseException = true;

    // Act
    final result =
        await repository.getFullWeather(latitude: 35.0, longitude: 51.0);

    // Assert
    expect(result.isFailure, true);
    expect(result.failure, isA<ParseFailure>());
  });

  test('should map HTTP 500 to ServerFailure', () async {
    // Arrange
    mockDataSource.shouldReturnHttpError = true;

    // Act
    final result =
        await repository.getFullWeather(latitude: 35.0, longitude: 51.0);

    // Assert
    expect(result.isFailure, true);
    expect(result.failure, isA<ServerFailure>());
    final failure = result.failure as ServerFailure;
    expect(failure.statusCode, 500);
  });
}
