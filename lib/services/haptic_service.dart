import 'package:flutter/services.dart';

/// 全域觸覺反饋服務。
///
/// 封裝 [HapticFeedback] 的各層級方法，統一觸覺反饋策略：
/// - [light]：一般按鈕點擊、Tab 切換
/// - [medium]：收藏切換、Onboarding 頁面滑動
/// - [heavy]：轉盤結果揭曉、重要操作確認
/// - [selection]：滑桿拖動、選項切換
abstract final class HapticService {
  static void light() => HapticFeedback.lightImpact();
  static void medium() => HapticFeedback.mediumImpact();
  static void heavy() => HapticFeedback.heavyImpact();
  static void selection() => HapticFeedback.selectionClick();
}
