// [OWNER] — Typography module. Manages all text styles used in the app.
// [OWNER] — Uses the system default font family with Persian support.
// [DEV] — Fully standalone: copy this file, import it, call `LajvardTypography()`.

import 'package:flutter/material.dart';

/// [DEV] — Immutable typography configuration.
class LajvardTypography {
  // [DEV] — Using system default to prevent missing font crashes.
  // [OWNER] — To use a custom font, place .ttf files in assets/fonts/,
  // [OWNER] — update pubspec.yaml, and change this string to your font family name.
  final String fontFamily;

  // const LajvardTypography({this.fontFamily = 'Roboto'});
  const LajvardTypography({this.fontFamily = 'IRANSansMobile'});

  /// [DEV] — Generates a complete Flutter TextTheme from this configuration.
  TextTheme toTextTheme({Color? color}) {
    return TextTheme(
      displayLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 57.0,
        fontWeight: FontWeight.w400,
        color: color,
        height: 1.12,
      ),
      displayMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: 45.0,
        fontWeight: FontWeight.w400,
        color: color,
        height: 1.16,
      ),
      displaySmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: 36.0,
        fontWeight: FontWeight.w400,
        color: color,
        height: 1.22,
      ),
      headlineLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 32.0,
        fontWeight: FontWeight.w600,
        color: color,
        height: 1.25,
      ),
      headlineMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: 28.0,
        fontWeight: FontWeight.w600,
        color: color,
        height: 1.29,
      ),
      headlineSmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: 24.0,
        fontWeight: FontWeight.w600,
        color: color,
        height: 1.33,
      ),
      titleLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 22.0,
        fontWeight: FontWeight.w500,
        color: color,
        height: 1.27,
      ),
      titleMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: 16.0,
        fontWeight: FontWeight.w500,
        color: color,
        height: 1.50,
      ),
      titleSmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
        color: color,
        height: 1.43,
      ),
      bodyLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 16.0,
        fontWeight: FontWeight.w400,
        color: color,
        height: 1.50,
      ),
      bodyMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
        color: color,
        height: 1.43,
      ),
      bodySmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: 12.0,
        fontWeight: FontWeight.w400,
        color: color,
        height: 1.33,
      ),
      labelLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
        color: color,
        height: 1.43,
      ),
      labelMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: 12.0,
        fontWeight: FontWeight.w500,
        color: color,
        height: 1.33,
      ),
      labelSmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: 11.0,
        fontWeight: FontWeight.w500,
        color: color,
        height: 1.27,
      ),
    );
  }

  LajvardTypography copyWith({
    String? fontFamily,
  }) {
    return LajvardTypography(
      fontFamily: fontFamily ?? this.fontFamily,
    );
  }
}
