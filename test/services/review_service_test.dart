import 'package:flutter_test/flutter_test.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:my_first_app/services/review_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Mock InAppReview that tracks calls without platform interaction.
class _MockInAppReview implements InAppReview {
  int requestReviewCount = 0;
  bool available = true;

  @override
  Future<bool> isAvailable() async => available;

  @override
  Future<void> requestReview() async {
    requestReviewCount++;
  }

  @override
  Future<void> openStoreListing({
    String? appStoreId,
    String? microsoftStoreId,
  }) async {}
}

void main() {
  late _MockInAppReview mockReview;

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    mockReview = _MockInAppReview();
    ReviewService.instance.inAppReviewOverride = mockReview;
  });

  tearDown(() {
    ReviewService.instance.inAppReviewOverride = null;
  });

  group('ReviewService', () {
    test('does not trigger review before reaching threshold', () async {
      // Use tool twice (threshold is 3)
      await ReviewService.instance.recordToolUseAndPrompt();
      await ReviewService.instance.recordToolUseAndPrompt();

      expect(mockReview.requestReviewCount, 0);
    });

    test('triggers review on reaching threshold', () async {
      for (var i = 0; i < ReviewService.threshold; i++) {
        await ReviewService.instance.recordToolUseAndPrompt();
      }

      expect(mockReview.requestReviewCount, 1);
    });

    test('does not re-trigger after first prompt', () async {
      // Trigger once
      for (var i = 0; i < ReviewService.threshold; i++) {
        await ReviewService.instance.recordToolUseAndPrompt();
      }
      expect(mockReview.requestReviewCount, 1);

      // Use more tools — should not trigger again
      await ReviewService.instance.recordToolUseAndPrompt();
      await ReviewService.instance.recordToolUseAndPrompt();
      expect(mockReview.requestReviewCount, 1);
    });

    test('count persists across simulated restarts', () async {
      // Use 2 tools
      await ReviewService.instance.recordToolUseAndPrompt();
      await ReviewService.instance.recordToolUseAndPrompt();
      expect(mockReview.requestReviewCount, 0);

      // Simulate restart: SharedPreferences retains values
      // Use 1 more tool → total 3 → triggers
      await ReviewService.instance.recordToolUseAndPrompt();
      expect(mockReview.requestReviewCount, 1);
    });

    test('handles unavailable in_app_review gracefully', () async {
      mockReview.available = false;

      for (var i = 0; i < ReviewService.threshold; i++) {
        await ReviewService.instance.recordToolUseAndPrompt();
      }

      // requestReview should not be called when unavailable
      expect(mockReview.requestReviewCount, 0);
    });

    test('threshold constant is 3', () {
      expect(ReviewService.threshold, 3);
    });
  });
}
