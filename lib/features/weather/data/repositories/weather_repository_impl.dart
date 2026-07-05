// [OWNER] — Weather repository implementation.
// [OWNER] — Connects the data source to the domain layer.
// [DEV] — Adapter pattern: catches AppExceptions and maps them to Failures.

import '../../../../core/error/app_exception.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_response.dart';
import '../../domain/entities/current_weather_entity.dart';
import '../../domain/entities/daily_forecast_entity.dart';
import '../../domain/entities/hourly_forecast_entity.dart';
import '../../domain/entities/weather_details_entity.dart';
import '../../domain/entities/weather_entity.dart';
import '../../domain/repositories/weather_repository.dart';
import '../datasources/weather_remote_data_source.dart';
import '../models/weather_model.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource remoteDataSource;

  WeatherRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Result<WeatherEntity>> getFullWeather({
    required double latitude,
    required double longitude,
  }) async {
    try {
      final response = await remoteDataSource.getFullWeather(
        latitude: latitude,
        longitude: longitude,
      );

      if (response is ApiResponseSuccess<WeatherModel>) {
        return Result.success(response.data.toEntity());
      } else if (response is ApiResponseFailure<WeatherModel>) {
        return Result.failure(_mapFailure(response));
      }
      return Result.failure(const UnknownFailure());
    } on AppException catch (e) {
      return Result.failure(_mapException(e));
    } catch (e) {
      return Result.failure(UnknownFailure(message: e.toString()));
    }
  }

  // [DEV] — Granular methods delegate to getFullWeather and extract the needed part.
  // [DEV] — This avoids making multiple API calls since Open-Meteo returns everything at once.
  @override
  Future<Result<CurrentWeatherEntity>> getCurrentWeather({
    required double latitude,
    required double longitude,
  }) async {
    final result =
        await getFullWeather(latitude: latitude, longitude: longitude);
    return result.map((weather) => weather.current);
  }

  @override
  Future<Result<HourlyForecastEntity>> getHourlyForecast({
    required double latitude,
    required double longitude,
  }) async {
    final result =
        await getFullWeather(latitude: latitude, longitude: longitude);
    return result.map((weather) => weather.hourly);
  }

  @override
  Future<Result<DailyForecastEntity>> getDailyForecast({
    required double latitude,
    required double longitude,
  }) async {
    final result =
        await getFullWeather(latitude: latitude, longitude: longitude);
    return result.map((weather) => weather.daily);
  }

  @override
  Future<Result<WeatherDetailsEntity>> getWeatherDetails({
    required double latitude,
    required double longitude,
  }) async {
    final result =
        await getFullWeather(latitude: latitude, longitude: longitude);
    return result.map((weather) => weather.details);
  }

  // [DEV] — Maps ApiResponseFailure to domain Failure
  Failure _mapFailure(ApiResponseFailure<dynamic> response) {
    final statusCode = response.statusCode;
    if (statusCode == null || statusCode == 0) {
      return const NetworkFailure();
    }
    return ServerFailure(
      statusCode: statusCode,
      message: response.message,
    );
  }

  // [DEV] — Maps AppException to domain Failure
  Failure _mapException(AppException e) {
    switch (e) {
      case NetworkException():
        return const NetworkFailure();
      case ServerException():
        return ServerFailure(statusCode: e.statusCode, message: e.message);
      case ParseException():
        return const ParseFailure();
      default:
        return UnknownFailure(message: e.message);
    }
  }
}
