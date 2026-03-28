import 'package:flutter/foundation.dart';

/// AdMob 廣告設定常數。
///
/// debug 模式使用 Google 官方測試 Ad Unit ID，
/// release 模式使用正式 ID（上架前替換）。
class AdConfig {
  AdConfig._();

  // ── Android 廣告單元 ID ──────────────────────────────────────
  static const String _androidTestBanner =
      'ca-app-pub-3940256099942544/6300978111';
  static const String _androidProdBanner =
      'ca-app-pub-XXXXXXXXXXXXXXXX/XXXXXXXXXX'; // TODO: 替換為正式 ID

  // ── iOS 廣告單元 ID ──────────────────────────────────────────
  static const String _iosTestBanner = 'ca-app-pub-3940256099942544/2934735716';
  static const String _iosProdBanner =
      'ca-app-pub-XXXXXXXXXXXXXXXX/XXXXXXXXXX'; // TODO: 替換為正式 ID

  /// 取得目前平台的 Banner 廣告單元 ID。
  ///
  /// debug build 永遠回傳測試 ID，
  /// release build 使用正式 ID。
  static String get bannerAdUnitId {
    if (kDebugMode) {
      return defaultTargetPlatform == TargetPlatform.iOS
          ? _iosTestBanner
          : _androidTestBanner;
    }
    return defaultTargetPlatform == TargetPlatform.iOS
        ? _iosProdBanner
        : _androidProdBanner;
  }

  /// AdMob App ID（僅作說明用，實際配置於 AndroidManifest.xml / Info.plist）
  ///
  /// - Android: ca-app-pub-XXXXXXXXXXXXXXXX~XXXXXXXXXX
  /// - iOS:     ca-app-pub-XXXXXXXXXXXXXXXX~XXXXXXXXXX
  static const String androidAppId =
      'ca-app-pub-3940256099942544~3347511713'; // 測試 App ID
  static const String iosAppId =
      'ca-app-pub-3940256099942544~1458002511'; // 測試 App ID
}
