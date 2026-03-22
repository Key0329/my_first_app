import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_first_app/l10n/app_localizations.dart';
import 'package:my_first_app/pages/onboarding_page.dart';

/// 包裝 OnboardingPage 的輔助函式，提供 MaterialApp 環境。
Widget _wrapOnboardingPage({required VoidCallback onComplete}) {
  return MaterialApp(
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    locale: const Locale('zh'),
    home: OnboardingPage(onComplete: onComplete),
  );
}

void main() {
  group('OnboardingPage', () {
    // -----------------------------------------------------------------------
    // 1. 三頁 PageView 存在且可滑動
    // -----------------------------------------------------------------------
    group('PageView with 3 pages', () {
      testWidgets('應包含 PageView widget', (tester) async {
        await tester.pumpWidget(_wrapOnboardingPage(onComplete: () {}));
        await tester.pump();

        expect(find.byType(PageView), findsOneWidget);
      });

      testWidgets('可向左滑動切換到第 2 頁', (tester) async {
        await tester.pumpWidget(_wrapOnboardingPage(onComplete: () {}));
        await tester.pump();

        // 第一頁應顯示歡迎相關文字
        expect(find.textContaining('歡迎'), findsOneWidget);

        // 向左滑動切換頁面
        await tester.drag(find.byType(PageView), const Offset(-400, 0));
        await tester.pumpAndSettle();

        // 第二頁應顯示功能介紹相關內容
        expect(find.textContaining('功能'), findsWidgets);
      });

      testWidgets('可滑動到第 3 頁', (tester) async {
        await tester.pumpWidget(_wrapOnboardingPage(onComplete: () {}));
        await tester.pump();

        // 滑到第 2 頁
        await tester.drag(find.byType(PageView), const Offset(-400, 0));
        await tester.pumpAndSettle();

        // 滑到第 3 頁
        await tester.drag(find.byType(PageView), const Offset(-400, 0));
        await tester.pumpAndSettle();

        // 第三頁應顯示「開始使用」按鈕
        expect(find.text('開始使用'), findsOneWidget);
      });
    });

    // -----------------------------------------------------------------------
    // 2. Skip 按鈕在所有頁面都存在
    // -----------------------------------------------------------------------
    group('Skip button', () {
      testWidgets('第 1 頁應顯示「跳過」按鈕', (tester) async {
        await tester.pumpWidget(_wrapOnboardingPage(onComplete: () {}));
        await tester.pump();

        expect(find.text('跳過'), findsOneWidget);
      });

      testWidgets('第 2 頁應顯示「跳過」按鈕', (tester) async {
        await tester.pumpWidget(_wrapOnboardingPage(onComplete: () {}));
        await tester.pump();

        await tester.drag(find.byType(PageView), const Offset(-400, 0));
        await tester.pumpAndSettle();

        expect(find.text('跳過'), findsOneWidget);
      });

      testWidgets('第 3 頁應顯示「跳過」按鈕', (tester) async {
        await tester.pumpWidget(_wrapOnboardingPage(onComplete: () {}));
        await tester.pump();

        // 滑到第 3 頁
        await tester.drag(find.byType(PageView), const Offset(-400, 0));
        await tester.pumpAndSettle();
        await tester.drag(find.byType(PageView), const Offset(-400, 0));
        await tester.pumpAndSettle();

        expect(find.text('跳過'), findsOneWidget);
      });

      testWidgets('點擊「跳過」應觸發 onComplete callback', (tester) async {
        var completed = false;
        await tester.pumpWidget(
          _wrapOnboardingPage(onComplete: () => completed = true),
        );
        await tester.pump();

        await tester.tap(find.text('跳過'));
        await tester.pump();

        expect(completed, isTrue);
      });
    });

    // -----------------------------------------------------------------------
    // 3. 第三頁的「開始使用」按鈕
    // -----------------------------------------------------------------------
    group('Get Started button on page 3', () {
      testWidgets('第 3 頁應顯示「開始使用」按鈕', (tester) async {
        await tester.pumpWidget(_wrapOnboardingPage(onComplete: () {}));
        await tester.pump();

        // 滑到第 3 頁
        await tester.drag(find.byType(PageView), const Offset(-400, 0));
        await tester.pumpAndSettle();
        await tester.drag(find.byType(PageView), const Offset(-400, 0));
        await tester.pumpAndSettle();

        expect(find.text('開始使用'), findsOneWidget);
      });

      testWidgets('點擊「開始使用」應觸發 onComplete callback', (tester) async {
        var completed = false;
        await tester.pumpWidget(
          _wrapOnboardingPage(onComplete: () => completed = true),
        );
        await tester.pump();

        // 滑到第 3 頁
        await tester.drag(find.byType(PageView), const Offset(-400, 0));
        await tester.pumpAndSettle();
        await tester.drag(find.byType(PageView), const Offset(-400, 0));
        await tester.pumpAndSettle();

        await tester.tap(find.text('開始使用'));
        await tester.pump();

        expect(completed, isTrue);
      });
    });

    // -----------------------------------------------------------------------
    // 4. 頁面指示器（dots）
    // -----------------------------------------------------------------------
    group('Page indicator dots', () {
      testWidgets('應顯示 3 個頁面指示器 dot', (tester) async {
        await tester.pumpWidget(_wrapOnboardingPage(onComplete: () {}));
        await tester.pump();

        // 用 key 'dot_0', 'dot_1', 'dot_2' 來定位 dot widget
        expect(find.byKey(const Key('dot_0')), findsOneWidget);
        expect(find.byKey(const Key('dot_1')), findsOneWidget);
        expect(find.byKey(const Key('dot_2')), findsOneWidget);
      });
    });

    // -----------------------------------------------------------------------
    // 5. 第一頁內容驗證
    // -----------------------------------------------------------------------
    group('Page 1 content', () {
      testWidgets('第 1 頁應顯示 app logo icon', (tester) async {
        await tester.pumpWidget(_wrapOnboardingPage(onComplete: () {}));
        await tester.pump();

        // logo 使用 Icons.build_rounded
        expect(find.byIcon(Icons.build_rounded), findsOneWidget);
      });

      testWidgets('第 1 頁應顯示歡迎標題', (tester) async {
        await tester.pumpWidget(_wrapOnboardingPage(onComplete: () {}));
        await tester.pump();

        expect(find.textContaining('歡迎'), findsOneWidget);
      });

      testWidgets('第 1 頁應顯示 app 描述', (tester) async {
        await tester.pumpWidget(_wrapOnboardingPage(onComplete: () {}));
        await tester.pump();

        expect(find.textContaining('隨身工具箱'), findsOneWidget);
      });
    });

    // -----------------------------------------------------------------------
    // 6. 第二頁內容驗證
    // -----------------------------------------------------------------------
    group('Page 2 content', () {
      testWidgets('第 2 頁應顯示核心功能圖標', (tester) async {
        await tester.pumpWidget(_wrapOnboardingPage(onComplete: () {}));
        await tester.pump();

        // 滑到第 2 頁
        await tester.drag(find.byType(PageView), const Offset(-400, 0));
        await tester.pumpAndSettle();

        // 功能圖標：toolbox, favorites, settings
        expect(find.byIcon(Icons.handyman_rounded), findsOneWidget);
        expect(find.byIcon(Icons.favorite_rounded), findsOneWidget);
        expect(find.byIcon(Icons.settings_rounded), findsOneWidget);
      });
    });
  });
}
