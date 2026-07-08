import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fa.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fa')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'lajvard'**
  String get appTitle;

  /// No description provided for @appTitleWithEmoji.
  ///
  /// In en, this message translates to:
  /// **'lajvard 🟦'**
  String get appTitleWithEmoji;

  /// No description provided for @weather.
  ///
  /// In en, this message translates to:
  /// **'Weather'**
  String get weather;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @searchLocation.
  ///
  /// In en, this message translates to:
  /// **'Search Location'**
  String get searchLocation;

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'Search city name...'**
  String get searchHint;

  /// No description provided for @noResultsFound.
  ///
  /// In en, this message translates to:
  /// **'No results found'**
  String get noResultsFound;

  /// No description provided for @useMyLocation.
  ///
  /// In en, this message translates to:
  /// **'Use my location'**
  String get useMyLocation;

  /// No description provided for @locationPermissionDenied.
  ///
  /// In en, this message translates to:
  /// **'Location permission denied'**
  String get locationPermissionDenied;

  /// No description provided for @locationPermissionDeniedMessage.
  ///
  /// In en, this message translates to:
  /// **'Please enable location access in your device settings to use this feature.'**
  String get locationPermissionDeniedMessage;

  /// No description provided for @locationSettings.
  ///
  /// In en, this message translates to:
  /// **'Open Settings'**
  String get locationSettings;

  /// No description provided for @locationUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Location unavailable'**
  String get locationUnavailable;

  /// No description provided for @locationUnavailableMessage.
  ///
  /// In en, this message translates to:
  /// **'Could not determine your location. Please try again.'**
  String get locationUnavailableMessage;

  /// No description provided for @currentLocation.
  ///
  /// In en, this message translates to:
  /// **'Current Location'**
  String get currentLocation;

  /// No description provided for @now.
  ///
  /// In en, this message translates to:
  /// **'Now'**
  String get now;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @tomorrow.
  ///
  /// In en, this message translates to:
  /// **'Tomorrow'**
  String get tomorrow;

  /// No description provided for @hourlyForecast.
  ///
  /// In en, this message translates to:
  /// **'Hourly Forecast'**
  String get hourlyForecast;

  /// No description provided for @dailyForecast.
  ///
  /// In en, this message translates to:
  /// **'7-Day Forecast'**
  String get dailyForecast;

  /// No description provided for @high.
  ///
  /// In en, this message translates to:
  /// **'H'**
  String get high;

  /// No description provided for @low.
  ///
  /// In en, this message translates to:
  /// **'L'**
  String get low;

  /// No description provided for @feelsLike.
  ///
  /// In en, this message translates to:
  /// **'Feels Like'**
  String get feelsLike;

  /// No description provided for @wind.
  ///
  /// In en, this message translates to:
  /// **'Wind'**
  String get wind;

  /// No description provided for @humidity.
  ///
  /// In en, this message translates to:
  /// **'Humidity'**
  String get humidity;

  /// No description provided for @uvIndex.
  ///
  /// In en, this message translates to:
  /// **'UV Index'**
  String get uvIndex;

  /// No description provided for @pressure.
  ///
  /// In en, this message translates to:
  /// **'Pressure'**
  String get pressure;

  /// No description provided for @visibility.
  ///
  /// In en, this message translates to:
  /// **'Visibility'**
  String get visibility;

  /// No description provided for @dewPoint.
  ///
  /// In en, this message translates to:
  /// **'Dew Point'**
  String get dewPoint;

  /// No description provided for @windSpeedUnit.
  ///
  /// In en, this message translates to:
  /// **'km/h'**
  String get windSpeedUnit;

  /// No description provided for @pressureUnit.
  ///
  /// In en, this message translates to:
  /// **'hPa'**
  String get pressureUnit;

  /// No description provided for @visibilityUnit.
  ///
  /// In en, this message translates to:
  /// **'km'**
  String get visibilityUnit;

  /// No description provided for @humidityUnit.
  ///
  /// In en, this message translates to:
  /// **'%'**
  String get humidityUnit;

  /// No description provided for @uvLow.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get uvLow;

  /// No description provided for @uvModerate.
  ///
  /// In en, this message translates to:
  /// **'Moderate'**
  String get uvModerate;

  /// No description provided for @uvHigh.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get uvHigh;

  /// No description provided for @uvVeryHigh.
  ///
  /// In en, this message translates to:
  /// **'Very High'**
  String get uvVeryHigh;

  /// No description provided for @uvExtreme.
  ///
  /// In en, this message translates to:
  /// **'Extreme'**
  String get uvExtreme;

  /// No description provided for @temperatureUnit.
  ///
  /// In en, this message translates to:
  /// **'Temperature Unit'**
  String get temperatureUnit;

  /// No description provided for @celsius.
  ///
  /// In en, this message translates to:
  /// **'Celsius (°C)'**
  String get celsius;

  /// No description provided for @fahrenheit.
  ///
  /// In en, this message translates to:
  /// **'Fahrenheit (°F)'**
  String get fahrenheit;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @persian.
  ///
  /// In en, this message translates to:
  /// **'فارسی'**
  String get persian;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @themeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// No description provided for @themeSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get themeSystem;

  /// No description provided for @errorGeneric.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get errorGeneric;

  /// No description provided for @errorNoInternet.
  ///
  /// In en, this message translates to:
  /// **'No internet connection.'**
  String get errorNoInternet;

  /// No description provided for @errorNoInternetMessage.
  ///
  /// In en, this message translates to:
  /// **'Please check your network connection and try again.'**
  String get errorNoInternetMessage;

  /// No description provided for @errorServer.
  ///
  /// In en, this message translates to:
  /// **'Server error.'**
  String get errorServer;

  /// No description provided for @errorServerMessage.
  ///
  /// In en, this message translates to:
  /// **'The weather service is temporarily unavailable. Please try again later.'**
  String get errorServerMessage;

  /// No description provided for @errorLocation.
  ///
  /// In en, this message translates to:
  /// **'Location error.'**
  String get errorLocation;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @updating.
  ///
  /// In en, this message translates to:
  /// **'Updating...'**
  String get updating;

  /// No description provided for @lastUpdated.
  ///
  /// In en, this message translates to:
  /// **'Last updated: {time}'**
  String lastUpdated(String time);

  /// No description provided for @monday.
  ///
  /// In en, this message translates to:
  /// **'Monday'**
  String get monday;

  /// No description provided for @tuesday.
  ///
  /// In en, this message translates to:
  /// **'Tuesday'**
  String get tuesday;

  /// No description provided for @wednesday.
  ///
  /// In en, this message translates to:
  /// **'Wednesday'**
  String get wednesday;

  /// No description provided for @thursday.
  ///
  /// In en, this message translates to:
  /// **'Thursday'**
  String get thursday;

  /// No description provided for @friday.
  ///
  /// In en, this message translates to:
  /// **'Friday'**
  String get friday;

  /// No description provided for @saturday.
  ///
  /// In en, this message translates to:
  /// **'Saturday'**
  String get saturday;

  /// No description provided for @sunday.
  ///
  /// In en, this message translates to:
  /// **'Sunday'**
  String get sunday;

  /// No description provided for @january.
  ///
  /// In en, this message translates to:
  /// **'January'**
  String get january;

  /// No description provided for @february.
  ///
  /// In en, this message translates to:
  /// **'February'**
  String get february;

  /// No description provided for @march.
  ///
  /// In en, this message translates to:
  /// **'March'**
  String get march;

  /// No description provided for @april.
  ///
  /// In en, this message translates to:
  /// **'April'**
  String get april;

  /// No description provided for @may.
  ///
  /// In en, this message translates to:
  /// **'May'**
  String get may;

  /// No description provided for @june.
  ///
  /// In en, this message translates to:
  /// **'June'**
  String get june;

  /// No description provided for @july.
  ///
  /// In en, this message translates to:
  /// **'July'**
  String get july;

  /// No description provided for @august.
  ///
  /// In en, this message translates to:
  /// **'August'**
  String get august;

  /// No description provided for @september.
  ///
  /// In en, this message translates to:
  /// **'September'**
  String get september;

  /// No description provided for @october.
  ///
  /// In en, this message translates to:
  /// **'October'**
  String get october;

  /// No description provided for @november.
  ///
  /// In en, this message translates to:
  /// **'November'**
  String get november;

  /// No description provided for @december.
  ///
  /// In en, this message translates to:
  /// **'December'**
  String get december;

  /// No description provided for @wmoCode0.
  ///
  /// In en, this message translates to:
  /// **'Clear sky'**
  String get wmoCode0;

  /// No description provided for @wmoCode1.
  ///
  /// In en, this message translates to:
  /// **'Mainly clear'**
  String get wmoCode1;

  /// No description provided for @wmoCode2.
  ///
  /// In en, this message translates to:
  /// **'Partly cloudy'**
  String get wmoCode2;

  /// No description provided for @wmoCode3.
  ///
  /// In en, this message translates to:
  /// **'Overcast'**
  String get wmoCode3;

  /// No description provided for @wmoCode45.
  ///
  /// In en, this message translates to:
  /// **'Foggy'**
  String get wmoCode45;

  /// No description provided for @wmoCode48.
  ///
  /// In en, this message translates to:
  /// **'Rime fog'**
  String get wmoCode48;

  /// No description provided for @wmoCode51.
  ///
  /// In en, this message translates to:
  /// **'Light drizzle'**
  String get wmoCode51;

  /// No description provided for @wmoCode53.
  ///
  /// In en, this message translates to:
  /// **'Moderate drizzle'**
  String get wmoCode53;

  /// No description provided for @wmoCode55.
  ///
  /// In en, this message translates to:
  /// **'Dense drizzle'**
  String get wmoCode55;

  /// No description provided for @wmoCode61.
  ///
  /// In en, this message translates to:
  /// **'Slight rain'**
  String get wmoCode61;

  /// No description provided for @wmoCode63.
  ///
  /// In en, this message translates to:
  /// **'Moderate rain'**
  String get wmoCode63;

  /// No description provided for @wmoCode65.
  ///
  /// In en, this message translates to:
  /// **'Heavy rain'**
  String get wmoCode65;

  /// No description provided for @wmoCode71.
  ///
  /// In en, this message translates to:
  /// **'Slight snowfall'**
  String get wmoCode71;

  /// No description provided for @wmoCode73.
  ///
  /// In en, this message translates to:
  /// **'Moderate snowfall'**
  String get wmoCode73;

  /// No description provided for @wmoCode75.
  ///
  /// In en, this message translates to:
  /// **'Heavy snowfall'**
  String get wmoCode75;

  /// No description provided for @wmoCode80.
  ///
  /// In en, this message translates to:
  /// **'Slight rain showers'**
  String get wmoCode80;

  /// No description provided for @wmoCode81.
  ///
  /// In en, this message translates to:
  /// **'Moderate rain showers'**
  String get wmoCode81;

  /// No description provided for @wmoCode82.
  ///
  /// In en, this message translates to:
  /// **'Violent rain showers'**
  String get wmoCode82;

  /// No description provided for @wmoCode85.
  ///
  /// In en, this message translates to:
  /// **'Slight snow showers'**
  String get wmoCode85;

  /// No description provided for @wmoCode86.
  ///
  /// In en, this message translates to:
  /// **'Heavy snow showers'**
  String get wmoCode86;

  /// No description provided for @wmoCode95.
  ///
  /// In en, this message translates to:
  /// **'Thunderstorm'**
  String get wmoCode95;

  /// No description provided for @wmoCode96.
  ///
  /// In en, this message translates to:
  /// **'Thunderstorm with slight hail'**
  String get wmoCode96;

  /// No description provided for @wmoCode99.
  ///
  /// In en, this message translates to:
  /// **'Thunderstorm with heavy hail'**
  String get wmoCode99;

  /// No description provided for @north.
  ///
  /// In en, this message translates to:
  /// **'N'**
  String get north;

  /// No description provided for @northEast.
  ///
  /// In en, this message translates to:
  /// **'NE'**
  String get northEast;

  /// No description provided for @east.
  ///
  /// In en, this message translates to:
  /// **'E'**
  String get east;

  /// No description provided for @southEast.
  ///
  /// In en, this message translates to:
  /// **'SE'**
  String get southEast;

  /// No description provided for @south.
  ///
  /// In en, this message translates to:
  /// **'S'**
  String get south;

  /// No description provided for @southWest.
  ///
  /// In en, this message translates to:
  /// **'SW'**
  String get southWest;

  /// No description provided for @west.
  ///
  /// In en, this message translates to:
  /// **'W'**
  String get west;

  /// No description provided for @northWest.
  ///
  /// In en, this message translates to:
  /// **'NW'**
  String get northWest;

  /// No description provided for @details.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get details;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'fa'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fa':
      return AppLocalizationsFa();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
