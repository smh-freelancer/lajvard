// [OWNER] — Settings screen.
// [OWNER] — Three user-facing toggles: Temperature, Language, Theme.
// [DEV] — Changing language/theme here triggers instant app-wide updates.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/localization/locale_service.dart';
import '../../domain/entities/temperature_unit.dart';
import '../../domain/entities/theme_mode_enum.dart';
import '../../domain/repositories/settings_repository.dart' show SettingsState;
import '../providers/settings_provider.dart';
import '../widgets/setting_toggle_tile.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsAsync = ref.watch(settingsProvider);
    final localeService =
        LocaleService(locale: Localizations.localeOf(context));

    return Scaffold(
      appBar: AppBar(
        title: Text(localeService.convertDigits('Settings')),
      ),
      body: settingsAsync.when(
        data: (settings) => _buildContent(context, ref, settings),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) => Center(
          child: Text(localeService.convertDigits('Failed to load settings')),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    WidgetRef ref,
    SettingsState settings,
  ) {
    final localeService =
        LocaleService(locale: Localizations.localeOf(context));

    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        // [DEV] — 1. Temperature Unit Toggle
        SettingToggleTile<TemperatureUnit>(
          title: localeService.convertDigits('Temperature Unit'),
          currentValue: settings.temperatureUnit,
          options: TemperatureUnit.values,
          getLabel: (unit) {
            switch (unit) {
              case TemperatureUnit.celsius:
                return localeService.convertDigits('Celsius (°C)');
              case TemperatureUnit.fahrenheit:
                return localeService.convertDigits('Fahrenheit (°F)');
            }
          },
          onChanged: (unit) {
            ref.read(settingsProvider.notifier).updateTemperatureUnit(unit);
          },
        ),

        // [DEV] — 2. Language Toggle
        SettingToggleTile<String>(
          title: localeService.convertDigits('Language'),
          currentValue: settings.languageCode,
          options: const ['en', 'fa'],
          getLabel: (code) {
            switch (code) {
              case 'fa':
                return 'فارسی';
              case 'en':
              default:
                return 'English';
            }
          },
          onChanged: (code) {
            ref.read(settingsProvider.notifier).updateLanguage(code);
          },
        ),

        // [DEV] — 3. Theme Toggle
        SettingToggleTile<AppThemeMode>(
          title: localeService.convertDigits('Theme'),
          currentValue: settings.themeMode,
          options: AppThemeMode.values,
          getLabel: (mode) {
            switch (mode) {
              case AppThemeMode.light:
                return localeService.convertDigits('Light');
              case AppThemeMode.dark:
                return localeService.convertDigits('Dark');
              case AppThemeMode.system:
                return localeService.convertDigits('System');
            }
          },
          onChanged: (mode) {
            ref.read(settingsProvider.notifier).updateThemeMode(mode);
          },
        ),
      ],
    );
  }
}
