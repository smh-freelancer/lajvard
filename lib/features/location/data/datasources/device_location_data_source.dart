// [OWNER] — Device GPS location data source.
// [OWNER] — Gets the user's current latitude/longitude.
// [DEV] — Uses Geolocator. Handles permissions gracefully.

import 'package:geolocator/geolocator.dart';
import '../../../../core/error/app_exception.dart';
import '../../../../core/error/logger.dart';

class DeviceLocationDataSource {
  Future<({double latitude, double longitude})> getCurrentPosition() async {
    try {
      // [DEV] — Check if location services are enabled.
      final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw const LocationException(
          message: 'Location services are disabled.',
          code: 'SERVICE_DISABLED',
        );
      }

      // [DEV] — Check and request permissions.
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw const LocationException(
            message: 'Location permission denied.',
            code: 'PERMISSION_DENIED',
          );
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw const LocationException(
          message: 'Location permission permanently denied.',
          code: 'PERMISSION_DENIED_FOREVER',
        );
      }

      // [DEV] — Get current position with high accuracy.
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 10),
        ),
      );

      AppLogger.instance.info(
        'Device location acquired: ${position.latitude}, ${position.longitude}',
        name: 'Location',
      );

      return (latitude: position.latitude, longitude: position.longitude);
    } on LocationException {
      rethrow;
    } catch (e) {
      AppLogger.instance.error('Failed to get device location', error: e);
      throw LocationException(
        message: 'Could not get location.',
        originalError: e,
      );
    }
  }
}
