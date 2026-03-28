import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_first_app/services/pro_service.dart';
import 'package:my_first_app/services/in_app_purchase_service.dart';

/// 為測試環境建立 ProService（免費用戶）。
///
/// 必須在 setUp 或 test body 中先呼叫
/// `SharedPreferences.setMockInitialValues({})` 再使用。
Future<ProService> createTestProService() async {
  final proService = ProService();
  await proService.init();
  return proService;
}

/// 包裝 child widget，注入 ProService + InAppPurchaseService Provider。
///
/// 用法：
/// ```dart
/// await tester.pumpWidget(
///   wrapWithProProvider(child: const MyToolPage()),
/// );
/// ```
Widget wrapWithProProvider({required Widget child, ProService? proService}) {
  final ps = proService ?? ProService();
  return ChangeNotifierProvider<ProService>.value(value: ps, child: child);
}
