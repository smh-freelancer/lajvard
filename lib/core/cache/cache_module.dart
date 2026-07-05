// [OWNER] — Cache module. Provides a clean way to read/write simple data locally.
// [OWNER] — Uses SharedPreferences under the hood.
// [DEV] — Singleton pattern. Must be initialized once in main() before use.
// [DEV] — Fully standalone: copy this file, call `CacheModule.instance.init()`.

import 'package:shared_preferences/shared_preferences.dart';
import '../error/logger.dart';

class CacheModule {
  CacheModule._();
  static final CacheModule instance = CacheModule._();

  SharedPreferences? _prefs;

  /// [DEV] — Must be called in main() before using any cache methods.
  Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
    AppLogger.instance.info('CacheModule initialized', name: 'Cache');
  }

  /// [DEV] — Ensures prefs are initialized. Throws if init() wasn't called.
  SharedPreferences get _safePrefs {
    if (_prefs == null) {
      throw StateError(
        'CacheModule not initialized. Call CacheModule.instance.init() first.',
      );
    }
    return _prefs!;
  }

  // ── Write Methods ─────────────────────────────────────────────────

  Future<bool> setString(String key, String value) async {
    return _safePrefs.setString(key, value);
  }

  Future<bool> setInt(String key, int value) async {
    return _safePrefs.setInt(key, value);
  }

  Future<bool> setBool(String key, bool value) async {
    return _safePrefs.setBool(key, value);
  }

  Future<bool> setDouble(String key, double value) async {
    return _safePrefs.setDouble(key, value);
  }

  Future<bool> setStringList(String key, List<String> value) async {
    return _safePrefs.setStringList(key, value);
  }

  // ── Read Methods ──────────────────────────────────────────────────

  String? getString(String key, {String? defaultValue}) {
    return _safePrefs.getString(key) ?? defaultValue;
  }

  int? getInt(String key, {int? defaultValue}) {
    return _safePrefs.getInt(key) ?? defaultValue;
  }

  bool? getBool(String key, {bool? defaultValue}) {
    return _safePrefs.getBool(key) ?? defaultValue;
  }

  double? getDouble(String key, {double? defaultValue}) {
    return _safePrefs.getDouble(key) ?? defaultValue;
  }

  List<String>? getStringList(String key, {List<String>? defaultValue}) {
    return _safePrefs.getStringList(key) ?? defaultValue;
  }

  // ── Delete Methods ────────────────────────────────────────────────

  Future<bool> remove(String key) async {
    return _safePrefs.remove(key);
  }

  Future<bool> clear() async {
    return _safePrefs.clear();
  }

  /// [DEV] — Returns true if a key exists in cache.
  bool containsKey(String key) {
    return _safePrefs.containsKey(key);
  }
}
