// [OWNER] — Weather remote data source interface.
// [DEV] — Implemented by Open-Meteo specific data source.

import '../../../../core/network/network_response.dart';
import '../models/weather_model.dart';

abstract class WeatherRemoteDataSource {
  Future<NetworkResponse<WeatherModel>> getFullWeather({
    required double latitude,
    required double longitude,
  });
}
