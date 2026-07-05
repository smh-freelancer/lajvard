// [OWNER] — Entry point for the IRAN flavor (لاژورد)
// [OWNER] — Default locale: fa (Persian/Farsi)
// [DEV] — This file is selected via: flutter run -t lib/main_iran.dart --dart-define=FLAVOR=iran

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'core/cache/cache_module.dart';
import 'core/connectivity/connectivity_observer.dart';
import 'core/error/logger.dart';
import 'core/flavor/flavor_config.dart';
import 'core/flavor/flavor_iran.dart';

void main() async {
  // [DEV] — Ensure Flutter bindings are initialized (needed for CacheModule/SharedPreferences)
  WidgetsFlutterBinding.ensureInitialized();

  // [DEV] — 1. Initialize Logger
  AppLogger.instance.setDebugMode(kDebugMode);

  // [DEV] — 2. Initialize Flavor
  FlavorConfig.instance.initialize(IranFlavor());
  AppLogger.instance.info('Starting IRAN flavor (لاژورد)...', name: 'Main');

  // [DEV] — 3. Initialize Cache (Required for Settings)
  await CacheModule.instance.init();

  // [DEV] — 4. Initialize Connectivity Observer
  final connectivity = ConnectivityObserver();
  await connectivity.startMonitoring();
  connectivity
      .dispose(); // [DEV] — App-level router will start its own instance

  // [DEV] — 5. Run App with Dependency Overrides
  runApp(
    ProviderScope(
      overrides: providerOverrides,
      child: const LajvardApp(),
    ),
  );
}
