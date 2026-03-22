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

  /// Tool name: Currency Converter
  ///
  /// In zh, this message translates to:
  /// **'匯率換算'**
  String get toolCurrencyConverter;

  /// Currency converter page title
  ///
  /// In zh, this message translates to:
  /// **'匯率換算'**
  String get tool_currency_converter_title;

  /// Label for source currency
  ///
  /// In zh, this message translates to:
  /// **'來源幣別'**
  String get tool_currency_converter_from;

  /// Label for target currency
  ///
  /// In zh, this message translates to:
  /// **'目標幣別'**
  String get tool_currency_converter_to;

  /// Label for amount input
  ///
  /// In zh, this message translates to:
  /// **'金額'**
  String get tool_currency_converter_amount;

  /// Hint for amount input
  ///
  /// In zh, this message translates to:
  /// **'請輸入金額'**
  String get tool_currency_converter_amount_hint;

  /// Label for conversion result
  ///
  /// In zh, this message translates to:
  /// **'結果'**
  String get tool_currency_converter_result;

  /// Swap currencies button tooltip
  ///
  /// In zh, this message translates to:
  /// **'交換幣別'**
  String get tool_currency_converter_swap;

  /// Loading indicator text
  ///
  /// In zh, this message translates to:
  /// **'載入匯率中...'**
  String get tool_currency_converter_loading;

  /// Offline mode indicator
  ///
  /// In zh, this message translates to:
  /// **'離線模式'**
  String get tool_currency_converter_offline;

  /// Offline mode hint
  ///
  /// In zh, this message translates to:
  /// **'使用快取匯率資料'**
  String get tool_currency_converter_offline_hint;

  /// Last updated timestamp
  ///
  /// In zh, this message translates to:
  /// **'最後更新：{date}'**
  String tool_currency_converter_last_updated(String date);

  /// Error message
  ///
  /// In zh, this message translates to:
  /// **'無法載入匯率資料'**
  String get tool_currency_converter_error;

  /// Error when no cache and no network
  ///
  /// In zh, this message translates to:
  /// **'首次使用需要網路連線'**
  String get tool_currency_converter_network_required;

  /// Retry button label
  ///
  /// In zh, this message translates to:
  /// **'重試'**
  String get tool_currency_converter_retry;

  /// Currency selector label
  ///
  /// In zh, this message translates to:
  /// **'選擇幣別'**
  String get tool_currency_converter_select_currency;

  /// Tool name: QR Scanner Live
  ///
  /// In zh, this message translates to:
  /// **'QR Code 掃描器'**
  String get toolQrScannerLive;

  /// QR scanner page title
  ///
  /// In zh, this message translates to:
  /// **'QR Code 掃描器'**
  String get tool_qr_scanner_live_title;

  /// Hint text while scanning
  ///
  /// In zh, this message translates to:
  /// **'將 QR Code 對準掃描框'**
  String get tool_qr_scanner_live_scan_hint;

  /// Result section label
  ///
  /// In zh, this message translates to:
  /// **'掃描結果'**
  String get tool_qr_scanner_live_result;

  /// Result type label: URL
  ///
  /// In zh, this message translates to:
  /// **'URL'**
  String get tool_qr_scanner_live_type_url;

  /// Result type label: Text
  ///
  /// In zh, this message translates to:
  /// **'文字'**
  String get tool_qr_scanner_live_type_text;

  /// Copy button label
  ///
  /// In zh, this message translates to:
  /// **'複製'**
  String get tool_qr_scanner_live_copy;

  /// Rescan button label
  ///
  /// In zh, this message translates to:
  /// **'重新掃描'**
  String get tool_qr_scanner_live_rescan;

  /// Snackbar message after copying
  ///
  /// In zh, this message translates to:
  /// **'已複製到剪貼簿'**
  String get tool_qr_scanner_live_copied;

  /// Hint for URL results
  ///
  /// In zh, this message translates to:
  /// **'複製網址後可在瀏覽器中開啟'**
  String get tool_qr_scanner_live_url_hint;

  /// Permission denied title
  ///
  /// In zh, this message translates to:
  /// **'需要相機權限'**
  String get tool_qr_scanner_live_permission_title;

  /// Permission denied message
  ///
  /// In zh, this message translates to:
  /// **'請在系統設定中允許此 App 使用相機'**
  String get tool_qr_scanner_live_permission_message;

  /// Permission retry button
  ///
  /// In zh, this message translates to:
  /// **'重新嘗試'**
  String get tool_qr_scanner_live_permission_retry;

  /// Permission section label in body
  ///
  /// In zh, this message translates to:
  /// **'相機權限'**
  String get tool_qr_scanner_live_permission_section;

  /// Permission guidance text in body
  ///
  /// In zh, this message translates to:
  /// **'請前往系統設定開啟相機權限，才能使用掃描功能。'**
  String get tool_qr_scanner_live_permission_guidance;

  /// Camera error title
  ///
  /// In zh, this message translates to:
  /// **'相機啟動失敗'**
  String get tool_qr_scanner_live_error_title;

  /// Camera error message
  ///
  /// In zh, this message translates to:
  /// **'請確認相機功能正常後重試'**
  String get tool_qr_scanner_live_error_message;

  /// Tool name: Date Calculator
  ///
  /// In zh, this message translates to:
  /// **'日期計算機'**
  String get toolDateCalculator;

  /// Date calculator page title
  ///
  /// In zh, this message translates to:
  /// **'日期計算機'**
  String get tool_date_calculator_title;

  /// Tab label: Date Interval
  ///
  /// In zh, this message translates to:
  /// **'日期區間'**
  String get tool_date_calculator_tab_interval;

  /// Tab label: Add/Subtract Days
  ///
  /// In zh, this message translates to:
  /// **'加減天數'**
  String get tool_date_calculator_tab_add_sub;

  /// Tab label: Business Days
  ///
  /// In zh, this message translates to:
  /// **'工作日'**
  String get tool_date_calculator_tab_business;

  /// Label: Start Date
  ///
  /// In zh, this message translates to:
  /// **'開始日期'**
  String get tool_date_calculator_start_date;

  /// Label: End Date
  ///
  /// In zh, this message translates to:
  /// **'結束日期'**
  String get tool_date_calculator_end_date;

  /// Label: Base Date
  ///
  /// In zh, this message translates to:
  /// **'基準日期'**
  String get tool_date_calculator_base_date;

  /// Label: Days
  ///
  /// In zh, this message translates to:
  /// **'天數'**
  String get tool_date_calculator_days;

  /// Hint: Enter number of days
  ///
  /// In zh, this message translates to:
  /// **'輸入天數'**
  String get tool_date_calculator_enter_days;

  /// Button: Add
  ///
  /// In zh, this message translates to:
  /// **'加'**
  String get tool_date_calculator_add;

  /// Button: Subtract
  ///
  /// In zh, this message translates to:
  /// **'減'**
  String get tool_date_calculator_subtract;

  /// Label: Target Date
  ///
  /// In zh, this message translates to:
  /// **'目標日期'**
  String get tool_date_calculator_target_date;

  /// Result: N days
  ///
  /// In zh, this message translates to:
  /// **'{count} 天'**
  String tool_date_calculator_result_days(int count);

  /// Result: N weeks M days
  ///
  /// In zh, this message translates to:
  /// **'{weeks} 週 {days} 天'**
  String tool_date_calculator_result_weeks(int weeks, int days);

  /// Result: N months M days
  ///
  /// In zh, this message translates to:
  /// **'{months} 個月 {days} 天'**
  String tool_date_calculator_result_months(int months, int days);

  /// Result: N business days
  ///
  /// In zh, this message translates to:
  /// **'{count} 工作日'**
  String tool_date_calculator_result_business_days(int count);

  /// Result: N calendar days
  ///
  /// In zh, this message translates to:
  /// **'{count} 日曆天'**
  String tool_date_calculator_result_calendar_days(int count);

  /// Result: N weekend days
  ///
  /// In zh, this message translates to:
  /// **'{count} 天週末'**
  String tool_date_calculator_result_weekend_days(int count);

  /// Header label: Date Interval
  ///
  /// In zh, this message translates to:
  /// **'日期區間'**
  String get tool_date_calculator_interval_label;

  /// Header label: Business Days Calculation
  ///
  /// In zh, this message translates to:
  /// **'工作日計算'**
  String get tool_date_calculator_business_label;
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
