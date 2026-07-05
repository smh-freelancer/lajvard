// [OWNER] — Location repository implementation.
// [DEV] — Connects device GPS and geocoding data sources to the domain layer.

import '../../../../core/error/app_exception.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_response.dart';
import '../../domain/entities/location_entity.dart';
import '../../domain/repositories/location_repository.dart';
import '../datasources/device_location_data_source.dart';
import '../datasources/location_remote_data_source.dart';
import '../models/location_model.dart';

class LocationRepositoryImpl implements LocationRepository {
  final DeviceLocationDataSource deviceDataSource;
  final LocationRemoteDataSource remoteDataSource;

  LocationRepositoryImpl({
    required this.deviceDataSource,
    required this.remoteDataSource,
  });

  @override
  Future<Result<LocationEntity>> getCurrentPosition() async {
    try {
      final coords = await deviceDataSource.getCurrentPosition();

      // [DEV] — We create a basic entity marked as "Current Location".
      // [DEV] — The weather header will display this gracefully.
      return Result.success(
        LocationEntity(
          latitude: coords.latitude,
          longitude: coords.longitude,
          name: 'Current Location',
          country: '',
          adminArea: '',
        ),
      );
    } on LocationException catch (e) {
      return Result.failure(LocationFailure(message: e.message, code: e.code));
    } catch (e) {
      return Result.failure(const LocationFailure());
    }
  }

  @override
  Future<Result<List<LocationEntity>>> searchCity(String query) async {
    if (query.trim().isEmpty) {
      return Result.success(const []);
    }

    try {
      final response = await remoteDataSource.searchCities(query);

      // [DEV] — Use pattern matching to safely extract the list and map to entities.
      if (response case ApiResponseSuccess<List<LocationModel>>(:final data)) {
        final entities = data.map((model) => model.toEntity()).toList();
        return Result.success(entities);
      } else if (response case ApiResponseFailure<List<LocationModel>>()) {
        return Result.failure(const NetworkFailure());
      }

      return Result.failure(const UnknownFailure());
    } on AppException catch (e) {
      return Result.failure(_mapException(e));
    } catch (e) {
      return Result.failure(UnknownFailure(message: e.toString()));
    }
  }

  Failure _mapException(AppException e) {
    switch (e) {
      case NetworkException():
        return const NetworkFailure();
      case ServerException():
        return ServerFailure(statusCode: e.statusCode, message: e.message);
      default:
        return UnknownFailure(message: e.message);
    }
  }
}
