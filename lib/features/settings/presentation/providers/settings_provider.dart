// [OWNER] — Settings Riverpod provider.
// [OWNER] — Manages user settings state (temperature unit, language, theme).
// [DEV] — Uses AsyncNotifier because initial load is async (reads from disk).

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/temperature_unit.dart';
import '../../domain/entities/theme_mode_enum.dart';
import '../../domain/usecases/get_settings_use_case.dart';
import '../../domain/usecases/update_language_use_case.dart';
import '../../domain/usecases/update_temperature_unit_use_case.dart';
import '../../domain/usecases/update_theme_use_case.dart';

/// [DEV] — Providers for settings use cases. Overridden in STEP 8.
final getSettingsUseCaseProvider = Provider<GetSettingsUseCase>((ref) {
  throw UnimplementedError('Must be overridden in app assembly.');
});

final updateTemperatureUnitUseCaseProvider =
    Provider<UpdateTemperatureUnitUseCase>((ref) {
  throw UnimplementedError('Must be overridden in app assembly.');
});

final updateLanguageUseCaseProvider = Provider<UpdateLanguageUseCase>((ref) {
  throw UnimplementedError('Must be overridden in app assembly.');
});

final updateThemeUseCaseProvider = Provider<UpdateThemeUseCase>((ref) {
  throw UnimplementedError('Must be overridden in app assembly.');
});

/// [DEV] — Notifier for managing settings state reactively.
class SettingsNotifier extends AsyncNotifier<SettingsState> {
  @override
  Future<SettingsState> build() async {
    final useCase = ref.read(getSettingsUseCaseProvider);
    final result = await useCase.call();

    return result.when(
      success: (settings) => settings,
      failure: (_) => const SettingsState(
        temperatureUnit: TemperatureUnit.celsius,
        languageCode: 'en',
        themeMode: AppThemeMode.system,
      ),
    );
  }

  Future<void> updateTemperatureUnit(TemperatureUnit unit) async {
    final useCase = ref.read(updateTemperatureUnitUseCaseProvider);
    await useCase.call(unit);
    ref.invalidateSelf(); // [DEV] — Trigger reload to sync state
  }

  Future<void> updateLanguage(String languageCode) async {
    final useCase = ref.read(updateLanguageUseCaseProvider);
    await useCase.call(languageCode);
    ref.invalidateSelf();
  }

  Future<void> updateThemeMode(AppThemeMode mode) async {
    final useCase = ref.read(updateThemeUseCaseProvider);
    await useCase.call(mode);
    ref.invalidateSelf();
  }
}

final settingsProvider = AsyncNotifierProvider<SettingsNotifier, SettingsState>(
  SettingsNotifier.new,
);
