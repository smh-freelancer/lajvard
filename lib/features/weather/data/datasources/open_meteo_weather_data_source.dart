// [OWNER] — Open-Meteo API implementation.
// [OWNER] — Fetches weather data from api.open-meteo.com.
// [DEV] — Uses the core/network module. All HTTP goes through NetworkClient.

import '../../../../core/network/network_client.dart';
import '../../../../core/network/network_response.dart';
import '../models/weather_model.dart';
import 'weather_remote_data_source.dart';

class OpenMeteoWeatherDataSource implements WeatherRemoteDataSource {
  final NetworkClient _networkClient;

  // [DEV] — 'v1/forecast' is the main weather endpoint.
  static const String _forecastPath = '/v1/forecast';

  OpenMeteoWeatherDataSource({required NetworkClient networkClient})
      : _networkClient = networkClient;

  @override
  Future<NetworkResponse<WeatherModel>> getFullWeather({
    required double latitude,
    required double longitude,
  }) {
    // [DEV] — Open-Meteo allows requesting multiple variables in one call.
    // [DEV] — We request everything we need to avoid multiple HTTP requests.
    return _networkClient.get<WeatherModel>(
      _forecastPath,
      queryParameters: {
        'latitude': latitude,
        'longitude': longitude,
        'current': [
          'temperature_2m',
          'relative_humidity_2m',
          'apparent_temperature',
          'weather_code',
          'wind_speed_10m',
          'wind_direction_10m',
          'surface_pressure',
        ].join(','),
        'hourly': [
          'temperature_2m',
          'weather_code',
          'precipitation_probability',
          'uv_index',
          'visibility',
          'dew_point_2m',
          'cloud_cover',
        ].join(','),
        'daily': [
          'weather_code',
          'temperature_2m_max',
          'temperature_2m_min',
          'precipitation_probability_max',
        ].join(','),
        'timezone': 'auto',
        'forecast_days':
            '8', // [DEV] — 8 to ensure we get 7 full days starting from tomorrow
      },
      fromJson: (data) => WeatherModel.fromJson(data as Map<String, dynamic>),
    );
  }
}
