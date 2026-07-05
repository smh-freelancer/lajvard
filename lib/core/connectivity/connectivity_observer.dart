// [OWNER] — Connectivity observer module. Watches for network on/off events.
// [OWNER] — Emits a stream of ConnectivityState for the app to react to.
// [DEV] — Observer pattern. Uses connectivity_plus to listen to OS-level events.
// [DEV] — Fully standalone: copy this file + connectivity_state.dart.

import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../error/logger.dart';
import 'connectivity_state.dart';

class ConnectivityObserver {
  final Connectivity _connectivity;

  // [DEV] — Accept an instance for testability, default to the real one.
  ConnectivityObserver({Connectivity? connectivity})
      : _connectivity = connectivity ?? Connectivity();

  /// [DEV] — Stream controller for broadcasting connectivity changes to the app.
  final StreamController<ConnectivityState> _controller =
      StreamController<ConnectivityState>.broadcast();

  /// [DEV] — Public stream for UI/providers to listen to.
  Stream<ConnectivityState> get onConnectivityChanged => _controller.stream;

  /// [DEV] — The last known state.
  ConnectivityState _lastState = const ConnectivityState();
  ConnectivityState get lastState => _lastState;

  StreamSubscription<List<ConnectivityResult>>? _subscription;

  /// [DEV] — Starts listening to native connectivity events.
  Future<void> startMonitoring() async {
    stopMonitoring();

    // [DEV] — Check the current state immediately on start.
    final initialResult = await _connectivity.checkConnectivity();
    _lastState = ConnectivityState.fromResult(initialResult);
    _controller.add(_lastState);

    // [DEV] — Listen to ongoing changes.
    _subscription = _connectivity.onConnectivityChanged.listen(
      (List<ConnectivityResult> result) {
        final newState = ConnectivityState.fromResult(result);

        // [DEV] — Only emit if the actual online/offline status changed.
        if (newState.status != _lastState.status) {
          _lastState = newState;
          _controller.add(_lastState);

          AppLogger.instance.info(
            'Connectivity changed: ${_lastState.isOnline ? "ONLINE" : "OFFLINE"}',
            name: 'Connectivity',
          );
        }
      },
      onError: (Object error) {
        AppLogger.instance.error(
          'Connectivity stream error',
          name: 'Connectivity',
          error: error,
        );
      },
    );

    AppLogger.instance
        .info('Connectivity monitoring started', name: 'Connectivity');
  }

  /// [DEV] — Stops listening and closes the stream.
  void stopMonitoring() {
    _subscription?.cancel();
    _subscription = null;
  }

  /// [DEV] — Manual one-time check (e.g., before a critical API call).
  Future<bool> checkNow() async {
    final result = await _connectivity.checkConnectivity();
    _lastState = ConnectivityState.fromResult(result);
    return _lastState.isOnline;
  }

  /// [DEV] — Clean up resources.
  void dispose() {
    stopMonitoring();
    _controller.close();
  }
}
