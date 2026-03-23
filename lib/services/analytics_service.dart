import 'package:flutter/foundation.dart';

/// Firebase Analytics 抽象層。
///
/// Singleton 設計，透過 [instance] 存取。
/// 在 Firebase 未初始化的環境（如測試）中，所有方法安全地 no-op。
class AnalyticsService {
  AnalyticsService._();

  static final AnalyticsService instance = AnalyticsService._();

  bool _initialized = false;
  dynamic
  _analytics; // FirebaseAnalytics instance, kept dynamic to avoid hard dep in tests

  /// 初始化 Analytics。由 main.dart 在 Firebase 初始化成功後呼叫。
  void init(dynamic firebaseAnalytics) {
    _analytics = firebaseAnalytics;
    _initialized = true;
  }

  /// 記錄自訂事件。
  Future<void> logEvent({
    required String name,
    Map<String, Object>? parameters,
  }) async {
    if (!_initialized || _analytics == null) return;
    try {
      await _analytics.logEvent(name: name, parameters: parameters);
    } catch (e) {
      debugPrint('Analytics logEvent 失敗: $e');
    }
  }

  /// 記錄工具開啟事件。
  void logToolOpen({required String toolId, required String source}) {
    logEvent(
      name: 'tool_open',
      parameters: {'tool_id': toolId, 'source': source},
    );
  }

  /// 記錄工具完成事件。
  void logToolComplete({required String toolId, required String resultType}) {
    logEvent(
      name: 'tool_complete',
      parameters: {'tool_id': toolId, 'result_type': resultType},
    );
  }

  /// 記錄工具分享事件。
  void logToolShare({required String toolId, required String shareMethod}) {
    logEvent(
      name: 'tool_share',
      parameters: {'tool_id': toolId, 'share_method': shareMethod},
    );
  }

  /// 記錄 tab 切換事件。
  void logTabSwitch({required String tabName}) {
    logEvent(name: 'tab_switch', parameters: {'tab_name': tabName});
  }

  /// 記錄頁面瀏覽事件。
  Future<void> logScreenView({required String screenName}) async {
    if (!_initialized || _analytics == null) return;
    try {
      await _analytics.logScreenView(
        screenClass: screenName,
        screenName: screenName,
      );
    } catch (e) {
      debugPrint('Analytics logScreenView 失敗: $e');
    }
  }
}
