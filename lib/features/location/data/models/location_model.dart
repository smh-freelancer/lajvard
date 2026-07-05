// [OWNER] — Location data model.
// [OWNER] — Maps Open-Meteo Geocoding API response to LocationEntity.
// [DEV] — Adapter pattern.

import '../../../../core/error/app_exception.dart';
import '../../../../core/error/json_parser.dart';
import '../../../../core/error/logger.dart';
import '../../domain/entities/location_entity.dart';

class LocationModel {
  final double latitude;
  final double longitude;
  final String name;
  final String country;
  final String? adminArea;

  const LocationModel({
    required this.latitude,
    required this.longitude,
    required this.name,
    required this.country,
    this.adminArea,
  });

  LocationEntity toEntity() {
    return LocationEntity(
      latitude: latitude,
      longitude: longitude,
      name: name,
      country: country,
      adminArea: adminArea,
    );
  }

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    try {
      return LocationModel(
        latitude: parseDouble(json['latitude']),
        longitude: parseDouble(json['longitude']),
        name: (json['name'] as String?) ?? '',
        country: (json['country'] as String?) ?? '',
        adminArea: (json['admin1'] as String?) ?? '',
      );
    } catch (e) {
      AppLogger.instance.error('LocationModel parse error', error: e);
      throw const ParseException(message: 'Failed to parse location');
    }
  }
}
