// [OWNER] — Weather details data model.
// [OWNER] — Extracts UV, visibility, dew point, and cloud cover.

import '../../../../core/error/app_exception.dart';
import '../../../../core/error/json_parser.dart';
import '../../../../core/error/logger.dart';
import '../../domain/entities/weather_details_entity.dart';

class WeatherDetailsModel {
  final double uvIndex;
  final double visibilityKm;
  final double dewPointCelsius;
  final int cloudCoverPercent;

  const WeatherDetailsModel({
    required this.uvIndex,
    required this.visibilityKm,
    required this.dewPointCelsius,
    required this.cloudCoverPercent,
  });

  WeatherDetailsEntity toEntity() {
    return WeatherDetailsEntity(
      uvIndex: uvIndex,
      visibilityKm: visibilityKm,
      dewPointCelsius: dewPointCelsius,
      cloudCoverPercent: cloudCoverPercent,
    );
  }

  factory WeatherDetailsModel.fromJson(Map<String, dynamic> json) {
    try {
      final hourlyJson = json['hourly'] as Map<String, dynamic>? ?? {};
      final times =
          (hourlyJson['time'] as List<dynamic>?)?.cast<String>() ?? [];

      final uvIndices = (hourlyJson['uv_index'] as List<dynamic>?) ?? [];
      final visibilities = (hourlyJson['visibility'] as List<dynamic>?) ?? [];
      final dewPoints = (hourlyJson['dew_point_2m'] as List<dynamic>?) ?? [];
      final clouds = (hourlyJson['cloud_cover'] as List<dynamic>?) ?? [];

      final now = DateTime.now();
      int closestIndex = 0;
      if (times.isNotEmpty) {
        Duration minDiff = const Duration(days: 999);
        for (int i = 0; i < times.length; i++) {
          final t = DateTime.tryParse(times[i]);
          if (t != null) {
            final diff = t.difference(now).abs();
            if (diff < minDiff) {
              minDiff = diff;
              closestIndex = i;
            }
          }
        }
      }

      final uv = (uvIndices.isNotEmpty && closestIndex < uvIndices.length)
          ? parseDouble(uvIndices[closestIndex])
          : 0.0;
      final vis =
          (visibilities.isNotEmpty && closestIndex < visibilities.length)
              ? parseDouble(visibilities[closestIndex])
              : 10.0;
      final dew = (dewPoints.isNotEmpty && closestIndex < dewPoints.length)
          ? parseDouble(dewPoints[closestIndex])
          : 0.0;
      final cloud = (clouds.isNotEmpty && closestIndex < clouds.length)
          ? parseInt(clouds[closestIndex])
          : 0;

      return WeatherDetailsModel(
        uvIndex: uv,
        visibilityKm: vis / 1000.0,
        dewPointCelsius: dew,
        cloudCoverPercent: cloud,
      );
    } catch (e) {
      AppLogger.instance.error('WeatherDetailsModel parse error', error: e);
      throw const ParseException(message: 'Failed to parse weather details');
    }
  }
}
