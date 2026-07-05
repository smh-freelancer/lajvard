// [OWNER] — Location repository interface.
// [DEV] — Defines device location and city search operations.

import '../../../../core/error/failure.dart';
import '../entities/location_entity.dart';

abstract class LocationRepository {
  /// [DEV] — Get the device's current GPS coordinates.
  Future<Result<LocationEntity>> getCurrentPosition();

  /// [DEV] — Search for cities by name (Geocoding).
  Future<Result<List<LocationEntity>>> searchCity(String query);
}
