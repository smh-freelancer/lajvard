// [OWNER] — Locale management module. Controls language, text direction, and digit system.
// [OWNER] — When language changes: locale, RTL/LTR, digits, calendar all switch instantly.
// [DEV] — Fully standalone: copy this file + digit_converter.dart + jalali_date_utility.dart.
// [DEV] — Strategy pattern for digit conversion. Builder pattern for locale-aware widgets.

import 'package:flutter/material.dart';
import 'digit_converter.dart';
import 'jalali_date_utility.dart';

/// [DEV] — Supported locales for the app.
class AppLocales {
  static const Locale en = Locale('en');
  static const Locale fa = Locale('fa');

  static const List<Locale> supportedLocales = [en, fa];

  /// [DEV] — Resolves a Locale from a language code string.
  static Locale fromLanguageCode(String code) {
    switch (code) {
      case 'fa':
        return fa;
      case 'en':
      default:
        return en;
    }
  }

  /// [DEV] — Returns true if the locale is RTL (Persian).
  static bool isRtl(Locale locale) {
    return locale.languageCode == 'fa';
  }

  /// [DEV] — Returns the TextDirection for a locale.
  static TextDirection textDirection(Locale locale) {
    return isRtl(locale) ? TextDirection.rtl : TextDirection.ltr;
  }
}

/// [DEV] — Locale service. Manages runtime locale state and provides
/// [DEV] — utility methods for locale-aware formatting.
/// [DEV] — Instantiate with a locale, then use its methods throughout the app.
class LocaleService {
  final Locale locale;
  final DigitConverter _digitConverter;

  // [DEV] — Manual month name arrays to prevent RangeError from ARB generation.
  static const List<String> _monthNamesEn = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  static const List<String> _monthNamesFa = [
    'ژانویه',
    'فوریه',
    'مارس',
    'آوریل',
    'مه',
    'ژوئن',
    'ژوئیه',
    'اوت',
    'سپتامبر',
    'اکتبر',
    'نوامبر',
    'دسامبر',
  ];

  LocaleService({required this.locale})
      : _digitConverter = DigitConverter(locale: locale);

  /// [DEV] — Current locale's language code.
  String get languageCode => locale.languageCode;

  /// [DEV] — Whether current locale is RTL.
  bool get isRtl => AppLocales.isRtl(locale);

  /// [DEV] — Current text direction.
  TextDirection get textDirection => AppLocales.textDirection(locale);

  /// [DEV] — Whether current locale uses Persian digits.
  bool get usePersianDigits => locale.languageCode == 'fa';

  /// [DEV] — Convert digits in a string to the current locale's digit system.
  String convertDigits(String input) {
    return _digitConverter.convert(input);
  }

  /// [DEV] — Convert a number to locale-appropriate string.
  String formatNumber(num value) {
    return _digitConverter.convertNumber(value);
  }

  /// [DEV] — Format a date to locale-appropriate string.
  /// [DEV] — For 'fa': returns Jalali date like "شنبه ۱۴ تیر ۱۴۰۴"
  /// [DEV] — For 'en': returns Gregorian date like "Saturday, July 5, 2025"
  String formatDate(DateTime date, {bool includeDayName = true}) {
    if (locale.languageCode == 'fa') {
      return JalaliDateUtility.formatJalali(
        date,
        includeDayName: includeDayName,
      );
    } else {
      return _formatGregorian(date, includeDayName: includeDayName);
    }
  }

  /// [DEV] — Format a time string (HH:mm) with locale-appropriate digits.
  String formatTime(DateTime date) {
    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');
    return convertDigits('$hour:$minute');
  }

  /// [DEV] — Get localized day name for a DateTime.
  String getDayName(DateTime date) {
    final weekdayNamesFa = [
      'یکشنبه',
      'دوشنبه',
      'سه‌شنبه',
      'چهارشنبه',
      'پنجشنبه',
      'جمعه',
      'شنبه',
    ];
    final weekdayNamesEn = [
      'Sunday',
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
    ];

    // [DEV] — DateTime.weekday: 1=Monday, 7=Sunday. Map to 0=Monday, 6=Sunday.
    final index = date.weekday % 7;

    if (locale.languageCode == 'fa') {
      return weekdayNamesFa[index];
    } else {
      return weekdayNamesEn[index];
    }
  }

  /// [DEV] — Get localized month name for a DateTime (Gregorian months).
  /// [DEV] — Fixed: Uses local safe arrays instead of ARB lookups to prevent RangeError.
  String getMonthName(int month) {
    if (month < 1 || month > 12) return '';

    final names = locale.languageCode == 'fa' ? _monthNamesFa : _monthNamesEn;
    return names[month - 1];
  }

  String _formatGregorian(DateTime date, {bool includeDayName = true}) {
    final dayName = includeDayName ? '${getDayName(date)}, ' : '';
    final month = getMonthName(date.month);
    final day = date.day;
    final year = date.year;
    return '$dayName$month $day, $year';
  }

  /// [DEV] — Create a new LocaleService with a different locale.
  LocaleService copyWith(Locale newLocale) {
    return LocaleService(locale: newLocale);
  }
}

/// [DEV] — Builder widget for locale-aware content.
class LocaleAwareBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, LocaleService localeService)
      builder;

  const LocaleAwareBuilder({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);
    final localeService = LocaleService(locale: locale);
    return builder(context, localeService);
  }
}
