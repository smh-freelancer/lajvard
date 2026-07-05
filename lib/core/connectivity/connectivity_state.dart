// [OWNER] — Connectivity state representation.
// [OWNER] — Describes the current network connection status.
// [DEV] — Maps the native OS connectivity results to our clean, app-level enum.
// [DEV] — Fully standalone from the rest of the app, but wraps connectivity_plus.

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

/// [DEV] — Simplified connectivity states used by the app.
enum ConnectivityStatus {
  online,
  offline,
  unknown,
}

/// [DEV] — Immutable connectivity state data.
@immutable
class ConnectivityState {
  final ConnectivityStatus status;
  final String? connectionType;

  const ConnectivityState({
    this.status = ConnectivityStatus.unknown,
    this.connectionType,
  });

  /// [DEV] — Convenience getter.
  bool get isOnline => status == ConnectivityStatus.online;
  bool get isOffline => status == ConnectivityStatus.offline;

  /// [DEV] — Factory to map the native connectivity_plus result to our state.
  /// [DEV] — Handles modern multi-connection types (e.g., Wi-Fi AND Cellular simultaneously).
  factory ConnectivityState.fromResult(List<ConnectivityResult> result) {
    if (result.isEmpty || result.contains(ConnectivityResult.none)) {
      return const ConnectivityState(status: ConnectivityStatus.offline);
    }

    // [DEV] — Get the primary active connection type for display purposes.
    final primaryType = result.firstWhere(
      (type) => type != ConnectivityResult.none,
      orElse: () => ConnectivityResult.none,
    );

    return ConnectivityState(
      status: ConnectivityStatus.online,
      connectionType: primaryType.name,
    );
  }

  /// [DEV] — Creates a copy with optional overrides.
  ConnectivityState copyWith({
    ConnectivityStatus? status,
    String? connectionType,
  }) {
    return ConnectivityState(
      status: status ?? this.status,
      connectionType: connectionType ?? this.connectionType,
    );
  }
}
