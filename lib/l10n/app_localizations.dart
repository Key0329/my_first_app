import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
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

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
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
    Locale('zh'),
  ];

  /// App title shown in the title bar
  ///
  /// In zh, this message translates to:
  /// **'工具箱 Pro'**
  String get appTitle;

  /// Bottom navigation tab label for tools
  ///
  /// In zh, this message translates to:
  /// **'工具'**
  String get tabTools;

  /// Bottom navigation tab label for favorites
  ///
  /// In zh, this message translates to:
  /// **'收藏'**
  String get tabFavorites;

  /// Bottom navigation tab label for settings
  ///
  /// In zh, this message translates to:
  /// **'設定'**
  String get tabSettings;

  /// Tool name: Calculator
  ///
  /// In zh, this message translates to:
  /// **'計算機'**
  String get toolCalculator;

  /// Tool name: Unit Converter
  ///
  /// In zh, this message translates to:
  /// **'單位換算'**
  String get toolUnitConverter;

  /// Tool name: QR Generator
  ///
  /// In zh, this message translates to:
  /// **'QR Code 產生器'**
  String get toolQrGenerator;

  /// Tool name: Flashlight
  ///
  /// In zh, this message translates to:
  /// **'手電筒'**
  String get toolFlashlight;

  /// Tool name: Level
  ///
  /// In zh, this message translates to:
  /// **'水平儀'**
  String get toolLevel;

  /// Tool name: Compass
  ///
  /// In zh, this message translates to:
  /// **'指南針'**
  String get toolCompass;

  /// Tool name: Stopwatch
  ///
  /// In zh, this message translates to:
  /// **'碼錶'**
  String get toolStopwatch;

  /// Tool name: Noise Meter
  ///
  /// In zh, this message translates to:
  /// **'噪音計'**
  String get toolNoiseMeter;

  /// Tool name: Password Generator
  ///
  /// In zh, this message translates to:
  /// **'密碼產生器'**
  String get toolPasswordGenerator;

  /// Tool name: Color Picker
  ///
  /// In zh, this message translates to:
  /// **'色彩擷取'**
  String get toolColorPicker;

  /// Tool name: Protractor
  ///
  /// In zh, this message translates to:
  /// **'量角器'**
  String get toolProtractor;

  /// Tool name: BMI Calculator
  ///
  /// In zh, this message translates to:
  /// **'BMI 計算機'**
  String get toolBmiCalculator;

  /// Tool name: Split Bill
  ///
  /// In zh, this message translates to:
  /// **'AA 制分帳'**
  String get toolSplitBill;

  /// Tool name: Random Wheel
  ///
  /// In zh, this message translates to:
  /// **'隨機決定器'**
  String get toolRandomWheel;

  /// Tool name: Screen Ruler
  ///
  /// In zh, this message translates to:
  /// **'螢幕尺規'**
  String get toolScreenRuler;

  /// Search bar hint text
  ///
  /// In zh, this message translates to:
  /// **'搜尋工具...'**
  String get searchHint;

  /// Empty favorites title
  ///
  /// In zh, this message translates to:
  /// **'尚未收藏任何工具'**
  String get favoritesEmpty;

  /// Empty favorites hint
  ///
  /// In zh, this message translates to:
  /// **'長按工具卡片即可加入收藏'**
  String get favoritesEmptyHint;

  /// Settings section: Appearance
  ///
  /// In zh, this message translates to:
  /// **'外觀'**
  String get settingsAppearance;

  /// Settings label: Language
  ///
  /// In zh, this message translates to:
  /// **'語言'**
  String get settingsLanguage;

  /// Settings section: About
  ///
  /// In zh, this message translates to:
  /// **'關於'**
  String get settingsAbout;

  /// Settings label: Theme Mode
  ///
  /// In zh, this message translates to:
  /// **'主題模式'**
  String get settingsThemeMode;

  /// Theme option: Light
  ///
  /// In zh, this message translates to:
  /// **'亮色'**
  String get settingsThemeLight;

  /// Theme option: Dark
  ///
  /// In zh, this message translates to:
  /// **'暗色'**
  String get settingsThemeDark;

  /// Theme option: System
  ///
  /// In zh, this message translates to:
  /// **'跟隨系統'**
  String get settingsThemeSystem;

  /// Settings label: Version
  ///
  /// In zh, this message translates to:
  /// **'版本'**
  String get settingsVersion;

  /// Settings label: Privacy Policy
  ///
  /// In zh, this message translates to:
  /// **'隱私政策'**
  String get settingsPrivacyPolicy;

  /// Settings label: Terms of Service
  ///
  /// In zh, this message translates to:
  /// **'使用條款'**
  String get settingsTermsOfService;
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
      <String>['en', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
