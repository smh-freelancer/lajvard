// [OWNER] — Ad placeholder module.
// [OWNER] — Currently does nothing. Prepared for Google Ads + Iranian networks (Adad, Tapsell).
// [DEV] — Interface-based. Swap implementation per flavor without changing UI code.
// [DEV] — Fully standalone: copy this file, implement AdNetworkInterface.

import 'package:flutter/material.dart';

/// [DEV] — Abstract interface for any ad network.
/// [DEV] — Future implementations will override these methods.
abstract class AdNetworkInterface {
  /// [DEV] — Initialize the ad network SDK with a given app ID.
  Future<void> initialize(String appId);

  /// [DEV] — Load a banner ad into a container widget.
  /// [DEV] — Returns a placeholder widget for now.
  Widget getBannerAdWidget({required String placementId, double? height});

  /// [DEV] — Show an interstitial ad.
  Future<void> showInterstitialAd({required String placementId});

  /// [DEV] — Dispose of ad resources.
  void dispose();
}

/// [DEV] — Placeholder implementation that returns empty containers.
/// [DEV] — This ensures the app compiles and runs without ad SDKs.
class PlaceholderAdModule implements AdNetworkInterface {
  PlaceholderAdModule._();
  static final PlaceholderAdModule instance = PlaceholderAdModule._();

  @override
  Future<void> initialize(String appId) async {
    // [OWNER] — No-op in Phase 1. Will initialize real SDK here in future.
  }

  @override
  Widget getBannerAdWidget({required String placementId, double? height}) {
    // [DEV] — Returns an empty SizedBox so layouts don't break.
    return const SizedBox.shrink();
  }

  @override
  Future<void> showInterstitialAd({required String placementId}) async {
    // [OWNER] — No-op in Phase 1.
  }

  @override
  void dispose() {
    // [OWNER] — No-op in Phase 1.
  }
}
