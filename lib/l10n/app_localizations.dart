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

  /// Tool name: Currency Converter
  ///
  /// In zh, this message translates to:
  /// **'匯率換算'**
  String get toolCurrencyConverter;

  /// Tool name: QR Scanner Live
  ///
  /// In zh, this message translates to:
  /// **'QR 掃描'**
  String get toolQrScannerLive;

  /// Tool name: Date Calculator
  ///
  /// In zh, this message translates to:
  /// **'日期計算機'**
  String get toolDateCalculator;

  /// Search bar hint text
  ///
  /// In zh, this message translates to:
  /// **'搜尋工具...'**
  String get searchHint;

  /// Empty search results message
  ///
  /// In zh, this message translates to:
  /// **'找不到符合的工具'**
  String get searchNoResults;

  /// Category filter: All
  ///
  /// In zh, this message translates to:
  /// **'全部'**
  String get categoryAll;

  /// Category filter: Calculate
  ///
  /// In zh, this message translates to:
  /// **'計算'**
  String get categoryCalculate;

  /// Category filter: Measure
  ///
  /// In zh, this message translates to:
  /// **'測量'**
  String get categoryMeasure;

  /// Category filter: Life
  ///
  /// In zh, this message translates to:
  /// **'生活'**
  String get categoryLife;

  /// Home page title
  ///
  /// In zh, this message translates to:
  /// **'工具箱'**
  String get homeTitle;

  /// Home page subtitle
  ///
  /// In zh, this message translates to:
  /// **'15+ 實用工具，一個 App 搞定'**
  String get homeSubtitle;

  /// Recent tools section header
  ///
  /// In zh, this message translates to:
  /// **'最近使用'**
  String get homeRecentTools;

  /// SnackBar message when adding to favorites
  ///
  /// In zh, this message translates to:
  /// **'已加入收藏'**
  String get homeFavoriteAdded;

  /// SnackBar message when removing from favorites
  ///
  /// In zh, this message translates to:
  /// **'已移除收藏'**
  String get homeFavoriteRemoved;

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

  /// Settings section: Data
  ///
  /// In zh, this message translates to:
  /// **'資料'**
  String get settingsData;

  /// Button: Clear all favorites
  ///
  /// In zh, this message translates to:
  /// **'清除所有收藏'**
  String get settingsClearFavorites;

  /// Dialog title: Clear favorites
  ///
  /// In zh, this message translates to:
  /// **'清除收藏'**
  String get settingsClearFavoritesTitle;

  /// Dialog message: Clear favorites
  ///
  /// In zh, this message translates to:
  /// **'確定要清除所有收藏的工具嗎？此操作無法復原。'**
  String get settingsClearFavoritesMessage;

  /// Button: Clear recent tools
  ///
  /// In zh, this message translates to:
  /// **'清除最近使用'**
  String get settingsClearRecent;

  /// Dialog title: Clear recent
  ///
  /// In zh, this message translates to:
  /// **'清除最近使用'**
  String get settingsClearRecentTitle;

  /// Dialog message: Clear recent
  ///
  /// In zh, this message translates to:
  /// **'確定要清除所有最近使用的工具紀錄嗎？'**
  String get settingsClearRecentMessage;

  /// Language option: Chinese
  ///
  /// In zh, this message translates to:
  /// **'繁體中文'**
  String get settingsLanguageZh;

  /// Language option: English
  ///
  /// In zh, this message translates to:
  /// **'English'**
  String get settingsLanguageEn;

  /// Common button: Cancel
  ///
  /// In zh, this message translates to:
  /// **'取消'**
  String get commonCancel;

  /// Common button: Confirm
  ///
  /// In zh, this message translates to:
  /// **'確認'**
  String get commonConfirm;

  /// Common button: Share
  ///
  /// In zh, this message translates to:
  /// **'分享'**
  String get commonShare;

  /// Common button: Copy
  ///
  /// In zh, this message translates to:
  /// **'複製'**
  String get commonCopy;

  /// Common label: Error
  ///
  /// In zh, this message translates to:
  /// **'錯誤'**
  String get commonError;

  /// Common button: Retry
  ///
  /// In zh, this message translates to:
  /// **'重試'**
  String get commonRetry;

  /// Common button: Delete
  ///
  /// In zh, this message translates to:
  /// **'刪除'**
  String get commonDelete;

  /// Common button: Reset
  ///
  /// In zh, this message translates to:
  /// **'重設'**
  String get commonReset;

  /// Tool recommendation bar title
  ///
  /// In zh, this message translates to:
  /// **'你可能也需要'**
  String get recommendationTitle;

  /// Onboarding: Skip button
  ///
  /// In zh, this message translates to:
  /// **'跳過'**
  String get onboardingSkip;

  /// Onboarding: Welcome page title
  ///
  /// In zh, this message translates to:
  /// **'歡迎使用工具箱 Pro'**
  String get onboardingWelcomeTitle;

  /// Onboarding: Welcome page description
  ///
  /// In zh, this message translates to:
  /// **'您的隨身工具箱，集合多種實用工具，讓日常生活更便利。'**
  String get onboardingWelcomeDesc;

  /// Onboarding: Features page title
  ///
  /// In zh, this message translates to:
  /// **'強大功能'**
  String get onboardingFeaturesTitle;

  /// Onboarding: Feature tools title
  ///
  /// In zh, this message translates to:
  /// **'豐富工具'**
  String get onboardingFeatureTools;

  /// Onboarding: Feature tools description
  ///
  /// In zh, this message translates to:
  /// **'計算機、單位轉換、密碼產生器等多種實用工具。'**
  String get onboardingFeatureToolsDesc;

  /// Onboarding: Feature favorites title
  ///
  /// In zh, this message translates to:
  /// **'收藏功能'**
  String get onboardingFeatureFavorites;

  /// Onboarding: Feature favorites description
  ///
  /// In zh, this message translates to:
  /// **'將常用工具加入收藏，快速存取。'**
  String get onboardingFeatureFavoritesDesc;

  /// Onboarding: Feature settings title
  ///
  /// In zh, this message translates to:
  /// **'個人化設定'**
  String get onboardingFeatureSettings;

  /// Onboarding: Feature settings description
  ///
  /// In zh, this message translates to:
  /// **'自訂主題、語言等偏好設定。'**
  String get onboardingFeatureSettingsDesc;

  /// Onboarding: Ready page title
  ///
  /// In zh, this message translates to:
  /// **'準備好了嗎？'**
  String get onboardingReadyTitle;

  /// Onboarding: Ready page description
  ///
  /// In zh, this message translates to:
  /// **'立即開始探索所有功能吧！'**
  String get onboardingReadyDesc;

  /// Onboarding: Start button
  ///
  /// In zh, this message translates to:
  /// **'開始使用'**
  String get onboardingStart;

  /// Calculator: History button
  ///
  /// In zh, this message translates to:
  /// **'歷史紀錄'**
  String get calculatorHistory;

  /// Calculator: Clear history button
  ///
  /// In zh, this message translates to:
  /// **'清除'**
  String get calculatorClear;

  /// Calculator: Divide by zero error
  ///
  /// In zh, this message translates to:
  /// **'錯誤：除以零'**
  String get calculatorDivideByZero;

  /// Calculator: Format error
  ///
  /// In zh, this message translates to:
  /// **'格式錯誤'**
  String get calculatorFormatError;

  /// BMI: Height label
  ///
  /// In zh, this message translates to:
  /// **'身高'**
  String get bmiHeight;

  /// BMI: Height unit
  ///
  /// In zh, this message translates to:
  /// **'公分 (cm)'**
  String get bmiHeightUnit;

  /// BMI: Weight label
  ///
  /// In zh, this message translates to:
  /// **'體重'**
  String get bmiWeight;

  /// BMI: Weight unit
  ///
  /// In zh, this message translates to:
  /// **'公斤 (kg)'**
  String get bmiWeightUnit;

  /// BMI: Calculate button
  ///
  /// In zh, this message translates to:
  /// **'計算 BMI'**
  String get bmiCalculate;

  /// BMI: Result section
  ///
  /// In zh, this message translates to:
  /// **'分析結果'**
  String get bmiResult;

  /// BMI: Value label
  ///
  /// In zh, this message translates to:
  /// **'BMI 數值'**
  String get bmiValue;

  /// BMI: Status label
  ///
  /// In zh, this message translates to:
  /// **'體重狀況'**
  String get bmiStatus;

  /// BMI: Underweight
  ///
  /// In zh, this message translates to:
  /// **'體重過輕'**
  String get bmiUnderweight;

  /// BMI: Normal
  ///
  /// In zh, this message translates to:
  /// **'正常體重'**
  String get bmiNormal;

  /// BMI: Overweight
  ///
  /// In zh, this message translates to:
  /// **'體重過重'**
  String get bmiOverweight;

  /// BMI: Obese
  ///
  /// In zh, this message translates to:
  /// **'肥胖'**
  String get bmiObese;

  /// Split bill: Page title
  ///
  /// In zh, this message translates to:
  /// **'分帳計算'**
  String get splitBillTitle;

  /// Split bill: Total amount label
  ///
  /// In zh, this message translates to:
  /// **'總金額'**
  String get splitBillTotalAmount;

  /// Split bill: Total amount hint
  ///
  /// In zh, this message translates to:
  /// **'請輸入總金額'**
  String get splitBillTotalHint;

  /// Split bill: People count label
  ///
  /// In zh, this message translates to:
  /// **'人數'**
  String get splitBillPeople;

  /// Split bill: Per person label
  ///
  /// In zh, this message translates to:
  /// **'每人應付'**
  String get splitBillPerPerson;

  /// Split bill: Total with currency
  ///
  /// In zh, this message translates to:
  /// **'總額 NT\$'**
  String get splitBillTotal;

  /// Split bill: First person pays extra
  ///
  /// In zh, this message translates to:
  /// **'第 1 人多付'**
  String get splitBillFirstPays;

  /// Split bill: Decrease people
  ///
  /// In zh, this message translates to:
  /// **'減少人數'**
  String get splitBillDecrease;

  /// Split bill: Increase people
  ///
  /// In zh, this message translates to:
  /// **'增加人數'**
  String get splitBillIncrease;

  /// Split bill: Equal mode
  ///
  /// In zh, this message translates to:
  /// **'等分'**
  String get splitBillModeEqual;

  /// Split bill: Ratio mode
  ///
  /// In zh, this message translates to:
  /// **'比例'**
  String get splitBillModeRatio;

  /// Split bill: Multi-item mode
  ///
  /// In zh, this message translates to:
  /// **'多項目'**
  String get splitBillModeMulti;

  /// Split bill: Tip label
  ///
  /// In zh, this message translates to:
  /// **'小費'**
  String get splitBillTip;

  /// Split bill: Tip percentage display
  ///
  /// In zh, this message translates to:
  /// **'小費 {percent}%'**
  String splitBillTipPercent(int percent);

  /// Split bill: Tip amount label
  ///
  /// In zh, this message translates to:
  /// **'小費金額'**
  String get splitBillTipAmount;

  /// Split bill: Final total with tip
  ///
  /// In zh, this message translates to:
  /// **'含小費總額'**
  String get splitBillFinalTotal;

  /// Split bill: Ratio label
  ///
  /// In zh, this message translates to:
  /// **'比例'**
  String get splitBillRatioLabel;

  /// Split bill: Person index in ratio mode
  ///
  /// In zh, this message translates to:
  /// **'第 {index} 人'**
  String splitBillRatioPerson(int index);

  /// Split bill: Person payment result in ratio mode
  ///
  /// In zh, this message translates to:
  /// **'第 {index} 人應付'**
  String splitBillRatioResult(int index);

  /// Split bill: Item name label
  ///
  /// In zh, this message translates to:
  /// **'項目名稱'**
  String get splitBillItemName;

  /// Split bill: Item amount label
  ///
  /// In zh, this message translates to:
  /// **'項目金額'**
  String get splitBillItemAmount;

  /// Split bill: Item participants label
  ///
  /// In zh, this message translates to:
  /// **'參與人數'**
  String get splitBillItemPeople;

  /// Split bill: Add item button
  ///
  /// In zh, this message translates to:
  /// **'新增項目'**
  String get splitBillAddItem;

  /// Split bill: Per person in multi-item mode
  ///
  /// In zh, this message translates to:
  /// **'每人'**
  String get splitBillItemPerPerson;

  /// Split bill: Multi-item summary
  ///
  /// In zh, this message translates to:
  /// **'各人總計'**
  String get splitBillMultiSummary;

  /// Level: Status label
  ///
  /// In zh, this message translates to:
  /// **'狀態'**
  String get levelStatus;

  /// Level: Normal status
  ///
  /// In zh, this message translates to:
  /// **'正常'**
  String get levelNormal;

  /// Level: Angle values label
  ///
  /// In zh, this message translates to:
  /// **'角度數值'**
  String get levelAngleValues;

  /// Level: X axis
  ///
  /// In zh, this message translates to:
  /// **'X 軸'**
  String get levelXAxis;

  /// Level: Y axis
  ///
  /// In zh, this message translates to:
  /// **'Y 軸'**
  String get levelYAxis;

  /// Compass: Calibration title
  ///
  /// In zh, this message translates to:
  /// **'校正方法'**
  String get compassCalibration;

  /// Compass: Calibration instruction
  ///
  /// In zh, this message translates to:
  /// **'將裝置拿起，以 8 字形揮動數次即可完成校正。'**
  String get compassCalibrationHint;

  /// Protractor: Angle label
  ///
  /// In zh, this message translates to:
  /// **'角度'**
  String get protractorAngle;

  /// Ruler: Calibrate button
  ///
  /// In zh, this message translates to:
  /// **'校準'**
  String get rulerCalibrate;

  /// Ruler: Calibrate done button
  ///
  /// In zh, this message translates to:
  /// **'完成校準'**
  String get rulerCalibrateDone;

  /// Ruler: Recalibrate button
  ///
  /// In zh, this message translates to:
  /// **'重新校準 PPI'**
  String get rulerRecalibrate;

  /// Ruler: Length label
  ///
  /// In zh, this message translates to:
  /// **'長度'**
  String get rulerLength;

  /// Noise meter: dB label
  ///
  /// In zh, this message translates to:
  /// **'分貝 (dB)'**
  String get noiseMeterDb;

  /// Noise meter: Reference volume
  ///
  /// In zh, this message translates to:
  /// **'參考音量'**
  String get noiseMeterReference;

  /// Noise meter: Whisper
  ///
  /// In zh, this message translates to:
  /// **'耳語'**
  String get noiseMeterWhisper;

  /// Noise meter: Conversation
  ///
  /// In zh, this message translates to:
  /// **'對話'**
  String get noiseMeterConversation;

  /// Noise meter: Traffic
  ///
  /// In zh, this message translates to:
  /// **'交通'**
  String get noiseMeterTraffic;

  /// Noise meter: Concert
  ///
  /// In zh, this message translates to:
  /// **'演唱會'**
  String get noiseMeterConcert;

  /// Flashlight: SOS mode active
  ///
  /// In zh, this message translates to:
  /// **'SOS 模式啟動中'**
  String get flashlightSosMode;

  /// Flashlight: On status
  ///
  /// In zh, this message translates to:
  /// **'已開啟'**
  String get flashlightOn;

  /// Flashlight: Off status
  ///
  /// In zh, this message translates to:
  /// **'已關閉'**
  String get flashlightOff;

  /// Stopwatch: Tab title
  ///
  /// In zh, this message translates to:
  /// **'碼錶'**
  String get stopwatchTitle;

  /// Timer: Tab title
  ///
  /// In zh, this message translates to:
  /// **'計時器'**
  String get timerTitle;

  /// Stopwatch: Start button
  ///
  /// In zh, this message translates to:
  /// **'開始'**
  String get stopwatchStart;

  /// Stopwatch: Pause button
  ///
  /// In zh, this message translates to:
  /// **'暫停'**
  String get stopwatchPause;

  /// Stopwatch: Lap button
  ///
  /// In zh, this message translates to:
  /// **'分圈'**
  String get stopwatchLap;

  /// Stopwatch: Continue button
  ///
  /// In zh, this message translates to:
  /// **'繼續'**
  String get stopwatchContinue;

  /// Stopwatch: Reset confirm dialog
  ///
  /// In zh, this message translates to:
  /// **'確定要重設嗎？'**
  String get stopwatchResetConfirm;

  /// Timer: Quick set 3 minutes
  ///
  /// In zh, this message translates to:
  /// **'3 分鐘'**
  String get stopwatchQuickSet3;

  /// Timer: Quick set 5 minutes
  ///
  /// In zh, this message translates to:
  /// **'5 分鐘'**
  String get stopwatchQuickSet5;

  /// Timer: Quick set 10 minutes
  ///
  /// In zh, this message translates to:
  /// **'10 分鐘'**
  String get stopwatchQuickSet10;

  /// Timer: Quick set 15 minutes
  ///
  /// In zh, this message translates to:
  /// **'15 分鐘'**
  String get stopwatchQuickSet15;

  /// Timer: Quick set 30 minutes
  ///
  /// In zh, this message translates to:
  /// **'30 分鐘'**
  String get stopwatchQuickSet30;

  /// Timer: Repeat button
  ///
  /// In zh, this message translates to:
  /// **'再來一次'**
  String get stopwatchRepeat;

  /// Stopwatch: Export/copy lap records
  ///
  /// In zh, this message translates to:
  /// **'複製分圈紀錄'**
  String get stopwatchExportLaps;

  /// Stopwatch: Lap records copied snackbar
  ///
  /// In zh, this message translates to:
  /// **'分圈紀錄已複製'**
  String get stopwatchLapsExported;

  /// Password: Length label
  ///
  /// In zh, this message translates to:
  /// **'密碼長度'**
  String get passwordLength;

  /// Password: Character types label
  ///
  /// In zh, this message translates to:
  /// **'字元類型'**
  String get passwordCharTypes;

  /// Password: Uppercase option
  ///
  /// In zh, this message translates to:
  /// **'大寫字母 (A-Z)'**
  String get passwordUppercase;

  /// Password: Lowercase option
  ///
  /// In zh, this message translates to:
  /// **'小寫字母 (a-z)'**
  String get passwordLowercase;

  /// Password: Digits option
  ///
  /// In zh, this message translates to:
  /// **'數字 (0-9)'**
  String get passwordDigits;

  /// Password: Special chars option
  ///
  /// In zh, this message translates to:
  /// **'特殊字元 (!@#\$...)'**
  String get passwordSpecial;

  /// Password: Strength label
  ///
  /// In zh, this message translates to:
  /// **'強度'**
  String get passwordStrength;

  /// Password: Weak strength
  ///
  /// In zh, this message translates to:
  /// **'弱'**
  String get passwordStrengthWeak;

  /// Password: Medium strength
  ///
  /// In zh, this message translates to:
  /// **'中等'**
  String get passwordStrengthMedium;

  /// Password: Strong strength
  ///
  /// In zh, this message translates to:
  /// **'強'**
  String get passwordStrengthStrong;

  /// Password: Very strong strength
  ///
  /// In zh, this message translates to:
  /// **'非常強'**
  String get passwordStrengthVeryStrong;

  /// Password: Generate button
  ///
  /// In zh, this message translates to:
  /// **'產生新密碼'**
  String get passwordGenerate;

  /// Password: Minimum one character type required
  ///
  /// In zh, this message translates to:
  /// **'至少需選擇一種字元類型'**
  String get passwordMinOneType;

  /// Password: Memorable mode toggle
  ///
  /// In zh, this message translates to:
  /// **'易記模式'**
  String get passwordMemorable;

  /// Password: Word count for memorable mode
  ///
  /// In zh, this message translates to:
  /// **'單詞數量'**
  String get passwordWordCount;

  /// Password: History section title
  ///
  /// In zh, this message translates to:
  /// **'密碼歷史'**
  String get passwordHistory;

  /// Password: Clear history button
  ///
  /// In zh, this message translates to:
  /// **'清除歷史'**
  String get passwordClearHistory;

  /// Password: Show password toggle
  ///
  /// In zh, this message translates to:
  /// **'顯示密碼'**
  String get passwordShowPassword;

  /// Password: Hide password toggle
  ///
  /// In zh, this message translates to:
  /// **'隱藏密碼'**
  String get passwordHidePassword;

  /// Color picker: Pick color section
  ///
  /// In zh, this message translates to:
  /// **'擷取色值'**
  String get colorPickerTitle;

  /// Color picker: History section
  ///
  /// In zh, this message translates to:
  /// **'歷史記錄'**
  String get colorPickerHistory;

  /// Color picker: Camera permission needed
  ///
  /// In zh, this message translates to:
  /// **'需要相機權限'**
  String get colorPickerPermission;

  /// Color picker: HSL format label
  ///
  /// In zh, this message translates to:
  /// **'HSL'**
  String get colorPickerHsl;

  /// Color picker: Gallery button
  ///
  /// In zh, this message translates to:
  /// **'從相簿選取'**
  String get colorPickerGallery;

  /// Color picker: Camera button
  ///
  /// In zh, this message translates to:
  /// **'相機'**
  String get colorPickerCamera;

  /// Color picker: Tap image hint
  ///
  /// In zh, this message translates to:
  /// **'點擊圖片取色'**
  String get colorPickerTapToPickColor;

  /// Color picker: Clear history button
  ///
  /// In zh, this message translates to:
  /// **'清除歷史'**
  String get colorPickerClearHistory;

  /// QR generator: Input label
  ///
  /// In zh, this message translates to:
  /// **'輸入內容'**
  String get qrGeneratorInput;

  /// QR generator: Input hint
  ///
  /// In zh, this message translates to:
  /// **'請輸入內容'**
  String get qrGeneratorInputHint;

  /// QR generator: Generate button
  ///
  /// In zh, this message translates to:
  /// **'產生 QR Code'**
  String get qrGeneratorGenerate;

  /// QR generator: Type text
  ///
  /// In zh, this message translates to:
  /// **'文字'**
  String get qrTypeText;

  /// QR generator: Type WiFi
  ///
  /// In zh, this message translates to:
  /// **'WiFi'**
  String get qrTypeWifi;

  /// QR generator: Type Email
  ///
  /// In zh, this message translates to:
  /// **'Email'**
  String get qrTypeEmail;

  /// QR generator: WiFi SSID label
  ///
  /// In zh, this message translates to:
  /// **'WiFi 名稱 (SSID)'**
  String get qrWifiSsid;

  /// QR generator: WiFi password label
  ///
  /// In zh, this message translates to:
  /// **'WiFi 密碼'**
  String get qrWifiPassword;

  /// QR generator: WiFi encryption label
  ///
  /// In zh, this message translates to:
  /// **'加密方式'**
  String get qrWifiEncryption;

  /// QR generator: Email recipient label
  ///
  /// In zh, this message translates to:
  /// **'收件人'**
  String get qrEmailTo;

  /// QR generator: Email subject label
  ///
  /// In zh, this message translates to:
  /// **'主旨'**
  String get qrEmailSubject;

  /// QR generator: Email body label
  ///
  /// In zh, this message translates to:
  /// **'內文'**
  String get qrEmailBody;

  /// Random wheel: Page title
  ///
  /// In zh, this message translates to:
  /// **'隨機轉盤'**
  String get randomWheelTitle;

  /// Random wheel: Spin button
  ///
  /// In zh, this message translates to:
  /// **'旋轉！'**
  String get randomWheelSpin;

  /// Random wheel: Options list title
  ///
  /// In zh, this message translates to:
  /// **'選項清單'**
  String get randomWheelOptions;

  /// Random wheel: Add option button
  ///
  /// In zh, this message translates to:
  /// **'新增選項'**
  String get randomWheelAddOption;

  /// Random wheel: Option input hint
  ///
  /// In zh, this message translates to:
  /// **'輸入選項名稱…'**
  String get randomWheelOptionHint;

  /// Random wheel: Max options reached
  ///
  /// In zh, this message translates to:
  /// **'已達上限（{max} 個）'**
  String randomWheelMaxReached(int max);

  /// Random wheel: Delete dialog title
  ///
  /// In zh, this message translates to:
  /// **'刪除選項'**
  String get randomWheelDeleteTitle;

  /// Random wheel: Delete confirm message
  ///
  /// In zh, this message translates to:
  /// **'確定要刪除「{name}」嗎？'**
  String randomWheelDeleteMessage(String name);

  /// Random wheel: Default option prefix
  ///
  /// In zh, this message translates to:
  /// **'選項'**
  String get randomWheelDefaultOption;

  /// Unit converter: Length category
  ///
  /// In zh, this message translates to:
  /// **'長度'**
  String get unitLength;

  /// Unit converter: Weight category
  ///
  /// In zh, this message translates to:
  /// **'重量'**
  String get unitWeight;

  /// Unit converter: Area category
  ///
  /// In zh, this message translates to:
  /// **'面積'**
  String get unitArea;

  /// Unit converter: Temperature category
  ///
  /// In zh, this message translates to:
  /// **'溫度'**
  String get unitTemperature;

  /// Unit converter: Year category
  ///
  /// In zh, this message translates to:
  /// **'年份'**
  String get unitYear;

  /// Snackbar: copied to clipboard
  ///
  /// In zh, this message translates to:
  /// **'已複製到剪貼簿'**
  String get copiedToClipboard;

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

  /// Mode: Single conversion
  ///
  /// In zh, this message translates to:
  /// **'一對一'**
  String get tool_currency_converter_mode_single;

  /// Mode: Multi-currency
  ///
  /// In zh, this message translates to:
  /// **'一對多'**
  String get tool_currency_converter_mode_multi;

  /// Multi mode: target currencies label
  ///
  /// In zh, this message translates to:
  /// **'目標幣別'**
  String get tool_currency_converter_multi_targets;

  /// Cache expired warning
  ///
  /// In zh, this message translates to:
  /// **'匯率資料已超過 24 小時，建議重新整理'**
  String get tool_currency_converter_cache_expired;

  /// Refresh button label
  ///
  /// In zh, this message translates to:
  /// **'重新整理'**
  String get tool_currency_converter_refresh;

  /// Timeout error message
  ///
  /// In zh, this message translates to:
  /// **'連線逾時，請檢查網路後重試'**
  String get tool_currency_converter_timeout;

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

  /// Calculator: Clear history dialog title
  ///
  /// In zh, this message translates to:
  /// **'清除歷史紀錄'**
  String get calculatorClearHistoryTitle;

  /// Calculator: Clear history dialog message
  ///
  /// In zh, this message translates to:
  /// **'確定要清除所有計算歷史紀錄嗎？此操作無法復原。'**
  String get calculatorClearHistoryMessage;

  /// Calculator: Search history hint
  ///
  /// In zh, this message translates to:
  /// **'搜尋歷史紀錄...'**
  String get calculatorSearchHistory;

  /// Unit converter: Result label
  ///
  /// In zh, this message translates to:
  /// **'結果'**
  String get unitConverterResult;

  /// Unit converter: Invalid number message
  ///
  /// In zh, this message translates to:
  /// **'請輸入有效數字'**
  String get unitConverterInvalidNumber;

  /// Unit converter: Category label
  ///
  /// In zh, this message translates to:
  /// **'類別'**
  String get unitConverterCategory;

  /// Unit converter: Source label
  ///
  /// In zh, this message translates to:
  /// **'來源'**
  String get unitConverterSource;

  /// Unit converter: Input value label
  ///
  /// In zh, this message translates to:
  /// **'輸入數值'**
  String get unitConverterInputValue;

  /// Unit converter: Input hint
  ///
  /// In zh, this message translates to:
  /// **'請輸入數字'**
  String get unitConverterInputHint;

  /// Unit converter: Target label
  ///
  /// In zh, this message translates to:
  /// **'目標'**
  String get unitConverterTarget;

  /// BMI: Category label
  ///
  /// In zh, this message translates to:
  /// **'分類：'**
  String get bmiCategory;

  /// BMI: Healthy weight range
  ///
  /// In zh, this message translates to:
  /// **'建議體重範圍：{min} – {max} kg'**
  String bmiHealthyRange(String min, String max);

  /// Split bill: First person pays extra with total
  ///
  /// In zh, this message translates to:
  /// **'第 1 人多付 {remainder} 元（共付 \${firstTotal}）'**
  String splitBillFirstPaysDetail(int remainder, String firstTotal);

  /// Split bill: Per person semantic label
  ///
  /// In zh, this message translates to:
  /// **'每人應付 {amount} 元'**
  String splitBillPerPersonSemantic(String amount);

  /// Split bill: First person pays extra (share card)
  ///
  /// In zh, this message translates to:
  /// **'第 1 人多付 {remainder} 元'**
  String splitBillShareFirstPays(int remainder);

  /// Split bill: Summary in header
  ///
  /// In zh, this message translates to:
  /// **'\${total} ÷ {count} 人'**
  String splitBillSummary(String total, int count);

  /// Tool name: Word Counter
  ///
  /// In zh, this message translates to:
  /// **'文字計數器'**
  String get toolWordCounter;

  /// Word counter page title
  ///
  /// In zh, this message translates to:
  /// **'文字計數器'**
  String get wordCounterTitle;

  /// Word counter text field hint
  ///
  /// In zh, this message translates to:
  /// **'在這裡輸入或貼上文字...'**
  String get wordCounterInputHint;

  /// Characters including spaces
  ///
  /// In zh, this message translates to:
  /// **'字元（含空白）'**
  String get wordCounterCharsWithSpaces;

  /// Characters excluding spaces
  ///
  /// In zh, this message translates to:
  /// **'字元（不含空白）'**
  String get wordCounterCharsNoSpaces;

  /// Word count label
  ///
  /// In zh, this message translates to:
  /// **'字數'**
  String get wordCounterWords;

  /// Line count label
  ///
  /// In zh, this message translates to:
  /// **'行數'**
  String get wordCounterLines;

  /// Paragraph count label
  ///
  /// In zh, this message translates to:
  /// **'段落數'**
  String get wordCounterParagraphs;

  /// Reading time label
  ///
  /// In zh, this message translates to:
  /// **'閱讀時間'**
  String get wordCounterReadingTime;

  /// Reading time value
  ///
  /// In zh, this message translates to:
  /// **'{minutes} 分鐘'**
  String wordCounterReadingTimeValue(int minutes);

  /// Reading time less than 1 minute
  ///
  /// In zh, this message translates to:
  /// **'< 1 分鐘'**
  String get wordCounterReadingTimeLessThan1;

  /// Snackbar after copying summary
  ///
  /// In zh, this message translates to:
  /// **'已複製統計摘要'**
  String get wordCounterCopiedSummary;

  /// Tool name: Pomodoro Timer
  ///
  /// In zh, this message translates to:
  /// **'番茄鐘'**
  String get toolPomodoro;

  /// Pomodoro page title
  ///
  /// In zh, this message translates to:
  /// **'番茄鐘'**
  String get pomodoroTitle;

  /// Work phase label
  ///
  /// In zh, this message translates to:
  /// **'工作'**
  String get pomodoroWork;

  /// Short break label
  ///
  /// In zh, this message translates to:
  /// **'短休息'**
  String get pomodoroShortBreak;

  /// Long break label
  ///
  /// In zh, this message translates to:
  /// **'長休息'**
  String get pomodoroLongBreak;

  /// Start button
  ///
  /// In zh, this message translates to:
  /// **'開始'**
  String get pomodoroStart;

  /// Pause button
  ///
  /// In zh, this message translates to:
  /// **'暫停'**
  String get pomodoroPause;

  /// Resume button
  ///
  /// In zh, this message translates to:
  /// **'繼續'**
  String get pomodoroResume;

  /// Reset button
  ///
  /// In zh, this message translates to:
  /// **'重設'**
  String get pomodoroReset;

  /// Skip phase button
  ///
  /// In zh, this message translates to:
  /// **'跳過'**
  String get pomodoroSkip;

  /// Session counter
  ///
  /// In zh, this message translates to:
  /// **'第 {current} / {total} 個番茄'**
  String pomodoroSession(int current, int total);

  /// Work duration setting
  ///
  /// In zh, this message translates to:
  /// **'工作時長'**
  String get pomodoroWorkDuration;

  /// Short break duration setting
  ///
  /// In zh, this message translates to:
  /// **'短休息時長'**
  String get pomodoroShortBreakDuration;

  /// Long break duration setting
  ///
  /// In zh, this message translates to:
  /// **'長休息時長'**
  String get pomodoroLongBreakDuration;

  /// Duration in minutes
  ///
  /// In zh, this message translates to:
  /// **'{minutes} 分鐘'**
  String pomodoroMinutes(int minutes);

  /// White noise section title
  ///
  /// In zh, this message translates to:
  /// **'白噪音'**
  String get pomodoroWhiteNoise;

  /// Rain noise option
  ///
  /// In zh, this message translates to:
  /// **'雨聲'**
  String get pomodoroNoiseRain;

  /// Cafe noise option
  ///
  /// In zh, this message translates to:
  /// **'咖啡廳'**
  String get pomodoroNoiseCafe;

  /// Forest noise option
  ///
  /// In zh, this message translates to:
  /// **'森林'**
  String get pomodoroNoiseForest;

  /// Today stats section title
  ///
  /// In zh, this message translates to:
  /// **'今日專注'**
  String get pomodoroTodayStats;

  /// Today completed count
  ///
  /// In zh, this message translates to:
  /// **'{count} 個番茄'**
  String pomodoroTodayCount(int count);

  /// Today focus minutes
  ///
  /// In zh, this message translates to:
  /// **'{minutes} 分鐘'**
  String pomodoroTodayMinutes(int minutes);

  /// Settings section title
  ///
  /// In zh, this message translates to:
  /// **'設定'**
  String get pomodoroSettings;

  /// Phase complete notification title
  ///
  /// In zh, this message translates to:
  /// **'階段完成'**
  String get pomodoroPhaseComplete;

  /// Work phase complete message
  ///
  /// In zh, this message translates to:
  /// **'工作時間結束，休息一下吧！'**
  String get pomodoroWorkComplete;

  /// Break phase complete message
  ///
  /// In zh, this message translates to:
  /// **'休息結束，繼續加油！'**
  String get pomodoroBreakComplete;

  /// Tool name: Quick Notes
  ///
  /// In zh, this message translates to:
  /// **'快速筆記'**
  String get toolQuickNotes;

  /// Quick notes page title
  ///
  /// In zh, this message translates to:
  /// **'快速筆記'**
  String get quickNotesTitle;

  /// Empty state message
  ///
  /// In zh, this message translates to:
  /// **'還沒有筆記'**
  String get quickNotesEmpty;

  /// Empty state hint
  ///
  /// In zh, this message translates to:
  /// **'點擊右下角按鈕開始記錄'**
  String get quickNotesEmptyHint;

  /// Search field hint
  ///
  /// In zh, this message translates to:
  /// **'搜尋筆記...'**
  String get quickNotesSearchHint;

  /// New note tooltip
  ///
  /// In zh, this message translates to:
  /// **'新增筆記'**
  String get quickNotesNewNote;

  /// Edit note page title
  ///
  /// In zh, this message translates to:
  /// **'編輯筆記'**
  String get quickNotesEditNote;

  /// Note title hint
  ///
  /// In zh, this message translates to:
  /// **'標題（選填）'**
  String get quickNotesTitleHint;

  /// Note content hint
  ///
  /// In zh, this message translates to:
  /// **'開始記錄...'**
  String get quickNotesContentHint;

  /// Delete confirmation title
  ///
  /// In zh, this message translates to:
  /// **'刪除筆記'**
  String get quickNotesDeleteTitle;

  /// Delete confirmation message
  ///
  /// In zh, this message translates to:
  /// **'確定要刪除這則筆記嗎？此操作無法復原。'**
  String get quickNotesDeleteMessage;

  /// Just now time label
  ///
  /// In zh, this message translates to:
  /// **'剛剛'**
  String get quickNotesUpdated;

  /// Minutes ago label
  ///
  /// In zh, this message translates to:
  /// **'{minutes} 分鐘前'**
  String quickNotesMinutesAgo(int minutes);

  /// Hours ago label
  ///
  /// In zh, this message translates to:
  /// **'{hours} 小時前'**
  String quickNotesHoursAgo(int hours);

  /// Days ago label
  ///
  /// In zh, this message translates to:
  /// **'{days} 天前'**
  String quickNotesDaysAgo(int days);

  /// Note count
  ///
  /// In zh, this message translates to:
  /// **'{count} 則筆記'**
  String quickNotesCount(int count);

  /// Daily recommendation section title
  ///
  /// In zh, this message translates to:
  /// **'今日推薦'**
  String get homeDailyRecommend;

  /// Daily recommendation hint
  ///
  /// In zh, this message translates to:
  /// **'試試這個工具吧！'**
  String get homeDailyRecommendHint;

  /// Streak display
  ///
  /// In zh, this message translates to:
  /// **'連續 {days} 天'**
  String homeStreak(int days);

  /// BMI share hook
  ///
  /// In zh, this message translates to:
  /// **'我的 BMI 是 {value}，你呢？'**
  String shareHookBmi(String value);

  /// Noise meter share hook
  ///
  /// In zh, this message translates to:
  /// **'我測到 {value} dB，你的環境有多吵？'**
  String shareHookNoise(String value);

  /// Split bill share hook
  ///
  /// In zh, this message translates to:
  /// **'帳單算好了！快來看看誰該付多少 💰'**
  String get shareHookSplitBill;

  /// Password generator share hook
  ///
  /// In zh, this message translates to:
  /// **'我用工具箱產生了超強密碼，你也來試試！🔐'**
  String get shareHookPassword;

  /// Default share hook
  ///
  /// In zh, this message translates to:
  /// **'我在用工具箱 Pro，超好用！'**
  String get shareHookDefault;

  /// Accent color setting title
  ///
  /// In zh, this message translates to:
  /// **'主題色'**
  String get settingsAccentColor;

  /// Purple accent
  ///
  /// In zh, this message translates to:
  /// **'紫色'**
  String get accentColorPurple;

  /// Blue accent
  ///
  /// In zh, this message translates to:
  /// **'藍色'**
  String get accentColorBlue;

  /// Green accent
  ///
  /// In zh, this message translates to:
  /// **'綠色'**
  String get accentColorGreen;

  /// Red accent
  ///
  /// In zh, this message translates to:
  /// **'紅色'**
  String get accentColorRed;

  /// Orange accent
  ///
  /// In zh, this message translates to:
  /// **'橘色'**
  String get accentColorOrange;

  /// Pink accent
  ///
  /// In zh, this message translates to:
  /// **'粉色'**
  String get accentColorPink;

  /// Reorder tools button tooltip
  ///
  /// In zh, this message translates to:
  /// **'排列工具'**
  String get homeReorderTools;

  /// Reorder bottom sheet title
  ///
  /// In zh, this message translates to:
  /// **'排列工具順序'**
  String get reorderToolsTitle;

  /// Reorder hint text
  ///
  /// In zh, this message translates to:
  /// **'長按拖曳以調整順序'**
  String get reorderToolsHint;

  /// Accessibility label for search button
  ///
  /// In zh, this message translates to:
  /// **'搜尋工具'**
  String get a11ySearchTools;

  /// Accessibility label for sort button
  ///
  /// In zh, this message translates to:
  /// **'排列工具順序'**
  String get a11yReorderTools;

  /// Accessibility label for add favorite
  ///
  /// In zh, this message translates to:
  /// **'加入收藏'**
  String get a11yAddFavorite;

  /// Accessibility label for remove favorite
  ///
  /// In zh, this message translates to:
  /// **'移除收藏'**
  String get a11yRemoveFavorite;

  /// Accessibility: minutes
  ///
  /// In zh, this message translates to:
  /// **'{count} 分鐘'**
  String a11yMinutes(int count);

  /// Accessibility: centimeters
  ///
  /// In zh, this message translates to:
  /// **'{value} 公分'**
  String a11yCm(int value);

  /// Accessibility: kilograms
  ///
  /// In zh, this message translates to:
  /// **'{value} 公斤'**
  String a11yKg(int value);
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
