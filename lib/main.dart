import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:my_first_app/app.dart';
import 'package:my_first_app/services/analytics_service.dart';
import 'package:my_first_app/services/settings_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase 初始化（缺少配置檔時安全跳過）
  try {
    await Firebase.initializeApp();
    AnalyticsService.instance.init(FirebaseAnalytics.instance);

    // Crashlytics 錯誤回報
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  } catch (e) {
    debugPrint('Firebase 初始化跳過: $e');
  }

  final settings = AppSettings();
  await settings.init();
  runApp(ToolboxApp(settings: settings));
}
