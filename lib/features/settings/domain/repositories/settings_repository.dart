// [OWNER] — Settings repository interface.
// [DEV] — Abstracts how settings are read/written.

import 'package:flutter/material.dart';

import '../../../../core/error/failure.dart';
import '../entities/temperature_unit.dart';
import '../entities/theme_mode_enum.dart';

/// [DEV] — Combined settings state to avoid multiple calls.
@immutable
class SettingsState {
  final TemperatureUnit temperatureUnit;
  final String languageCode;
  final AppThemeMode themeMode;

  const SettingsState({
    required this.temperatureUnit,
    required this.languageCode,
    required this.themeMode,
  });
}

abstract class SettingsRepository {
  Future<Result<SettingsState>> getSettings();
  Future<Result<void>> updateTemperatureUnit(TemperatureUnit unit);
  Future<Result<void>> updateLanguage(String languageCode);
  Future<Result<void>> updateThemeMode(AppThemeMode mode);
}
