// [OWNER] — GoRouter configuration.
// [OWNER] — Defines all app routes and navigation guards.
// [DEV] — Fixed: Added AppBar with back button to settings route.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'core/connectivity/connectivity_observer.dart';
import 'features/weather/presentation/screens/weather_screen.dart';
import 'features/settings/presentation/screens/settings_screen.dart';
import 'features/location/presentation/screens/location_search_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final connectivityObserver = ConnectivityObserver();
  connectivityObserver.startMonitoring();

  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: '/',
        name: 'weather',
        builder: (context, state) {
          final extra = state.extra;
          return WeatherScreen(key: ValueKey(extra));
        },
      ),
      GoRoute(
        path: '/settings',
        name: 'settings',
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: '/location-search',
        name: 'locationSearch',
        builder: (context, state) => const LocationSearchScreen(),
      ),
    ],
  );
});
