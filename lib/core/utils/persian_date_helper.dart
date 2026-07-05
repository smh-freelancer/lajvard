import 'package:shamsi_date/shamsi_date.dart';

class PersianDateHelper {
  /// Convert Gregorian DateTime → Jalali formatted string
  static String formatJalali(DateTime date) {
    final j = Jalali.fromDateTime(date);

    final year = j.year.toString();
    final month = j.month.toString().padLeft(2, '0');
    final day = j.day.toString().padLeft(2, '0');

    return '$year/$month/$day';
  }

  /// Full Persian readable format (optional use in details section)
  static String formatFull(DateTime date) {
    final j = Jalali.fromDateTime(date);

    return '${_weekDay(j)} ${j.day} ${_monthName(j.month)} ${j.year}';
  }

  static String _monthName(int month) {
    const months = [
      'فروردین',
      'اردیبهشت',
      'خرداد',
      'تیر',
      'مرداد',
      'شهریور',
      'مهر',
      'آبان',
      'آذر',
      'دی',
      'بهمن',
      'اسفند',
    ];
    return months[month - 1];
  }

  static String _weekDay(Jalali j) {
    switch (j.weekDay) {
      case 0:
        return 'شنبه';
      case 1:
        return 'یکشنبه';
      case 2:
        return 'دوشنبه';
      case 3:
        return 'سه‌شنبه';
      case 4:
        return 'چهارشنبه';
      case 5:
        return 'پنجشنبه';
      case 6:
        return 'جمعه';
      default:
        return '';
    }
  }
}
