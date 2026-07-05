// [OWNER] — Settings repository implementation.
// [DEV] — Maps local data source DTOs to domain SettingsState.

import '../../../../core/error/failure.dart';
import '../../domain/entities/temperature_unit.dart';
import '../../domain/entities/theme_mode_enum.dart';
import '../../domain/repositories/settings_repository.dart';
import '../datasources/settings_local_data_source.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsLocalDataSource localDataSource;

  SettingsRepositoryImpl({required this.localDataSource});

  @override
  Future<Result<SettingsState>> getSettings() async {
    try {
      final dto = localDataSource.getSettings();
      return Result.success(
        SettingsState(
          temperatureUnit: dto.temperatureUnit,
          languageCode: dto.languageCode,
          themeMode: dto.themeMode,
        ),
      );
    } catch (e) {
      return Result.failure(const CacheFailure());
    }
  }

  @override
  Future<Result<void>> updateTemperatureUnit(TemperatureUnit unit) async {
    try {
      final current = localDataSource.getSettings();
      await localDataSource.saveSettings(
        SettingsDto(
          temperatureUnit: unit,
          languageCode: current.languageCode,
          themeMode: current.themeMode,
        ),
      );
      return Result.success(null);
    } catch (e) {
      return Result.failure(const CacheFailure());
    }
  }

  @override
  Future<Result<void>> updateLanguage(String languageCode) async {
    try {
      final current = localDataSource.getSettings();
      await localDataSource.saveSettings(
        SettingsDto(
          temperatureUnit: current.temperatureUnit,
          languageCode: languageCode,
          themeMode: current.themeMode,
        ),
      );
      return Result.success(null);
    } catch (e) {
      return Result.failure(const CacheFailure());
    }
  }

  @override
  Future<Result<void>> updateThemeMode(AppThemeMode mode) async {
    try {
      final current = localDataSource.getSettings();
      await localDataSource.saveSettings(
        SettingsDto(
          temperatureUnit: current.temperatureUnit,
          languageCode: current.languageCode,
          themeMode: mode,
        ),
      );
      return Result.success(null);
    } catch (e) {
      return Result.failure(const CacheFailure());
    }
  }
}
