// [OWNER] — Unit test for Jalali date conversion.
// [DEV] — Tests known date conversions: Jalali ↔ Gregorian round-trip.

import 'package:flutter_test/flutter_test.dart';
import 'package:lajvard/core/localization/jalali_date_utility.dart';

void main() {
  group('JalaliDateUtility', () {
    test('should convert Gregorian 2025-07-05 to correct Jalali date', () {
      final gregorian = DateTime(2025, 7, 5);
      final jalali = JalaliDateUtility.gregorianToJalali(gregorian);

      // [DEV] — 2025-07-05 is known to be 1404/04/14 in Jalali
      expect(jalali.year, 1404);
      expect(jalali.month, 4);
      expect(jalali.day, 14);
    });

    test('should convert Jalali 1404/01/01 back to correct Gregorian date', () {
      // [DEV] — 1404/01/01 (Farvardin 1) corresponds to March 21, 2025
      final gregorian = JalaliDateUtility.jalaliToGregorian(1404, 1, 1);

      expect(gregorian.year, 2025);
      expect(gregorian.month, 3);
      expect(gregorian.day, 21);
    });

    test('should handle round-trip conversion accurately', () {
      final originalGregorian = DateTime(1990, 8, 12);

      final jalali = JalaliDateUtility.gregorianToJalali(originalGregorian);
      final resultGregorian = JalaliDateUtility.jalaliToGregorian(
        jalali.year,
        jalali.month,
        jalali.day,
      );

      expect(resultGregorian.year, originalGregorian.year);
      expect(resultGregorian.month, originalGregorian.month);
      expect(resultGregorian.day, originalGregorian.day);
    });

    test('formatJalali should include day name by default', () {
      final date = DateTime(2025, 7, 5); // Saturday
      final formatted = JalaliDateUtility.formatJalali(date);

      expect(formatted, contains('شنبه')); // Saturday in Persian
      expect(formatted, contains('تیر')); // Tir (month 4)
    });

    test('formatJalali should exclude day name when flag is false', () {
      final date = DateTime(2025, 7, 5);
      final formatted =
          JalaliDateUtility.formatJalali(date, includeDayName: false);

      expect(formatted, isNot(contains('شنبه')));
      expect(formatted, contains('تیر'));
    });
  });
}
