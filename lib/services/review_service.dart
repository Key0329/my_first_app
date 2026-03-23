import 'package:flutter/foundation.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// App 評分引導服務。
///
/// 追蹤累計工具使用次數，達到閾值時觸發原生 App Store / Google Play 評分對話框。
/// 每位用戶只嘗試觸發一次。
class ReviewService {
  ReviewService._();

  static final ReviewService instance = ReviewService._();

  static const _keyToolUseCount = 'review_tool_use_count';
  static const _keyReviewPrompted = 'review_prompted';

  /// 累計使用幾次工具後觸發評分提示。
  static const int threshold = 3;

  /// 允許注入 [InAppReview] 以便測試。
  @visibleForTesting
  InAppReview? inAppReviewOverride;

  InAppReview get _inAppReview => inAppReviewOverride ?? InAppReview.instance;

  /// 記錄一次工具使用，並在達到閾值時嘗試觸發評分對話框。
  Future<void> recordToolUseAndPrompt() async {
    final prefs = await SharedPreferences.getInstance();

    // 已觸發過，不再嘗試
    if (prefs.getBool(_keyReviewPrompted) ?? false) return;

    final count = (prefs.getInt(_keyToolUseCount) ?? 0) + 1;
    await prefs.setInt(_keyToolUseCount, count);

    if (count >= threshold) {
      await prefs.setBool(_keyReviewPrompted, true);
      try {
        if (await _inAppReview.isAvailable()) {
          await _inAppReview.requestReview();
        }
      } catch (e) {
        debugPrint('評分提示觸發失敗: $e');
      }
    }
  }
}
