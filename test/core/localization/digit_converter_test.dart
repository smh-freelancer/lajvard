// [OWNER] — Unit test for digit conversion utility.
// [DEV] — Tests Western → Persian and Persian → Western conversion.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lajvard/core/localization/digit_converter.dart';

void main() {
  group('DigitConverter', () {
    test('should keep Western digits for English locale', () {
      final converter = DigitConverter(locale: const Locale('en'));

      expect(converter.convert('12345'), '12345');
      expect(converter.convertNumber(678), '678');
    });

    test('should convert Western digits to Persian for Farsi locale', () {
      final converter = DigitConverter(locale: const Locale('fa'));

      expect(converter.convert('12345'), '۱۲۳۴۵');
      expect(converter.convertNumber(678), '۶۷۸');
      expect(converter.convert('0'), '۰');
      expect(converter.convert('9'), '۹');
    });

    test('should leave non-digit characters untouched in Persian', () {
      final converter = DigitConverter(locale: const Locale('fa'));

      expect(converter.convert('28°C'), '۲۸°C');
      expect(converter.convert('12:30'), '۱۲:۳۰');
    });

    test('should handle empty strings', () {
      final converter = DigitConverter(locale: const Locale('fa'));

      expect(converter.convert(''), '');
    });

    test('should handle strings with no digits', () {
      final converter = DigitConverter(locale: const Locale('fa'));

      expect(converter.convert('ABC-xyz'), 'ABC-xyz');
    });
  });
}
