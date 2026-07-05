// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'lajvard';

  @override
  String get appTitleWithEmoji => 'lajvard 🟦';

  @override
  String get weather => 'Weather';

  @override
  String get settings => 'Settings';

  @override
  String get searchLocation => 'Search Location';

  @override
  String get searchHint => 'Search city name...';

  @override
  String get noResultsFound => 'No results found';

  @override
  String get useMyLocation => 'Use my location';

  @override
  String get locationPermissionDenied => 'Location permission denied';

  @override
  String get locationPermissionDeniedMessage =>
      'Please enable location access in your device settings to use this feature.';

  @override
  String get locationSettings => 'Open Settings';

  @override
  String get locationUnavailable => 'Location unavailable';

  @override
  String get locationUnavailableMessage =>
      'Could not determine your location. Please try again.';

  @override
  String get currentLocation => 'Current Location';

  @override
  String get now => 'Now';

  @override
  String get today => 'Today';

  @override
  String get tomorrow => 'Tomorrow';

  @override
  String get hourlyForecast => 'Hourly Forecast';

  @override
  String get dailyForecast => '7-Day Forecast';

  @override
  String get high => 'H';

  @override
  String get low => 'L';

  @override
  String get feelsLike => 'Feels Like';

  @override
  String get wind => 'Wind';

  @override
  String get humidity => 'Humidity';

  @override
  String get uvIndex => 'UV Index';

  @override
  String get pressure => 'Pressure';

  @override
  String get visibility => 'Visibility';

  @override
  String get dewPoint => 'Dew Point';

  @override
  String get windSpeedUnit => 'km/h';

  @override
  String get pressureUnit => 'hPa';

  @override
  String get visibilityUnit => 'km';

  @override
  String get humidityUnit => '%';

  @override
  String get uvLow => 'Low';

  @override
  String get uvModerate => 'Moderate';

  @override
  String get uvHigh => 'High';

  @override
  String get uvVeryHigh => 'Very High';

  @override
  String get uvExtreme => 'Extreme';

  @override
  String get temperatureUnit => 'Temperature Unit';

  @override
  String get celsius => 'Celsius (°C)';

  @override
  String get fahrenheit => 'Fahrenheit (°F)';

  @override
  String get language => 'Language';

  @override
  String get english => 'English';

  @override
  String get persian => 'فارسی';

  @override
  String get theme => 'Theme';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get themeSystem => 'System';

  @override
  String get errorGeneric => 'Something went wrong. Please try again.';

  @override
  String get errorNoInternet => 'No internet connection.';

  @override
  String get errorNoInternetMessage =>
      'Please check your network connection and try again.';

  @override
  String get errorServer => 'Server error.';

  @override
  String get errorServerMessage =>
      'The weather service is temporarily unavailable. Please try again later.';

  @override
  String get errorLocation => 'Location error.';

  @override
  String get retry => 'Retry';

  @override
  String get loading => 'Loading...';

  @override
  String get updating => 'Updating...';

  @override
  String lastUpdated(String time) {
    return 'Last updated: $time';
  }

  @override
  String get monday => 'Monday';

  @override
  String get tuesday => 'Tuesday';

  @override
  String get wednesday => 'Wednesday';

  @override
  String get thursday => 'Thursday';

  @override
  String get friday => 'Friday';

  @override
  String get saturday => 'Saturday';

  @override
  String get sunday => 'Sunday';

  @override
  String get january => 'January';

  @override
  String get february => 'February';

  @override
  String get march => 'March';

  @override
  String get april => 'April';

  @override
  String get may => 'May';

  @override
  String get june => 'June';

  @override
  String get july => 'July';

  @override
  String get august => 'August';

  @override
  String get september => 'September';

  @override
  String get october => 'October';

  @override
  String get november => 'November';

  @override
  String get december => 'December';

  @override
  String get wmoCode0 => 'Clear sky';

  @override
  String get wmoCode1 => 'Mainly clear';

  @override
  String get wmoCode2 => 'Partly cloudy';

  @override
  String get wmoCode3 => 'Overcast';

  @override
  String get wmoCode45 => 'Foggy';

  @override
  String get wmoCode48 => 'Rime fog';

  @override
  String get wmoCode51 => 'Light drizzle';

  @override
  String get wmoCode53 => 'Moderate drizzle';

  @override
  String get wmoCode55 => 'Dense drizzle';

  @override
  String get wmoCode61 => 'Slight rain';

  @override
  String get wmoCode63 => 'Moderate rain';

  @override
  String get wmoCode65 => 'Heavy rain';

  @override
  String get wmoCode71 => 'Slight snowfall';

  @override
  String get wmoCode73 => 'Moderate snowfall';

  @override
  String get wmoCode75 => 'Heavy snowfall';

  @override
  String get wmoCode80 => 'Slight rain showers';

  @override
  String get wmoCode81 => 'Moderate rain showers';

  @override
  String get wmoCode82 => 'Violent rain showers';

  @override
  String get wmoCode85 => 'Slight snow showers';

  @override
  String get wmoCode86 => 'Heavy snow showers';

  @override
  String get wmoCode95 => 'Thunderstorm';

  @override
  String get wmoCode96 => 'Thunderstorm with slight hail';

  @override
  String get wmoCode99 => 'Thunderstorm with heavy hail';

  @override
  String get north => 'N';

  @override
  String get northEast => 'NE';

  @override
  String get east => 'E';

  @override
  String get southEast => 'SE';

  @override
  String get south => 'S';

  @override
  String get southWest => 'SW';

  @override
  String get west => 'W';

  @override
  String get northWest => 'NW';
}
