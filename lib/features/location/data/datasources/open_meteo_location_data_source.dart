// [OWNER] — Open-Meteo Geocoding API implementation.
// [DEV] — Uses core/network module.

import '../../../../core/network/network_client.dart';
import '../../../../core/network/network_response.dart';
import '../models/location_model.dart';
import 'location_remote_data_source.dart';

class OpenMeteoLocationDataSource implements LocationRemoteDataSource {
  final NetworkClient _networkClient;
  static const String _geocodingPath = '/v1/search';

  OpenMeteoLocationDataSource({required NetworkClient networkClient})
      : _networkClient = networkClient;

  @override
  Future<NetworkResponse<List<LocationModel>>> searchCities(String query) {
    return _networkClient.get<List<LocationModel>>(
      _geocodingPath,
      queryParameters: {
        'name': query,
        'count': '10', // [DEV] — Limit results to 10
        'language':
            'en', // [DEV] — API returns English names, we localize in UI
        'format': 'json',
      },
      fromJson: (data) {
        final results = data['results'] as List<dynamic>?;
        if (results == null) return [];
        return results
            .map((item) => LocationModel.fromJson(item as Map<String, dynamic>))
            .toList();
      },
    );
  }
}
