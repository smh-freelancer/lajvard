// [OWNER] — Location remote data source interface.
// [DEV] — Implemented by Open-Meteo Geocoding.

import '../../../../core/network/network_response.dart';
import '../models/location_model.dart';

abstract class LocationRemoteDataSource {
  Future<NetworkResponse<List<LocationModel>>> searchCities(String query);
}
