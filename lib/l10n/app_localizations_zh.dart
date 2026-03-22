// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => '工具箱 Pro';

  @override
  String get tabTools => '工具';

  @override
  String get tabFavorites => '收藏';

  @override
  String get tabSettings => '設定';

  @override
  String get toolCalculator => '計算機';

  @override
  String get toolUnitConverter => '單位換算';

  @override
  String get toolQrGenerator => 'QR Code 產生器';

  @override
  String get toolFlashlight => '手電筒';

  @override
  String get toolLevel => '水平儀';

  @override
  String get toolCompass => '指南針';

  @override
  String get toolStopwatch => '碼錶';

  @override
  String get toolNoiseMeter => '噪音計';

  @override
  String get toolPasswordGenerator => '密碼產生器';

  @override
  String get toolColorPicker => '色彩擷取';

  @override
  String get toolProtractor => '量角器';

  @override
  String get toolBmiCalculator => 'BMI 計算機';

  @override
  String get toolSplitBill => 'AA 制分帳';

  @override
  String get toolRandomWheel => '隨機決定器';

  @override
  String get toolScreenRuler => '螢幕尺規';

  @override
  String get searchHint => '搜尋工具...';

  @override
  String get favoritesEmpty => '尚未收藏任何工具';

  @override
  String get favoritesEmptyHint => '長按工具卡片即可加入收藏';

  @override
  String get settingsAppearance => '外觀';

  @override
  String get settingsLanguage => '語言';

  @override
  String get settingsAbout => '關於';

  @override
  String get settingsThemeMode => '主題模式';

  @override
  String get settingsThemeLight => '亮色';

  @override
  String get settingsThemeDark => '暗色';

  @override
  String get settingsThemeSystem => '跟隨系統';

  @override
  String get settingsVersion => '版本';

  @override
  String get settingsPrivacyPolicy => '隱私政策';

  @override
  String get settingsTermsOfService => '使用條款';

  @override
  String get toolCurrencyConverter => '匯率換算';

  @override
  String get tool_currency_converter_title => '匯率換算';

  @override
  String get tool_currency_converter_from => '來源幣別';

  @override
  String get tool_currency_converter_to => '目標幣別';

  @override
  String get tool_currency_converter_amount => '金額';

  @override
  String get tool_currency_converter_amount_hint => '請輸入金額';

  @override
  String get tool_currency_converter_result => '結果';

  @override
  String get tool_currency_converter_swap => '交換幣別';

  @override
  String get tool_currency_converter_loading => '載入匯率中...';

  @override
  String get tool_currency_converter_offline => '離線模式';

  @override
  String get tool_currency_converter_offline_hint => '使用快取匯率資料';

  @override
  String tool_currency_converter_last_updated(String date) {
    return '最後更新：$date';
  }

  @override
  String get tool_currency_converter_error => '無法載入匯率資料';

  @override
  String get tool_currency_converter_network_required => '首次使用需要網路連線';

  @override
  String get tool_currency_converter_retry => '重試';

  @override
  String get tool_currency_converter_select_currency => '選擇幣別';

  @override
  String get toolQrScannerLive => 'QR Code 掃描器';

  @override
  String get tool_qr_scanner_live_title => 'QR Code 掃描器';

  @override
  String get tool_qr_scanner_live_scan_hint => '將 QR Code 對準掃描框';

  @override
  String get tool_qr_scanner_live_result => '掃描結果';

  @override
  String get tool_qr_scanner_live_type_url => 'URL';

  @override
  String get tool_qr_scanner_live_type_text => '文字';

  @override
  String get tool_qr_scanner_live_copy => '複製';

  @override
  String get tool_qr_scanner_live_rescan => '重新掃描';

  @override
  String get tool_qr_scanner_live_copied => '已複製到剪貼簿';

  @override
  String get tool_qr_scanner_live_url_hint => '複製網址後可在瀏覽器中開啟';

  @override
  String get tool_qr_scanner_live_permission_title => '需要相機權限';

  @override
  String get tool_qr_scanner_live_permission_message => '請在系統設定中允許此 App 使用相機';

  @override
  String get tool_qr_scanner_live_permission_retry => '重新嘗試';

  @override
  String get tool_qr_scanner_live_permission_section => '相機權限';

  @override
  String get tool_qr_scanner_live_permission_guidance =>
      '請前往系統設定開啟相機權限，才能使用掃描功能。';

  @override
  String get tool_qr_scanner_live_error_title => '相機啟動失敗';

  @override
  String get tool_qr_scanner_live_error_message => '請確認相機功能正常後重試';

  @override
  String get toolDateCalculator => '日期計算機';

  @override
  String get tool_date_calculator_title => '日期計算機';

  @override
  String get tool_date_calculator_tab_interval => '日期區間';

  @override
  String get tool_date_calculator_tab_add_sub => '加減天數';

  @override
  String get tool_date_calculator_tab_business => '工作日';

  @override
  String get tool_date_calculator_start_date => '開始日期';

  @override
  String get tool_date_calculator_end_date => '結束日期';

  @override
  String get tool_date_calculator_base_date => '基準日期';

  @override
  String get tool_date_calculator_days => '天數';

  @override
  String get tool_date_calculator_enter_days => '輸入天數';

  @override
  String get tool_date_calculator_add => '加';

  @override
  String get tool_date_calculator_subtract => '減';

  @override
  String get tool_date_calculator_target_date => '目標日期';

  @override
  String tool_date_calculator_result_days(int count) {
    return '$count 天';
  }

  @override
  String tool_date_calculator_result_weeks(int weeks, int days) {
    return '$weeks 週 $days 天';
  }

  @override
  String tool_date_calculator_result_months(int months, int days) {
    return '$months 個月 $days 天';
  }

  @override
  String tool_date_calculator_result_business_days(int count) {
    return '$count 工作日';
  }

  @override
  String tool_date_calculator_result_calendar_days(int count) {
    return '$count 日曆天';
  }

  @override
  String tool_date_calculator_result_weekend_days(int count) {
    return '$count 天週末';
  }

  @override
  String get tool_date_calculator_interval_label => '日期區間';

  @override
  String get tool_date_calculator_business_label => '工作日計算';
}
