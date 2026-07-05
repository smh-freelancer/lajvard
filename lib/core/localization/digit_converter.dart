// [OWNER] — Digit conversion utility. Converts between Western and Persian digits.
// [OWNER] — Used throughout the app to display numbers in the correct script.
// [DEV] — Strategy pattern: the conversion strategy is determined by the locale.
// [DEV] — Fully standalone: copy this file, import, call `DigitConverter(locale: ...)`.

import 'package:flutter/material.dart';

/// [DEV] — Defines the strategy for digit conversion.
abstract class DigitConversionStrategy {
  String convertDigit(String digit);
  String convertString(String input);
  String convertNumber(num value);
}

/// [DEV] — Western digit strategy: keeps digits as-is (0-9).
class WesternDigitStrategy implements DigitConversionStrategy {
  const WesternDigitStrategy();

  @override
  String convertDigit(String digit) => digit;

  @override
  String convertString(String input) => input;

  @override
  String convertNumber(num value) => value.toString();
}

/// [DEV] — Persian digit strategy: converts 0-9 to ۰-۹.
class PersianDigitStrategy implements DigitConversionStrategy {
  static const List<String> _persianDigits = [
    '۰',
    '۱',
    '۲',
    '۳',
    '۴',
    '۵',
    '۶',
    '۷',
    '۸',
    '۹',
  ];

  const PersianDigitStrategy();

  @override
  String convertDigit(String digit) {
    final index = int.tryParse(digit);
    if (index == null || index < 0 || index > 9) return digit;
    return _persianDigits[index];
  }

  @override
  String convertString(String input) {
    final buffer = StringBuffer();
    for (var i = 0; i < input.length; i++) {
      final char = input[i];
      final codeUnit = char.codeUnitAt(0);
      // [DEV] — Check if character is a Western digit (0x30 to 0x39).
      if (codeUnit >= 0x30 && codeUnit <= 0x39) {
        buffer.write(_persianDigits[codeUnit - 0x30]);
      } else {
        buffer.write(char);
      }
    }
    return buffer.toString();
  }

  @override
  String convertNumber(num value) {
    return convertString(value.toString());
  }
}

/// [DEV] — Digit converter. Uses the Strategy pattern to switch between
/// [DEV] — Western and Persian digit conversion based on locale.
class DigitConverter {
  final DigitConversionStrategy _strategy;

  /// [DEV] — Creates a converter for the given locale.
  /// [DEV] — 'fa' → Persian digits, everything else → Western digits.
  DigitConverter({required Locale locale})
      : _strategy = locale.languageCode == 'fa'
            ? const PersianDigitStrategy()
            : const WesternDigitStrategy();

  /// [DEV] — Create with an explicit strategy (for testing or custom use).
  DigitConverter.withStrategy(this._strategy);

  /// [DEV] — Convert all digits in a string.
  String convert(String input) => _strategy.convertString(input);

  /// [DEV] — Convert a number to a locale-appropriate string.
  String convertNumber(num value) => _strategy.convertNumber(value);

  /// [DEV] — Convert a single digit character.
  String convertDigit(String digit) => _strategy.convertDigit(digit);
}
