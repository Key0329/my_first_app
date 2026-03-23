import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_first_app/l10n/app_localizations.dart';
import 'package:my_first_app/tools/stopwatch_timer/stopwatch_timer_page.dart';

Widget _buildApp() {
  return MaterialApp(
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    locale: const Locale('zh'),
    home: const StopwatchTimerPage(),
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    for (final channel in [
      'xyz.luan/audioplayers',
      'xyz.luan/audioplayers.global',
      'dexterous.com/flutter/local_notifications',
    ]) {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
            MethodChannel(channel),
            (MethodCall methodCall) async => null,
          );
    }
  });

  group('Timer Tab — state transitions', () {
    Future<void> switchToTimerTab(WidgetTester tester) async {
      // Use a taller viewport to accommodate quick-set chips + picker + button
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(_buildApp());
      // Tap the 計時器 tab
      await tester.tap(find.text('計時器'));
      await tester.pumpAndSettle();
    }

    testWidgets('renders idle state with 設定時間 and 開始 button', (tester) async {
      await switchToTimerTab(tester);

      expect(find.text('設定時間'), findsOneWidget);
      // Scroll to see the 開始 button if needed
      final startBtn = find.text('開始');
      await tester.ensureVisible(startBtn);
      await tester.pumpAndSettle();
      expect(startBtn, findsOneWidget);
    });

    testWidgets('開始 button is disabled when time is zero', (tester) async {
      await switchToTimerTab(tester);

      // The ToolGradientButton should have Opacity 0.5 when disabled
      // Default picker values are 0:0:0, so the button should be disabled
      final toolGradientButton = find.text('開始');
      await tester.ensureVisible(toolGradientButton);
      await tester.pumpAndSettle();
      expect(toolGradientButton, findsOneWidget);

      // Tap should not change state (no countdown display should appear)
      await tester.tap(toolGradientButton);
      await tester.pump();

      // Should still show the picker, not a countdown
      expect(find.text('設定時間'), findsOneWidget);
    });

    testWidgets('timer starts and shows 暫停 and 重設 buttons when running', (
      tester,
    ) async {
      await switchToTimerTab(tester);

      // Scroll the 秒 picker to set 5 seconds
      // The _NumberPicker uses ListWheelScrollView with itemExtent=40
      final secPickerFinder = find.byWidgetPredicate(
        (w) =>
            w is ListWheelScrollView &&
            (w.childDelegate as ListWheelChildBuilderDelegate).childCount == 60,
      );
      // There are two ListWheelScrollViews with 60 items (minutes and seconds)
      // We need the last one (seconds)
      expect(secPickerFinder, findsNWidgets(2));
      final secPicker = secPickerFinder.last;

      // Scroll down to select a non-zero value
      await tester.drag(
        secPicker,
        const Offset(0, -200),
      ); // scroll down = higher values
      await tester.pumpAndSettle();

      // Now tap 開始
      final startBtn = find.text('開始');
      await tester.ensureVisible(startBtn);
      await tester.pumpAndSettle();
      await tester.tap(startBtn);
      await tester.pump();

      // Should now show running state with 暫停 and 重設 buttons
      expect(find.text('暫停'), findsOneWidget);
      expect(find.text('重設'), findsOneWidget);
    });

    testWidgets('pause and resume preserves timer state', (tester) async {
      await switchToTimerTab(tester);

      // Set 10 seconds via seconds picker
      final secPickerFinder = find.byWidgetPredicate(
        (w) =>
            w is ListWheelScrollView &&
            (w.childDelegate as ListWheelChildBuilderDelegate).childCount == 60,
      );
      await tester.drag(secPickerFinder.last, const Offset(0, -400));
      await tester.pumpAndSettle();

      // Start
      final startBtn = find.text('開始');
      await tester.ensureVisible(startBtn);
      await tester.pumpAndSettle();
      await tester.tap(startBtn);
      await tester.pump(const Duration(milliseconds: 500));

      // Pause
      await tester.tap(find.text('暫停'));
      await tester.pump();

      // Should show paused state with 繼續 and 重設 buttons
      expect(find.text('繼續'), findsOneWidget);
      expect(find.text('重設'), findsOneWidget);

      // Resume
      await tester.tap(find.text('繼續'));
      await tester.pump();

      // Should be back to running state
      expect(find.text('暫停'), findsOneWidget);
    });

    testWidgets('reset returns to idle state', (tester) async {
      await switchToTimerTab(tester);

      // Set seconds
      final secPickerFinder = find.byWidgetPredicate(
        (w) =>
            w is ListWheelScrollView &&
            (w.childDelegate as ListWheelChildBuilderDelegate).childCount == 60,
      );
      await tester.drag(secPickerFinder.last, const Offset(0, -200));
      await tester.pumpAndSettle();

      // Start then reset
      final startBtn = find.text('開始');
      await tester.ensureVisible(startBtn);
      await tester.pumpAndSettle();
      await tester.tap(startBtn);
      await tester.pump();
      await tester.tap(find.text('重設'));
      await tester.pumpAndSettle();

      // Confirm the reset dialog
      await tester.tap(find.text('重設').last);
      await tester.pumpAndSettle();

      // Should be back to idle
      expect(find.text('設定時間'), findsOneWidget);
      expect(find.text('開始'), findsOneWidget);
    });

    testWidgets('timer shows countdown display when running', (tester) async {
      await switchToTimerTab(tester);

      // Set seconds
      final secPickerFinder = find.byWidgetPredicate(
        (w) =>
            w is ListWheelScrollView &&
            (w.childDelegate as ListWheelChildBuilderDelegate).childCount == 60,
      );
      await tester.drag(secPickerFinder.last, const Offset(0, -200));
      await tester.pumpAndSettle();

      // Start — should switch from picker to countdown display
      final startBtn = find.text('開始');
      await tester.ensureVisible(startBtn);
      await tester.pumpAndSettle();
      await tester.tap(startBtn);
      await tester.pump();

      // Countdown display has CircularProgressIndicator
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      // Should NOT show the picker anymore
      expect(find.text('設定時間'), findsNothing);
    });
  });
}
