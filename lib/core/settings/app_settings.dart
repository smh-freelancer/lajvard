// [OWNER] — Immutable app settings data class.
// [OWNER] — Contains all three user-facing toggles: temperature unit, language, theme.
// [DEV] — Used as the state object in Riverpod providers.

import 'package:flutter/material.dart';

/// [DEV] — Temperature unit options.
enum TemperatureUnit {
  celsius,
  fahrenheit,
}

/// [DEV] — App theme mode options (maps to Flutter's ThemeMode).
enum AppThemeMode {
  light,
  dark,
  system,
}

/// [DEV] — Converts our AppThemeMode to Flutter's ThemeMode.
ThemeMode toFlutterThemeMode(AppThemeMode mode) {
  switch (mode) {
    case AppThemeMode.light:
      return ThemeMode.light;
    case AppThemeMode.dark:
      return ThemeMode.dark;
    case AppThemeMode.system:
      return ThemeMode.system;
  }
}

/// [DEV] — Immutable settings class.
@immutable
class AppSettings {
  final TemperatureUnit temperatureUnit;
  final String languageCode;
  final AppThemeMode themeMode;

  const AppSettings({
    this.temperatureUnit = TemperatureUnit.celsius,
    this.languageCode = 'en',
    this.themeMode = AppThemeMode.system,
  });

  /// [DEV] — Creates a copy with optional overrides.
  AppSettings copyWith({
    TemperatureUnit? temperatureUnit,
    String? languageCode,
    AppThemeMode? themeMode,
  }) {
    return AppSettings(
      temperatureUnit: temperatureUnit ?? this.temperatureUnit,
      languageCode: languageCode ?? this.languageCode,
      themeMode: themeMode ?? this.themeMode,
    );
  }

  /// [DEV] — Serialization to JSON for local storage.
  Map<String, dynamic> toJson() => {
        'temperatureUnit': temperatureUnit.name,
        'languageCode': languageCode,
        'themeMode': themeMode.name,
      };

  /// [DEV] — Deserialization from JSON.
  factory AppSettings.fromJson(Map<String, dynamic> json) {
    return AppSettings(
      temperatureUnit: TemperatureUnit.values.firstWhere(
        (e) => e.name == json['temperatureUnit'],
        orElse: () => TemperatureUnit.celsius,
      ),
      languageCode: json['languageCode'] as String? ?? 'en',
      themeMode: AppThemeMode.values.firstWhere(
        (e) => e.name == json['themeMode'],
        orElse: () => AppThemeMode.system,
      ),
    );
  }
}
