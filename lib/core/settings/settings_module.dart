// [OWNER] — Settings module. Handles persisting and reading user settings.
// [OWNER] — Uses the CacheModule internally to store settings as JSON.
// [DEV] — Fully standalone: copy this file + app_settings.dart + cache_module.dart.

import 'dart:convert';
import '../cache/cache_module.dart';
import '../error/logger.dart';
import 'app_settings.dart';

class SettingsModule {
  static const String _settingsKey = 'app_settings';

  final CacheModule _cache;

  /// [DEV] — Requires an initialized CacheModule.
  SettingsModule({required CacheModule cache}) : _cache = cache;

  /// [DEV] — Reads settings from local cache. Returns defaults if not found.
  AppSettings getSettings() {
    try {
      final jsonStr = _cache.getString(_settingsKey);
      if (jsonStr == null) {
        AppLogger.instance
            .info('No saved settings, using defaults', name: 'Settings');
        return const AppSettings();
      }

      // [DEV] — Using standard dart:convert top-level functions.
      final decoded = jsonDecode(jsonStr) as Map<String, dynamic>;
      return AppSettings.fromJson(decoded);
    } catch (e) {
      AppLogger.instance
          .error('Failed to load settings', name: 'Settings', error: e);
      return const AppSettings();
    }
  }

  /// [DEV] — Saves settings to local cache.
  Future<bool> saveSettings(AppSettings settings) async {
    try {
      // [DEV] — Using standard dart:convert top-level function.
      final jsonStr = jsonEncode(settings.toJson());
      final result = await _cache.setString(_settingsKey, jsonStr);
      AppLogger.instance.info('Settings saved', name: 'Settings');
      return result;
    } catch (e) {
      AppLogger.instance
          .error('Failed to save settings', name: 'Settings', error: e);
      return false;
    }
  }

  /// [DEV] — Updates only the temperature unit.
  Future<bool> updateTemperatureUnit(TemperatureUnit unit) async {
    final current = getSettings();
    return saveSettings(current.copyWith(temperatureUnit: unit));
  }

  /// [DEV] — Updates only the language.
  Future<bool> updateLanguage(String languageCode) async {
    final current = getSettings();
    return saveSettings(current.copyWith(languageCode: languageCode));
  }

  /// [DEV] — Updates only the theme mode.
  Future<bool> updateThemeMode(AppThemeMode mode) async {
    final current = getSettings();
    return saveSettings(current.copyWith(themeMode: mode));
  }
}
