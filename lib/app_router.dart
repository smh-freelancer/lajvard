// [OWNER] — GoRouter configuration.
// [OWNER] — Defines all app routes and navigation guards.
// [DEV] — Fixed: Restored pop/back functionality for Settings and Search screens.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'core/connectivity/connectivity_observer.dart';
import 'features/location/presentation/screens/location_search_screen.dart';
import 'features/settings/presentation/screens/settings_screen.dart';
import 'features/weather/presentation/screens/weather_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final connectivityObserver = ConnectivityObserver();
  connectivityObserver.startMonitoring();

  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: false,
    routes: [
      GoRoute(
        path: '/',
        name: 'weather',
        builder: (context, state) => const WeatherScreen(),
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
