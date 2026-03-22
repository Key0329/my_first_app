import 'package:flutter/foundation.dart';
import 'package:home_widget/home_widget.dart';

/// 桌面 Widget 資料管理服務。
///
/// 封裝 [HomeWidget] 的資料寫入與更新操作，
/// 提供匯率 Widget 所需的資料推送功能。
class WidgetService {
  WidgetService._();

  static final WidgetService instance = WidgetService._();

  /// iOS App Group ID，用於 Flutter ↔ WidgetKit 資料共享。
  static const String appGroupId = 'group.com.spectra.toolbox';

  /// iOS Widget 名稱（對應 WidgetKit extension 的 kind）。
  static const String _iOSCalculatorWidgetName = 'CalculatorWidget';
  static const String _iOSCurrencyWidgetName = 'CurrencyWidget';

  /// Android Widget Provider 完整類別名稱。
  static const String _androidCalculatorWidgetName =
      'com.spectra.toolbox.widget.CalculatorWidgetProvider';
  static const String _androidCurrencyWidgetName =
      'com.spectra.toolbox.widget.CurrencyWidgetProvider';

  // ── 資料 key 常數 ──
  static const String keyCurrencyFrom = 'currency_from';
  static const String keyCurrencyTo = 'currency_to';
  static const String keyCurrencyRate = 'currency_rate';
  static const String keyCurrencyUpdated = 'currency_updated';

  /// 初始化 home_widget 的 App Group ID。
  Future<void> init() async {
    try {
      await HomeWidget.setAppGroupId(appGroupId);
    } catch (e) {
      debugPrint('WidgetService init 失敗: $e');
    }
  }

  /// 更新匯率 Widget 資料並觸發 Widget 刷新。
  Future<void> updateCurrencyWidget({
    required String fromCurrency,
    required String toCurrency,
    required String rate,
  }) async {
    try {
      await Future.wait([
        HomeWidget.saveWidgetData(keyCurrencyFrom, fromCurrency),
        HomeWidget.saveWidgetData(keyCurrencyTo, toCurrency),
        HomeWidget.saveWidgetData(keyCurrencyRate, rate),
        HomeWidget.saveWidgetData(
          keyCurrencyUpdated,
          DateTime.now().toIso8601String(),
        ),
      ]);

      // 觸發兩個平台的匯率 Widget 刷新
      await HomeWidget.updateWidget(
        iOSName: _iOSCurrencyWidgetName,
        androidName: _androidCurrencyWidgetName,
      );
    } catch (e) {
      debugPrint('更新匯率 Widget 失敗: $e');
    }
  }

  /// 觸發計算機 Widget 刷新（靜態 Widget，通常不需要更新資料）。
  Future<void> updateCalculatorWidget() async {
    try {
      await HomeWidget.updateWidget(
        iOSName: _iOSCalculatorWidgetName,
        androidName: _androidCalculatorWidgetName,
      );
    } catch (e) {
      debugPrint('更新計算機 Widget 失敗: $e');
    }
  }
}
