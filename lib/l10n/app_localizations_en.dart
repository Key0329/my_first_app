// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Toolbox Pro';

  @override
  String get tabTools => 'Tools';

  @override
  String get tabFavorites => 'Favorites';

  @override
  String get tabSettings => 'Settings';

  @override
  String get toolCalculator => 'Calculator';

  @override
  String get toolUnitConverter => 'Unit Converter';

  @override
  String get toolQrGenerator => 'QR Generator';

  @override
  String get toolFlashlight => 'Flashlight';

  @override
  String get toolLevel => 'Level';

  @override
  String get toolCompass => 'Compass';

  @override
  String get toolStopwatch => 'Stopwatch';

  @override
  String get toolNoiseMeter => 'Noise Meter';

  @override
  String get toolPasswordGenerator => 'Password Generator';

  @override
  String get toolColorPicker => 'Color Picker';

  @override
  String get toolProtractor => 'Protractor';

  @override
  String get toolBmiCalculator => 'BMI Calculator';

  @override
  String get toolSplitBill => 'Split Bill';

  @override
  String get toolRandomWheel => 'Random Wheel';

  @override
  String get toolScreenRuler => 'Screen Ruler';

  @override
  String get searchHint => 'Search tools...';

  @override
  String get favoritesEmpty => 'No favorites yet';

  @override
  String get favoritesEmptyHint =>
      'Long press a tool card to add it to favorites';

  @override
  String get settingsAppearance => 'Appearance';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsAbout => 'About';

  @override
  String get settingsThemeMode => 'Theme Mode';

  @override
  String get settingsThemeLight => 'Light';

  @override
  String get settingsThemeDark => 'Dark';

  @override
  String get settingsThemeSystem => 'System';

  @override
  String get settingsVersion => 'Version';

  @override
  String get settingsPrivacyPolicy => 'Privacy Policy';

  @override
  String get settingsTermsOfService => 'Terms of Service';

  @override
  String get toolCurrencyConverter => 'Currency Converter';

  @override
  String get tool_currency_converter_title => 'Currency Converter';

  @override
  String get tool_currency_converter_from => 'From';

  @override
  String get tool_currency_converter_to => 'To';

  @override
  String get tool_currency_converter_amount => 'Amount';

  @override
  String get tool_currency_converter_amount_hint => 'Enter amount';

  @override
  String get tool_currency_converter_result => 'Result';

  @override
  String get tool_currency_converter_swap => 'Swap currencies';

  @override
  String get tool_currency_converter_loading => 'Loading rates...';

  @override
  String get tool_currency_converter_offline => 'Offline mode';

  @override
  String get tool_currency_converter_offline_hint => 'Using cached rates';

  @override
  String tool_currency_converter_last_updated(String date) {
    return 'Last updated: $date';
  }

  @override
  String get tool_currency_converter_error => 'Failed to load exchange rates';

  @override
  String get tool_currency_converter_network_required =>
      'Network connection required for first use';

  @override
  String get tool_currency_converter_retry => 'Retry';

  @override
  String get tool_currency_converter_select_currency => 'Select currency';

  @override
  String get toolQrScannerLive => 'QR Scanner';

  @override
  String get tool_qr_scanner_live_title => 'QR Code Scanner';

  @override
  String get tool_qr_scanner_live_scan_hint => 'Align QR Code within the frame';

  @override
  String get tool_qr_scanner_live_result => 'Scan Result';

  @override
  String get tool_qr_scanner_live_type_url => 'URL';

  @override
  String get tool_qr_scanner_live_type_text => 'Text';

  @override
  String get tool_qr_scanner_live_copy => 'Copy';

  @override
  String get tool_qr_scanner_live_rescan => 'Rescan';

  @override
  String get tool_qr_scanner_live_copied => 'Copied to clipboard';

  @override
  String get tool_qr_scanner_live_url_hint =>
      'Copy the URL and open it in a browser';

  @override
  String get tool_qr_scanner_live_permission_title =>
      'Camera Permission Required';

  @override
  String get tool_qr_scanner_live_permission_message =>
      'Please allow camera access in system settings';

  @override
  String get tool_qr_scanner_live_permission_retry => 'Retry';

  @override
  String get tool_qr_scanner_live_permission_section => 'Camera Permission';

  @override
  String get tool_qr_scanner_live_permission_guidance =>
      'Please enable camera permission in system settings to use the scanning feature.';

  @override
  String get tool_qr_scanner_live_error_title => 'Camera Failed';

  @override
  String get tool_qr_scanner_live_error_message =>
      'Please verify the camera is working and try again';

  @override
  String get toolDateCalculator => 'Date Calculator';

  @override
  String get tool_date_calculator_title => 'Date Calculator';

  @override
  String get tool_date_calculator_tab_interval => 'Date Interval';

  @override
  String get tool_date_calculator_tab_add_sub => 'Add/Sub Days';

  @override
  String get tool_date_calculator_tab_business => 'Business Days';

  @override
  String get tool_date_calculator_start_date => 'Start Date';

  @override
  String get tool_date_calculator_end_date => 'End Date';

  @override
  String get tool_date_calculator_base_date => 'Base Date';

  @override
  String get tool_date_calculator_days => 'Days';

  @override
  String get tool_date_calculator_enter_days => 'Enter number of days';

  @override
  String get tool_date_calculator_add => 'Add';

  @override
  String get tool_date_calculator_subtract => 'Subtract';

  @override
  String get tool_date_calculator_target_date => 'Target Date';

  @override
  String tool_date_calculator_result_days(int count) {
    return '$count days';
  }

  @override
  String tool_date_calculator_result_weeks(int weeks, int days) {
    return '$weeks weeks $days days';
  }

  @override
  String tool_date_calculator_result_months(int months, int days) {
    return '$months months $days days';
  }

  @override
  String tool_date_calculator_result_business_days(int count) {
    return '$count business days';
  }

  @override
  String tool_date_calculator_result_calendar_days(int count) {
    return '$count calendar days';
  }

  @override
  String tool_date_calculator_result_weekend_days(int count) {
    return '$count weekend days';
  }

  @override
  String get tool_date_calculator_interval_label => 'Date Interval';

  @override
  String get tool_date_calculator_business_label => 'Business Days Calculation';
}
