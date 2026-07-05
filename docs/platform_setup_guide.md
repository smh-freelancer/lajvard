Full, detailed, copy-paste ready guide for Android and iOS native configuration.

# ⚙️ lajvard — Android & iOS Platform Configuration Guide

This document contains all required native-side configurations for the lajvard
project. Follow these steps exactly to ensure the app builds correctly for
both Android (Cafe Bazaar/Google Play) and iOS (App Store).

---

## 📖 Table of Contents

- [Android Setup](#--android-setup)
- [iOS Setup](#--ios-setup)

---

## 🤖 Android Setup

### 1. Minimum SDK & Compile SDK

Open `android/app/build.gradle.kts` (or `build.gradle`) and ensure these match
the Flutter 3.44.x requirements:

```kotlin
android {
    namespace = "ir.lajvard.app"
    compileSdk = 35 // [DEV] — Use latest stable Android compile SDK

    defaultConfig {
        applicationId = "ir.lajvard.app" // [DEV] — Change to com.lajvard.app for Global flavor
        minSdk = 23 // [DEV] — Android 6.0 (Marshmallow) per Rule 5
        targetSdk = 35 // [DEV] — Use latest stable Android target SDK
        versionCode = flutterVersionCode.toInteger()
        versionName = flutterVersionName
    }
}
```

2. Internet Permission (Required for Open-Meteo)
   Open android/app/src/main/AndroidManifest.xml and add the internet permission
   inside the <manifest> tag:

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android">

    <!-- [OWNER] — Required to fetch weather data from Open-Meteo API -->
    <uses-permission android:name="android.permission.INTERNET" />

    <!-- [OWNER] — Required to check network state (connectivity_plus) -->
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />

    <application
        android:label="لاژورد"
        android:name="${applicationName}"
        android:icon="@mipmap/ic_launcher">
        <activity
            android:name=".MainActivity"
            android:exported="true"
            android:launchMode="singleTop"
            android:theme="@style/LaunchTheme"
            android:configChanges="orientation|keyboardHidden|keyboard|screenSize|smallestScreenSize|locale|layoutDirection|fontScale|screenLayout|density|uiMode"
            android:hardwareAccelerated="true"
            android:windowSoftInputMode="adjustResize">
            <!-- Specifies an Android theme to apply to this Activity as soon as
                 the Android process has started. This theme is visible to the user
                 while the Flutter UI initializes. After that, this theme continues
                 to determine the Window background behind the Flutter UI. -->
            <meta-data
              android:name="io.flutter.embedding.android.NormalTheme"
              android:resource="@style/NormalTheme"
              />
            <intent-filter>
                <action android:name="android.intent.action.MAIN"/>
                <category android:name="android.intent.category.LAUNCHER"/>
            </intent-filter>
        </activity>
        <!-- Don't delete the meta-data below.
             This is used by the Flutter tool to generate GeneratedPluginRegistrant.java -->
        <meta-data
            android:name="flutterEmbedding"
            android:value="2" />
    </application>
</manifest>
```

3. Location Permissions (Required for GPS)
   Add these permissions inside the <manifest> tag, above <application>:

```xml
    <!-- [OWNER] — Required for Geolocator to get device GPS location -->
    <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
    <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
```

4. Splash Screen & Status Bar Color (Android 12+)
   Android 12+ natively handles splash screens. To match the Lajvard dark navy
   background (#0A1628), open
   android/app/src/main/res/values/styles.xml and update/add these:

```xml
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <!-- Theme applied to the Android Window while the process is starting when the OS's Dark Mode is set on the device. -->
    <style name="LaunchTheme" parent="@android:style/Theme.Black.NoTitleBar">
        <!-- Show a splash screen on the activity. Automatically removed when
             Flutter draws its first frame -->
        <item name="android:windowBackground">@android:color/transparent</item>
        <item name="android:windowSplashScreenBackground">#0A1628</item>
        <item name="android:windowSplashScreenAnimatedIcon">@mipmap/ic_launcher</item>
    </style>

    <!-- Theme applied to the Android Window as soon as the process has started.
         This theme determines the color of the status bar and navigation bar. -->
    <style name="NormalTheme" parent="@android:style/Theme.Black.NoTitleBar">
        <item name="android:windowBackground">?android:colorBackground</item>
    </style>
</resources>
```

5. App Icons Generation
   Prepare a 1024x1028 px PNG icon (with safe padding for Android adaptive icons).
   Run the following command in the terminal:

```bash
dart run flutter_launcher_icons:main -t lib/main_iran.dart
```

(Ensure you have flutter_launcher_icons in dev_dependencies or run it
via dart run if added temporarily).

6. Proguard / R8 (For Release Builds)
   If you enable code shrinking (minifyEnabled true in build.gradle), you must
   add rules to prevent Dio and other libraries from breaking. Open
   android/app/proguard-rules.pro and add:

```proguard
# Dio
-dontwarn okio.**
-dontwarn com.squareup.okhttp.**
-keep class com.squareup.okhttp.** { *; }
-keep interface com.squareup.okhttp.** { *; }

# Flutter Wrapper
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }
```

🍏 iOS Setup

1. Minimum Deployment Target
   Open ios/Runner.xcworkspace in Xcode.

Click on the Runner project in the left navigator.
Select the Runner target.
Go to the General tab.
Under Minimum Deployments, set iOS to 14.0 (per Rule 5). 2. Location Permissions
In Xcode, open ios/Runner/Info.plist.
Add the following keys inside the <dict> tag to explain to the user why
you need location (Apple rejects apps without these):

```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>We need your location to show accurate local weather data.</string>
<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
<string>We need your location to show accurate local weather data.</string>
```

3. App Transport Security (ATS)
   Open-Meteo uses HTTPS, so you technically don't need to bypass ATS. However,
   if you add any non-HTTPS analytics endpoints in the flavor config, you might
   need to allow arbitrary loads in ios/Runner/Info.plist:

```xml
<key>NSAppTransportSecurity</key>
<dict>
  <key>NSAllowsArbitraryLoads</key>
  <false/>
  <key>NSExceptionDomains</key>
  <dict>
    <key>api.open-meteo.com</key>
    <dict>
      <key>NSExceptionAllowsInsecureHTTPLoads</key>
      <false/>
      <key>NSExceptionMinimumTLSVersion</key>
      <string>TLSv1.2</string>
    </dict>
  </dict>
</dict>
```

4. Splash Screen & Status Bar
   Open ios/Runner/Assets.xcassets/LaunchImage.imageset.
   Replace the default images with your branded splash screens for @1x, @2x, @3x.
   To set the dark background color, open ios/Runner/Base.lproj/LaunchScreen.storyboard.
   Select the View Controller, go to the Attributes Inspector, and set the
   Background Color to #0A1628 (or RGB: Red 10, Green 22, Blue 40).
   To hide the status bar on the splash screen (for a seamless look), open
   ios/Runner/Info.plist and add:

```xml
<key>UIStatusBarHidden</key>
<true/>
<key>UIViewControllerBasedStatusBarAppearance</key>
<false/>
```

5. App Icons Generation
   Prepare an App Icon that meets Apple's guidelines (no transparency, specific
   grid sizing). You can use an online tool like AppIconGenerator.
   Generate all sizes (20x20 up to 1024x1024).
   Drag and drop them into ios/Runner/Assets.xcassets/AppIcon.appiconset in Xcode.
6. Localizations (Persian Support)
   Because the app supports Persian (RTL), you must add Farsi to the iOS
   localizations in Xcode:

Select Runner project -> Runner target -> Info tab.
Under Localizations, click +.
Select Persian (fa).
Ensure "Persian" is checked. 7. Bitcode (Disabled for Flutter)
Ensure Bitcode is disabled in Xcode:

Go to Build Settings tab for the Runner target.
Search for "Bitcode".
Set Enable Bitcode to No (Flutter does not support Bitcode).
