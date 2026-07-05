// [OWNER] — SharedPreferences implementation for settings.
// [DEV] — Maps between domain enums and core cache module strings.

import '../../../../core/cache/cache_module.dart';
import '../../domain/entities/temperature_unit.dart';
import '../../domain/entities/theme_mode_enum.dart';
import 'settings_local_data_source.dart';

class SharedPrefsSettingsDataSource implements SettingsLocalDataSource {
  final CacheModule _cache;

  static const String _tempUnitKey = 'temp_unit';
  static const String _langKey = 'language_code';
  static const String _themeKey = 'theme_mode';

  SharedPrefsSettingsDataSource({required CacheModule cache}) : _cache = cache;

  @override
  SettingsDto getSettings() {
    return SettingsDto(
      temperatureUnit: _parseTempUnit(_cache.getString(_tempUnitKey)),
      languageCode: _cache.getString(_langKey) ?? 'en',
      themeMode: _parseThemeMode(_cache.getString(_themeKey)),
    );
  }

  @override
  Future<bool> saveSettings(SettingsDto settings) async {
    await _cache.setString(_tempUnitKey, settings.temperatureUnit.name);
    await _cache.setString(_langKey, settings.languageCode);
    await _cache.setString(_themeKey, settings.themeMode.name);
    return true;
  }

  TemperatureUnit _parseTempUnit(String? name) {
    return TemperatureUnit.values.firstWhere(
      (e) => e.name == name,
      orElse: () => TemperatureUnit.celsius,
    );
  }

  AppThemeMode _parseThemeMode(String? name) {
    return AppThemeMode.values.firstWhere(
      (e) => e.name == name,
      orElse: () => AppThemeMode.system,
    );
  }
}
