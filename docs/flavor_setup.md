🍦 lajvard — Complete Flavor Setup Guide
This document provides step-by-step instructions on how the dual-flavor system (iran and global) works in lajvard, how to run them, and how to customize them.

📖 Table of Contents
Architecture Overview
How to Run Different Flavors
What Changes Between Flavors
Adding a New Flavor
Flavor-Specific Customization

## 1 — Architecture Overview

lajvard uses a Separate Entry Point pattern for flavors instead of complex Gradle/Xcode scheme setups. This keeps the architecture clean and purely in Dart.

lib/main_iran.dart → Entry point for the Iran flavor (لاژورد)
lib/main_global.dart → Entry point for the Global flavor (lajvard)
Both files share the exact same LajvardApp widget and dependency injection tree. The only difference is which FlavorStrategy is passed into FlavorConfig.instance.initialize().

The Strategy Pattern in Action
main_iran.dart calls FlavorConfig.instance.initialize(const IranFlavor())
main_global.dart calls FlavorConfig.instance.initialize(const GlobalFlavor())
The rest of the app reads from FlavorConfig.instance.flavor to get app name, default locale, ad IDs, etc.

## 2 — How to Run Different Flavors

Via Command Line (Terminal)

# Run Iran flavor on connected device/emulatorflutter run -t lib/main_iran.dart# Run Global flavor on connected device/emulatorflutter run -t lib/main_global.dart# Run Iran flavor on a specific deviceflutter run -t lib/main_iran.dart -d <device_id>

Via VS Code
Go to Run and Debug (Ctrl+Shift+D / Cmd+Shift+D).
Click Create a launch.json file -> Flutter.
Modify the program field in

.vscode/launch.json
{
"version": "0.2.0",
"configurations": [
{
"name": "Iran Flavor",
"request": "launch",
"type": "dart",
"program": "lib/main_iran.dart"
},
{
"name": "Global Flavor",
"request": "launch",
"type": "dart",
"program": "lib/main_global.dart"
}
]
}

Select the flavor from the dropdown in the top menu bar and press F5.
Via Android Studio
Go to Run > Edit Configurations.
Click + -> Flutter.
Name it "Iran Flavor".
In the Entry point field, enter lib/main_iran.dart.
Repeat for "Global Flavor" with lib/main_global.dart.
Select the desired configuration from the dropdown and click Run.

## 3 — What Changes Between Flavors

All differences are defined in lib/core/flavor/.

Here is the exact comparison:
| Setting | `IranFlavor` | `GlobalFlavor` |
|---------|---------------|----------------|
| `flavorName` | `'iran'` | `'global'` |
| `appName` | `'لاژورد'` | `'lajvard'` |
| `defaultLocale` | `'fa'` | `'en'` |
| `adConfig.bannerAdId` | `'IRAN_BANNER_PLACEHOLDER'` | `'GLOBAL_BANNER_PLACEHOLDER'` |
| `adConfig.interstitialAdId` | `'IRAN_INTERSTITIAL_PLACEHOLDER'` | `'GLOBAL_INTERSTITIAL_PLACEHOLDER'` |
| `analyticsConfig.endpoint` | `'https://analytics.lajvard.ir/iran'` | `'https://analytics.lajvard.ir/global'` |
| `storeIdentifier` | `'ir.lajvard.app'` | `'com.lajvard.app'` |

## 4 — Adding a New Flavor

If you need to add a third flavor (e.g., china or beta), follow these exact steps:

# Step 4.1: Create the Strategy

Create lib/core/flavor/flavor_china.dart:

```dart
import 'flavor_strategy.dart';

class ChinaFlavor implements FlavorStrategy {
  @override
  String get flavorName => 'china';

  @override
  String get appName => 'lajvard CN';

  @override
  String get defaultLocale => 'zh';

  @override
  AdNetworkConfig get adConfig => const AdNetworkConfig(
    bannerAdId: 'CHINA_BANNER_ID',
    interstitialAdId: 'CHINA_INTERSTITIAL_ID',
    nativeAdId: 'CHINA_NATIVE_ID',
  );

  @override
  AnalyticsConfig get analyticsConfig => const AnalyticsConfig(
    endpoint: 'https://analytics.lajvard.ir/china',
    trackingId: 'CHINA_TRACKING_ID',
  );

  @override
  String get storeIdentifier => 'com.lajvard.cn';
}
```

# Step 4.2: Create the Entry Point

Create lib/main_china.dart:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app.dart';
import 'core/cache/cache_module.dart';
import 'core/error/logger.dart';
import 'core/flavor/flavor_config.dart';
import 'core/flavor/flavor_china.dart'; // Import the new strategy

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppLogger.instance.setDebugMode(kDebugMode);

  // 1. Initialize the new flavor
  FlavorConfig.instance.initialize(const ChinaFlavor());

  // 2. Initialize Cache
  await CacheModule.instance.init();

  // 3. Run App
  runApp(
    ProviderScope(
      overrides: providerOverrides,
      child: const LajvardApp(),
    ),
  );
}
```

# Step 4.3: Run the New Flavor

```bash
flutter run -t lib/main_china.dart
```

## 5 — Flavor-Specific Customization

How to Change Ad Network IDs
When you are ready to integrate real ads, open the corresponding flavor file
(e.g., flavor_iran.dart) and replace the placeholder strings:

```dart
@override
AdNetworkConfig get adConfig => const AdNetworkConfig(
  bannerAdId: 'ca-app-pub-XXXXX/YYYYY', // Replace with real ID
  interstitialAdId: 'ca-app-pub-XXXXX/ZZZZ', // Replace with real ID
  nativeAdId: 'ca-app-pub-XXXXX/WWWW', // Replace with real ID
);
```

How to Change the Default Locale
If you want the Global flavor to default to Spanish instead of English:

```dart
// In lib/core/flavor/flavor_global.dart
@override
String get defaultLocale => 'es';
```

(Note: You must also add the es ARB files and add Locale('es') to the
supportedLocales list in lib/app.dart)

How to Access Flavor Info Anywhere in the App
Because FlavorConfig is a Singleton, you can access the current flavor's
data from anywhere—UI, data layer, or domain layer:

```dart
import 'package:lajvard/core/flavor/flavor_config.dart';

final name = FlavorConfig.instance.appName;
final isIran = FlavorConfig.instance.flavor.flavorName == 'iran';
```
