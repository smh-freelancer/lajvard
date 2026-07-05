// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Persian (`fa`).
class AppLocalizationsFa extends AppLocalizations {
  AppLocalizationsFa([String locale = 'fa']) : super(locale);

  @override
  String get appTitle => 'لاژورد';

  @override
  String get appTitleWithEmoji => 'لاژورد 🟦';

  @override
  String get weather => 'آب‌وهوا';

  @override
  String get settings => 'تنظیمات';

  @override
  String get searchLocation => 'جستجوی موقعیت';

  @override
  String get searchHint => 'نام شهر را جستجو کنید...';

  @override
  String get noResultsFound => 'نتیجه‌ای یافت نشد';

  @override
  String get useMyLocation => 'موقعیت من';

  @override
  String get locationPermissionDenied => 'دسترسی به موقعیت رد شد';

  @override
  String get locationPermissionDeniedMessage =>
      'لطفاً دسترسی به موقعیت مکانی را در تنظیمات دستگاه خود فعال کنید.';

  @override
  String get locationSettings => 'باز کردن تنظیمات';

  @override
  String get locationUnavailable => 'موقعیت در دسترس نیست';

  @override
  String get locationUnavailableMessage =>
      'نتوانستیم موقعیت شما را تشخیص دهیم. لطفاً دوباره تلاش کنید.';

  @override
  String get currentLocation => 'موقعیت فعلی';

  @override
  String get now => 'اکنون';

  @override
  String get today => 'امروز';

  @override
  String get tomorrow => 'فردا';

  @override
  String get hourlyForecast => 'پیش‌بینی ساعتی';

  @override
  String get dailyForecast => 'پیش‌بینی ۷ روزه';

  @override
  String get high => 'ب';

  @override
  String get low => 'ز';

  @override
  String get feelsLike => 'حس دمایی';

  @override
  String get wind => 'باد';

  @override
  String get humidity => 'رطوبت';

  @override
  String get uvIndex => 'اشعه فرابنفش';

  @override
  String get pressure => 'فشار هوا';

  @override
  String get visibility => 'دید افقی';

  @override
  String get dewPoint => 'نقطه شبنم';

  @override
  String get windSpeedUnit => 'کیلومتر بر ساعت';

  @override
  String get pressureUnit => 'هکتوپاسکال';

  @override
  String get visibilityUnit => 'کیلومتر';

  @override
  String get humidityUnit => '٪';

  @override
  String get uvLow => 'کم';

  @override
  String get uvModerate => 'متوسط';

  @override
  String get uvHigh => 'زیاد';

  @override
  String get uvVeryHigh => 'بسیار زیاد';

  @override
  String get uvExtreme => 'شدید';

  @override
  String get temperatureUnit => 'واحد دما';

  @override
  String get celsius => 'سلسیوس (°C)';

  @override
  String get fahrenheit => 'فارنهایت (°F)';

  @override
  String get language => 'زبان';

  @override
  String get english => 'English';

  @override
  String get persian => 'فارسی';

  @override
  String get theme => 'پوسته';

  @override
  String get themeLight => 'روشن';

  @override
  String get themeDark => 'تاریک';

  @override
  String get themeSystem => 'سیستم';

  @override
  String get errorGeneric => 'مشکلی پیش آمد. لطفاً دوباره تلاش کنید.';

  @override
  String get errorNoInternet => 'اتصال اینترنت برقرار نیست.';

  @override
  String get errorNoInternetMessage =>
      'لطفاً اتصال شبکه خود را بررسی کرده و دوباره تلاش کنید.';

  @override
  String get errorServer => 'خطای سرور.';

  @override
  String get errorServerMessage =>
      'سرویس آب‌وهوا موقتاً در دسترس نیست. لطفاً بعداً تلاش کنید.';

  @override
  String get errorLocation => 'خطای موقعیت‌یاب.';

  @override
  String get retry => 'تلاش مجدد';

  @override
  String get loading => 'در حال بارگذاری...';

  @override
  String get updating => 'در حال به‌روزرسانی...';

  @override
  String lastUpdated(String time) {
    return 'آخرین به‌روزرسانی: $time';
  }

  @override
  String get monday => 'دوشنبه';

  @override
  String get tuesday => 'سه‌شنبه';

  @override
  String get wednesday => 'چهارشنبه';

  @override
  String get thursday => 'پنجشنبه';

  @override
  String get friday => 'جمعه';

  @override
  String get saturday => 'شنبه';

  @override
  String get sunday => 'یکشنبه';

  @override
  String get january => 'ژانویه';

  @override
  String get february => 'فوریه';

  @override
  String get march => 'مارس';

  @override
  String get april => 'آوریل';

  @override
  String get may => 'مه';

  @override
  String get june => 'ژوئن';

  @override
  String get july => 'ژوئیه';

  @override
  String get august => 'اوت';

  @override
  String get september => 'سپتامبر';

  @override
  String get october => 'اکتبر';

  @override
  String get november => 'نوامبر';

  @override
  String get december => 'دسامبر';

  @override
  String get wmoCode0 => 'آسمان صاف';

  @override
  String get wmoCode1 => 'عمدتاً صاف';

  @override
  String get wmoCode2 => 'نیمه ابری';

  @override
  String get wmoCode3 => 'ابری';

  @override
  String get wmoCode45 => 'مه‌آلود';

  @override
  String get wmoCode48 => 'مه یخ‌زده';

  @override
  String get wmoCode51 => 'نم‌باران سبک';

  @override
  String get wmoCode53 => 'نم‌باران متوسط';

  @override
  String get wmoCode55 => 'نم‌باران شدید';

  @override
  String get wmoCode61 => 'باران سبک';

  @override
  String get wmoCode63 => 'باران متوسط';

  @override
  String get wmoCode65 => 'باران شدید';

  @override
  String get wmoCode71 => 'برف سبک';

  @override
  String get wmoCode73 => 'برف متوسط';

  @override
  String get wmoCode75 => 'برف شدید';

  @override
  String get wmoCode80 => 'رگبار سبک';

  @override
  String get wmoCode81 => 'رگبار متوسط';

  @override
  String get wmoCode82 => 'رگبار شدید';

  @override
  String get wmoCode85 => 'بارش برف سبک';

  @override
  String get wmoCode86 => 'بارش برف شدید';

  @override
  String get wmoCode95 => 'رعد و برق';

  @override
  String get wmoCode96 => 'رعد و برق با تگرگ سبک';

  @override
  String get wmoCode99 => 'رعد و برق با تگرگ شدید';

  @override
  String get north => 'ش';

  @override
  String get northEast => 'ش‌خ';

  @override
  String get east => 'خ';

  @override
  String get southEast => 'ج‌خ';

  @override
  String get south => 'ج';

  @override
  String get southWest => 'ج‌غ';

  @override
  String get west => 'غ';

  @override
  String get northWest => 'ش‌غ';
}
