import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_first_app/l10n/app_localizations.dart';
import 'package:my_first_app/services/pro_service.dart';
import 'package:my_first_app/tools/pomodoro/pomodoro_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Widget _buildApp() {
  return ChangeNotifierProvider<ProService>.value(
    value: ProService(),
    child: MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('zh'),
      home: const PomodoroPage(),
    ),
  );
}

void main() {
  group('PomodoroPage widget', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    testWidgets('renders initial UI elements', (tester) async {
      await tester.binding.setSurfaceSize(const Size(414, 896));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(_buildApp());
      await tester.pumpAndSettle();

      // 頁面標題
      expect(find.text('番茄鐘'), findsOneWidget);

      // 工作階段標籤（在 header 中）
      expect(find.text('工作'), findsOneWidget);

      // 初始計時顯示 25:00
      expect(find.text('25:00'), findsOneWidget);

      // 開始按鈕
      expect(find.text('開始'), findsOneWidget);

      // 白噪音區塊標題
      expect(find.text('白噪音'), findsOneWidget);

      // 設定區塊標題
      expect(find.text('設定'), findsOneWidget);

      // 白噪音選項 chips
      expect(find.text('雨聲'), findsOneWidget);
      expect(find.text('咖啡廳'), findsOneWidget);
      expect(find.text('森林'), findsOneWidget);
    });

    testWidgets('start button changes to pause', (tester) async {
      await tester.binding.setSurfaceSize(const Size(414, 896));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(_buildApp());
      await tester.pumpAndSettle();

      // 初始顯示「開始」
      expect(find.text('開始'), findsOneWidget);
      expect(find.text('暫停'), findsNothing);

      // 點擊開始按鈕
      await tester.tap(find.text('開始'));
      await tester.pump();

      // 應顯示「暫停」
      expect(find.text('暫停'), findsOneWidget);
      expect(find.text('開始'), findsNothing);
    });

    testWidgets('timer controls layout', (tester) async {
      await tester.binding.setSurfaceSize(const Size(414, 896));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(_buildApp());
      await tester.pumpAndSettle();

      // 重設按鈕（replay icon）
      expect(find.byIcon(Icons.replay), findsOneWidget);

      // 跳過按鈕（skip_next icon）
      expect(find.byIcon(Icons.skip_next), findsOneWidget);
    });

    testWidgets('settings sliders exist', (tester) async {
      await tester.binding.setSurfaceSize(const Size(414, 896));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(_buildApp());
      await tester.pumpAndSettle();

      // 捲動到設定區塊
      await tester.ensureVisible(find.text('工作時長'));
      await tester.pumpAndSettle();

      expect(find.text('工作時長'), findsOneWidget);

      await tester.ensureVisible(find.text('短休息時長'));
      await tester.pumpAndSettle();

      expect(find.text('短休息時長'), findsOneWidget);

      await tester.ensureVisible(find.text('長休息時長'));
      await tester.pumpAndSettle();

      expect(find.text('長休息時長'), findsOneWidget);
    });
  });
}
