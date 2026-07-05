// [OWNER] — Settings local data source interface.
// [DEV] — Implemented by SharedPreferences wrapper.

import '../../domain/entities/temperature_unit.dart';
import '../../domain/entities/theme_mode_enum.dart';

class SettingsDto {
  final TemperatureUnit temperatureUnit;
  final String languageCode;
  final AppThemeMode themeMode;

  const SettingsDto({
    required this.temperatureUnit,
    required this.languageCode,
    required this.themeMode,
  });
}

abstract class SettingsLocalDataSource {
  SettingsDto getSettings();
  Future<bool> saveSettings(SettingsDto settings);
}
