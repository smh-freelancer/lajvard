// [OWNER] — Global flavor strategy implementation.
// [OWNER] — App name: lajvard, Default locale: en, Google Ads.
// [DEV] — Replace placeholder IDs with real Google AdMob IDs in future.

import 'flavor_strategy.dart';

class GlobalFlavor implements FlavorStrategy {
  @override
  String get flavorName => 'global';

  @override
  String get appName => 'lajvard';

  @override
  String get defaultLocale => 'en';

  @override
  AdNetworkConfig get adConfig => const AdNetworkConfig(
        // [OWNER] — Placeholder IDs for Google AdMob
        bannerAdId: 'GLOBAL_BANNER_PLACEHOLDER',
        interstitialAdId: 'GLOBAL_INTERSTITIAL_PLACEHOLDER',
        nativeAdId: 'GLOBAL_NATIVE_PLACEHOLDER',
      );

  @override
  AnalyticsConfig get analyticsConfig => const AnalyticsConfig(
        endpoint: 'https://analytics.lajvard.ir/global',
        trackingId: 'GLOBAL_TRACKING_PLACEHOLDER',
      );

  @override
  String get storeIdentifier => 'com.lajvard.app';
}
