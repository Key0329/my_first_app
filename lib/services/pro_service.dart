import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 管理 Pro 訂閱狀態的服務。
///
/// 以 SharedPreferences 持久化 `isPro` 狀態，不依賴網路。
/// 購買/回復購買成功後由 [InAppPurchaseService] 呼叫 [setPro(true)]。
///
/// 使用方式：
/// ```dart
/// // 於 MultiProvider 中注入
/// ChangeNotifierProvider<ProService>(create: (_) => ProService()..init()),
///
/// // 在 Widget 中讀取
/// final isPro = context.watch<ProService>().isPro;
/// ```
class ProService extends ChangeNotifier {
  static const _keyIsPro = 'is_pro';

  late final SharedPreferences _prefs;
  bool _isPro = false;

  bool get isPro => _isPro;

  /// 從 SharedPreferences 載入 Pro 狀態。
  /// App 啟動時於 [main()] 呼叫。
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    _isPro = _prefs.getBool(_keyIsPro) ?? false;
  }

  /// 設定 Pro 狀態並持久化。
  ///
  /// 購買成功或回復購買成功後呼叫 [setPro(true)]。
  Future<void> setPro(bool value) async {
    if (_isPro == value) return;
    _isPro = value;
    notifyListeners();
    await _prefs.setBool(_keyIsPro, value);
  }
}
