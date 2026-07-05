// [OWNER] — Flavor strategy interface.
// [OWNER] — Defines what changes between the Iran and Global versions of the app.
// [DEV] — Strategy pattern: swap flavor strategy at app startup.
// [DEV] — Fully standalone: copy the flavor/ folder to reuse in any app.

import 'package:flutter/material.dart';

/// [DEV] — Ad network configuration specific to a flavor.
@immutable
class AdNetworkConfig {
  final String bannerAdId;
  final String interstitialAdId;
  final String nativeAdId;

  const AdNetworkConfig({
    this.bannerAdId = '',
    this.interstitialAdId = '',
    this.nativeAdId = '',
  });
}

/// [DEV] — Analytics configuration specific to a flavor.
@immutable
class AnalyticsConfig {
  final String endpoint;
  final String trackingId;

  const AnalyticsConfig({
    this.endpoint = '',
    this.trackingId = '',
  });
}

/// [DEV] — Abstract strategy defining flavor-specific behavior and metadata.
abstract class FlavorStrategy {
  /// [DEV] — Unique identifier for this flavor.
  String get flavorName;

  /// [DEV] — Display name of the app (e.g., "لاژورد" vs "lajvard").
  String get appName;

  /// [DEV] — Default locale when user opens app for the first time.
  String get defaultLocale;

  /// [DEV] — Ad network IDs and configuration.
  AdNetworkConfig get adConfig;

  /// [DEV] — Analytics endpoint and tracking ID.
  AnalyticsConfig get analyticsConfig;

  /// [DEV] — Target app store identifier (e.g., com.lajvard.app).
  String get storeIdentifier;
}
