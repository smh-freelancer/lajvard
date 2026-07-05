// [OWNER] — Root app widget.
// [OWNER] — Sets up MaterialApp.router, theme, locale, and routing.
// [DEV] — This is the single point where all providers, theme, and routing converge.
// [DEV] — Injects all use case dependencies so providers don't throw UnimplementedError.

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart'; // [DEV] — Required for localization delegates
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_router.dart';
import 'core/cache/cache_module.dart';
import 'core/color/app_color_palette.dart';
import 'core/flavor/flavor_config.dart';
import 'core/network/network_client.dart';
import 'core/network/network_config.dart';
import 'core/settings/app_settings.dart' as core_settings;
import 'core/theme/app_theme.dart';
import 'core/typography/app_typography.dart';
import 'features/location/data/datasources/device_location_data_source.dart';
import 'features/location/data/datasources/open_meteo_location_data_source.dart';
import 'features/location/data/repositories/location_repository_impl.dart';
import 'features/location/domain/usecases/get_current_position_use_case.dart';
import 'features/location/domain/usecases/search_city_use_case.dart';
import 'features/location/presentation/providers/location_provider.dart';
import 'features/settings/data/datasources/shared_prefs_settings_data_source.dart';
import 'features/settings/data/repositories/settings_repository_impl.dart';
import 'features/settings/domain/usecases/get_settings_use_case.dart';
import 'features/settings/domain/usecases/update_language_use_case.dart';
import 'features/settings/domain/usecases/update_temperature_unit_use_case.dart';
import 'features/settings/domain/usecases/update_theme_use_case.dart';
import 'features/settings/presentation/providers/settings_provider.dart';
import 'features/weather/data/datasources/open_meteo_weather_data_source.dart';
import 'features/weather/data/repositories/weather_repository_impl.dart';
import 'features/weather/domain/usecases/get_full_weather_use_case.dart';
import 'features/weather/presentation/providers/weather_provider.dart';

class LajvardApp extends ConsumerStatefulWidget {
  const LajvardApp({super.key});

  @override
  ConsumerState<LajvardApp> createState() => _LajvardAppState();
}

class _LajvardAppState extends ConsumerState<LajvardApp> {
  late final AppTheme _appTheme;

  @override
  void initState() {
    super.initState();
    const colors = LajvardColors();
    const typography = LajvardTypography();
    _appTheme = const AppTheme(colors: colors, typography: typography);
  }

  @override
  Widget build(BuildContext context) {
    // [DEV] — Watch settings to react to theme and language changes instantly.
    final settingsAsync = ref.watch(settingsProvider);

    // [DEV] — Default fallbacks in case settings haven't loaded yet.
    const themeMode = ThemeMode.system;
    final locale = FlavorConfig.instance.defaultLocale;
    final isRtl = locale.languageCode == 'fa';

    if (settingsAsync.value case core_settings.AppSettings settings) {
      final mappedMode = switch (settings.themeMode) {
        core_settings.AppThemeMode.light => ThemeMode.light,
        core_settings.AppThemeMode.dark => ThemeMode.dark,
        core_settings.AppThemeMode.system => ThemeMode.system,
      };

      final currentLocale = Locale(settings.languageCode);
      final currentIsRtl = currentLocale.languageCode == 'fa';

      return _buildMaterialApp(mappedMode, currentLocale, currentIsRtl);
    }

    return _buildMaterialApp(themeMode, locale, isRtl);
  }

  MaterialApp _buildMaterialApp(ThemeMode mode, Locale locale, bool isRtl) {
    return MaterialApp.router(
      title: FlavorConfig.instance.appName,
      debugShowCheckedModeBanner: false,
      theme: _appTheme.light,
      darkTheme: _appTheme.dark,
      themeMode: mode,
      locale: locale,
      supportedLocales: const [Locale('en'), Locale('fa')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      builder: (context, child) {
        return Directionality(
          textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
          child: child ?? const SizedBox.shrink(),
        );
      },
      routerConfig: ref.read(appRouterProvider),
    );
  }
}

// ══════════════════════════════════════════════════════════════════
// [DEV] — Dependency Injection via Riverpod Overrides
// ══════════════════════════════════════════════════════════════════

final _networkClientProvider = Provider<NetworkClient>((ref) {
  return NetworkClient(config: const NetworkConfig());
});

final _weatherDataSourceProvider = Provider<OpenMeteoWeatherDataSource>((ref) {
  return OpenMeteoWeatherDataSource(
      networkClient: ref.read(_networkClientProvider));
});

final _weatherRepoProvider = Provider<WeatherRepositoryImpl>((ref) {
  return WeatherRepositoryImpl(
      remoteDataSource: ref.read(_weatherDataSourceProvider));
});

final _locationDataSourceProvider =
    Provider<OpenMeteoLocationDataSource>((ref) {
  return OpenMeteoLocationDataSource(
      networkClient: ref.read(_networkClientProvider));
});

final _deviceLocationDataSourceProvider =
    Provider<DeviceLocationDataSource>((ref) {
  return DeviceLocationDataSource();
});

final _locationRepoProvider = Provider<LocationRepositoryImpl>((ref) {
  return LocationRepositoryImpl(
    deviceDataSource: ref.read(_deviceLocationDataSourceProvider),
    remoteDataSource: ref.read(_locationDataSourceProvider),
  );
});

final _settingsDataSourceProvider =
    Provider<SharedPrefsSettingsDataSource>((ref) {
  return SharedPrefsSettingsDataSource(cache: CacheModule.instance);
});

final _settingsRepoProvider = Provider<SettingsRepositoryImpl>((ref) {
  return SettingsRepositoryImpl(
      localDataSource: ref.read(_settingsDataSourceProvider));
});

/// [DEV] — Override map for ProviderScope in main.dart.
final providerOverrides = [
  // Weather
  getFullWeatherUseCaseProvider.overrideWith((ref) {
    return GetFullWeatherUseCase(ref.read(_weatherRepoProvider));
  }),

  // Location
  getCurrentPositionUseCaseProvider.overrideWith((ref) {
    return GetCurrentPositionUseCase(ref.read(_locationRepoProvider));
  }),
  searchCityUseCaseProvider.overrideWith((ref) {
    return SearchCityUseCase(ref.read(_locationRepoProvider));
  }),

  // Settings
  getSettingsUseCaseProvider.overrideWith((ref) {
    return GetSettingsUseCase(ref.read(_settingsRepoProvider));
  }),
  updateTemperatureUnitUseCaseProvider.overrideWith((ref) {
    return UpdateTemperatureUnitUseCase(ref.read(_settingsRepoProvider));
  }),
  updateLanguageUseCaseProvider.overrideWith((ref) {
    return UpdateLanguageUseCase(ref.read(_settingsRepoProvider));
  }),
  updateThemeUseCaseProvider.overrideWith((ref) {
    return UpdateThemeUseCase(ref.read(_settingsRepoProvider));
  }),
];
