// [OWNER] — Unit test for WeatherModel fromJson.
// [DEV] — Tests null safety, default values, and missing fields (Rule 24).

import 'package:flutter_test/flutter_test.dart';
import 'package:lajvard/features/weather/data/models/current_weather_model.dart';

void main() {
  group('CurrentWeatherModel fromJson', () {
    test('should parse valid JSON correctly', () {
      final json = {
        'current': {
          'time': '2025-07-05T14:00',
          'temperature_2m': 28.5,
          'weather_code': 2,
          'apparent_temperature': 30.0,
          'wind_speed_10m': 12.3,
          'wind_direction_10m': 180,
          'relative_humidity_2m': 55,
          'surface_pressure': 1013.25,
        },
      };

      final model = CurrentWeatherModel.fromJson(json);

      expect(model.temperatureCelsius, 28.5);
      expect(model.weatherCode, 2);
      expect(model.windSpeedKph, 12.3);
      expect(model.dateTime.year, 2025);
    });

    test('should use defaults when fields are missing', () {
      final json = {
        'current': {
          'time': null,
          'temperature_2m': null,
          'weather_code': null,
        },
      };

      final model = CurrentWeatherModel.fromJson(json);

      expect(model.temperatureCelsius, 0.0); // Default
      expect(model.weatherCode, 0); // Default
      expect(model.humidityPercent, 0); // Default
      // [DEV] — DateTime.now() is used as fallback, so we just check it's a valid date
      expect(model.dateTime.year, DateTime.now().year);
    });

    test('should use defaults when current object is entirely missing', () {
      final json = <String, dynamic>{};

      final model = CurrentWeatherModel.fromJson(json);

      expect(model.temperatureCelsius, 0.0);
      expect(model.weatherCode, 0);
    });
  });
}
