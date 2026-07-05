// [OWNER] — Flavor configuration module.
// [OWNER] — Holds the active flavor (Iran or Global) for the entire app.
// [DEV] — Singleton pattern. Set once at startup in main_iran.dart or main_global.dart.
// [DEV] — Fully standalone: copy the flavor/ folder to reuse in any app.

import 'package:flutter/material.dart';
import 'flavor_strategy.dart';

class FlavorConfig {
  FlavorConfig._();
  static final FlavorConfig instance = FlavorConfig._();

  FlavorStrategy? _activeFlavor;

  /// [DEV] — The currently active flavor strategy.
  FlavorStrategy get flavor {
    if (_activeFlavor == null) {
      throw StateError(
        'FlavorConfig not initialized. Call FlavorConfig.instance.initialize() in main().',
      );
    }
    return _activeFlavor!;
  }

  /// [DEV] — Must be called exactly once in main() before runApp().
  void initialize(FlavorStrategy strategy) {
    if (_activeFlavor != null) {
      throw StateError('FlavorConfig already initialized.');
    }
    _activeFlavor = strategy;
  }

  /// [DEV] — Resolves the default Locale from the active flavor.
  Locale get defaultLocale => Locale(flavor.defaultLocale);

  /// [DEV] — Convenience getter for the app title.
  String get appName => flavor.appName;
}
