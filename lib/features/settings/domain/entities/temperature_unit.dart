// [OWNER] — Temperature unit enum and conversion logic.
// [DEV] — Strategy pattern: different conversion logic per unit.
// [DEV] — Note: The actual AppSettings class is in core/settings/.
// [DEV] — This domain-specific enum lives here because it's used by domain use cases.

/// [DEV] — Re-export from core to keep domain layer self-contained for use cases.
// [DEV] — Actually, to avoid circular dependencies, we define the domain-specific
// [DEV] — enum here and map it to the core enum in the data layer.
enum TemperatureUnit {
  celsius,
  fahrenheit,
}

/// [DEV] — Extension to add conversion strategies.
extension TemperatureConversion on TemperatureUnit {
  /// [DEV] — Convert Celsius to the selected unit.
  double convertFromCelsius(double celsius) {
    switch (this) {
      case TemperatureUnit.celsius:
        return celsius;
      case TemperatureUnit.fahrenheit:
        return (celsius * 9 / 5) + 32;
    }
  }

  /// [DEV] — Get the unit symbol.
  String get symbol {
    switch (this) {
      case TemperatureUnit.celsius:
        return '°C';
      case TemperatureUnit.fahrenheit:
        return '°F';
    }
  }
}
