// [OWNER] — Unit test for temperature unit conversion logic.
// [DEV] — Tests the Strategy pattern extension on TemperatureUnit enum.

import 'package:flutter_test/flutter_test.dart';
import 'package:lajvard/features/settings/domain/entities/temperature_unit.dart';

void main() {
  group('TemperatureConversion Extension', () {
    test('Celsius to Celsius returns same value', () {
      const unit = TemperatureUnit.celsius;
      expect(unit.convertFromCelsius(25.0), 25.0);
    });

    test('Celsius to Fahrenheit calculates correctly', () {
      const unit = TemperatureUnit.fahrenheit;
      // Formula: (C * 9/5) + 32
      expect(unit.convertFromCelsius(0.0), 32.0);
      expect(unit.convertFromCelsius(100.0), 212.0);
      expect(unit.convertFromCelsius(25.0), 77.0);
    });

    test('Celsius symbol is °C', () {
      const unit = TemperatureUnit.celsius;
      expect(unit.symbol, '°C');
    });

    test('Fahrenheit symbol is °F', () {
      const unit = TemperatureUnit.fahrenheit;
      expect(unit.symbol, '°F');
    });
  });
}
