// [OWNER] — Main weather Riverpod provider.
// [OWNER] — Fetches and exposes the full weather data to the UI.
// [DEV] — Uses modern Riverpod 3.x Notifier APIs.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/weather_entity.dart';
import '../../domain/usecases/get_full_weather_use_case.dart';

/// [DEV] — State holder for weather, including the selected location coordinates.
@immutable
class WeatherState {
  final double latitude;
  final double longitude;
  final String cityName;

  const WeatherState({
    required this.latitude,
    required this.longitude,
    this.cityName = 'Current Location',
  });

  WeatherState copyWith({
    double? latitude,
    double? longitude,
    String? cityName,
  }) {
    return WeatherState(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      cityName: cityName ?? this.cityName,
    );
  }
}

/// [DEV] — Notifier for managing the selected location state.
class WeatherLocationNotifier extends Notifier<WeatherState> {
  @override
  WeatherState build() {
    // [DEV] — Default to Tehran coordinates.
    return const WeatherState(
      latitude: 35.6892,
      longitude: 51.3890,
      cityName: 'Tehran',
    );
  }

  void updateLocation(double lat, double lon, String name) {
    state = WeatherState(
      latitude: lat,
      longitude: lon,
      cityName: name,
    );
  }
}

/// [DEV] — Provider for the selected location state using modern Notifier API.
final weatherLocationProvider =
    NotifierProvider<WeatherLocationNotifier, WeatherState>(
  WeatherLocationNotifier.new,
);

/// [DEV] — Provider for the GetFullWeather use case.
final getFullWeatherUseCaseProvider = Provider<GetFullWeatherUseCase>((ref) {
  throw UnimplementedError(
    'GetFullWeatherUseCase must be overridden in app assembly.',
  );
});

/// [DEV] — Main weather data provider.
final weatherProvider = AsyncNotifierProvider<WeatherNotifier, WeatherEntity>(
  WeatherNotifier.new,
);

class WeatherNotifier extends AsyncNotifier<WeatherEntity> {
  @override
  Future<WeatherEntity> build() async {
    final location = ref.watch(weatherLocationProvider);
    final useCase = ref.read(getFullWeatherUseCaseProvider);

    final result = await useCase.call(
      latitude: location.latitude,
      longitude: location.longitude,
    );

    return result.when(
      success: (weather) => weather,
      failure: (failure) => throw _mapFailureToException(failure),
    );
  }

  /// [DEV] — Called manually to refresh data (e.g., pull-to-refresh).
  Future<void> refresh() async {
    ref.invalidateSelf();
  }

  /// [DEV] — Updates location and triggers a refetch.
  Future<void> updateLocation(double lat, double lon, String name) async {
    ref.read(weatherLocationProvider.notifier).updateLocation(lat, lon, name);
  }

  Exception _mapFailureToException(Failure failure) {
    return Exception(failure.displayMessage);
  }
}
