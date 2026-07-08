// [OWNER] — Location Riverpod provider.
// [OWNER] — Handles fetching device GPS location and searching for cities.
// [DEV] — Uses AsyncNotifier for search, Provider for device location.

import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/location_entity.dart';
import '../../domain/usecases/get_current_position_use_case.dart';
import '../../domain/usecases/search_city_use_case.dart';

/// [DEV] — Provider for location use cases. Overridden in STEP 8.
final getCurrentPositionUseCaseProvider =
    Provider<GetCurrentPositionUseCase>((ref) {
  throw UnimplementedError('Must be overridden in app assembly.');
});

final searchCityUseCaseProvider = Provider<SearchCityUseCase>((ref) {
  throw UnimplementedError('Must be overridden in app assembly.');
});

/// [DEV] — Notifier for handling city search with debouncing.
// class CitySearchNotifier extends Notifier<List<LocationEntity>> {
class CitySearchNotifier extends AsyncNotifier<List<LocationEntity>> {
  Timer? _debounce;
  int _requestId = 0; // prevents stale results overriding latest query

  @override
  FutureOr<List<LocationEntity>> build() {
    ref.onDispose(() => _debounce?.cancel());
    return const [];
  }

  // @override
  // List<LocationEntity> build() {
  //   // [DEV] — Clean up timer when provider is disposed.
  //   ref.onDispose(() => _debounce?.cancel());
  //   return [];
  // }
  void onQueryChanged(String query) {
    _debounce?.cancel();

    final trimmed = query.trim();
    if (trimmed.isEmpty) {
      state = const AsyncData([]);
      return;
    }

    final currentId = ++_requestId;

    // Optional: small delay for debouncing keystrokes
    _debounce = Timer(const Duration(milliseconds: 400), () async {
      state = const AsyncLoading();

      final useCase = ref.read(searchCityUseCaseProvider);
      final result = await useCase.call(trimmed);

      // Ignore stale responses from older queries
      if (currentId != _requestId) return;

      result.when(
        success: (locations) => state = AsyncData(locations),
        failure: (failure) => state = AsyncError(
          Exception(failure.displayMessage),
          StackTrace.current,
        ),
      );
    });
  }
}

final citySearchProvider =
    AsyncNotifierProvider<CitySearchNotifier, List<LocationEntity>>(
  CitySearchNotifier.new,
);
//   /// [DEV] — Updates the search query. Waits 500ms of inactivity before searching.
//   void onQueryChanged(String query) {
//     _debounce?.cancel();

//     if (query.trim().isEmpty) {
//       state = [];
//       return;
//     }

//     _debounce = Timer(const Duration(milliseconds: 500), () async {
//       state = const []; // [DEV] — Show loading state implicitly
//       final useCase = ref.read(searchCityUseCaseProvider);
//       final result = await useCase.call(query);

//       result.when(
//         success: (locations) => state = locations,
//         failure: (_) => state = [],
//       );
//     });
//   }
// }

// final citySearchProvider =
//     NotifierProvider<CitySearchNotifier, List<LocationEntity>>(
//   CitySearchNotifier.new,
// );

/// [DEV] — Async provider to get current device location.
/// [DEV] — Throws a meaningful exception on failure so UI can display details.
final deviceLocationProvider = FutureProvider<LocationEntity>((ref) async {
  final useCase = ref.read(getCurrentPositionUseCaseProvider);
  final result = await useCase.call();

  return result.when(
    success: (location) => location,
    failure: (failure) => throw Exception(failure.displayMessage),
  );
});
