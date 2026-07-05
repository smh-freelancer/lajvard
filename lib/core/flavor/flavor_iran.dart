// [OWNER] — Iran flavor strategy implementation.
// [OWNER] — App name: لاژورد, Default locale: fa, Iranian ad networks.
// [DEV] — Replace placeholder IDs with real Cafe Bazaar/Myket ad IDs in future.

import 'flavor_strategy.dart';

class IranFlavor implements FlavorStrategy {
  @override
  String get flavorName => 'iran';

  @override
  String get appName => 'لاژورد';

  @override
  String get defaultLocale => 'fa';

  @override
  AdNetworkConfig get adConfig => const AdNetworkConfig(
        // [OWNER] — Placeholder IDs for Iranian ad networks (e.g., Tapsell, Adad)
        bannerAdId: 'IRAN_BANNER_PLACEHOLDER',
        interstitialAdId: 'IRAN_INTERSTITIAL_PLACEHOLDER',
        nativeAdId: 'IRAN_NATIVE_PLACEHOLDER',
      );

  @override
  AnalyticsConfig get analyticsConfig => const AnalyticsConfig(
        endpoint: 'https://analytics.lajvard.ir/iran',
        trackingId: 'IRAN_TRACKING_PLACEHOLDER',
      );

  @override
  String get storeIdentifier => 'ir.lajvard.app';
}
