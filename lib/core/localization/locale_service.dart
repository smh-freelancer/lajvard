// [OWNER] — Locale management module.
// [OWNER] — Switches locale, RTL/LTR, digit system instantly.
// [DEV] — Fixed: Uses correct `formatJalali` method name from PersianDateHelper.

import 'package:flutter/material.dart';
import 'package:lajvard/core/utils/persian_date_helper.dart';
import 'digit_converter.dart';

class AppLocales {
  static const Locale en = Locale('en');
  static const Locale fa = Locale('fa');
  static const List<Locale> supportedLocales = [en, fa];

  static Locale fromLanguageCode(String code) {
    switch (code) {
      case 'fa':
        return fa;
      case 'en':
      default:
        return en;
    }
  }

  static bool isRtl(Locale locale) => locale.languageCode == 'fa';
  static TextDirection textDirection(Locale locale) =>
      isRtl(locale) ? TextDirection.rtl : TextDirection.ltr;
}

class LocaleService {
  final Locale locale;
  final DigitConverter _digitConverter;

  LocaleService({required this.locale})
      : _digitConverter = DigitConverter(locale: locale);

  String get languageCode => locale.languageCode;
  bool get isRtl => AppLocales.isRtl(locale);
  TextDirection get textDirection => AppLocales.textDirection(locale);
  bool get usePersianDigits => locale.languageCode == 'fa';

  String convertDigits(String input) => _digitConverter.convert(input);
  String formatNumber(num value) => _digitConverter.convertNumber(value);

  String formatDate(DateTime date, {bool includeDayName = true}) {
    if (locale.languageCode == 'fa') {
      // [DEV] — Using the project's PersianDateHelper with the CORRECT method name.
      if (includeDayName) {
        return PersianDateHelper.formatFull(date);
      } else {
        return PersianDateHelper.formatJalali(date);
      }
    } else {
      return _formatGregorian(date, includeDayName: includeDayName);
    }
  }

  String formatTime(DateTime date) {
    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');
    return convertDigits('$hour:$minute');
  }

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
    final index = date.weekday % 7;
    return locale.languageCode == 'fa'
        ? weekdayNamesFa[index]
        : weekdayNamesEn[index];
  }

  String getMonthName(int month) {
    final monthNamesFa = [
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
    final monthNamesEn = [
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
    final names = locale.languageCode == 'fa' ? monthNamesFa : monthNamesEn;
    if (month < 1 || month > 12) return '';
    return names[month - 1];
  }

  String _formatGregorian(DateTime date, {bool includeDayName = true}) {
    final dayName = includeDayName ? '${getDayName(date)}, ' : '';
    final month = getMonthName(date.month);
    final day = date.day;
    final year = date.year;
    return '$dayName$month $day, $year';
  }

  LocaleService copyWith(Locale newLocale) {
    return LocaleService(locale: newLocale);
  }
}

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
