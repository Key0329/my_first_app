import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_first_app/l10n/app_localizations.dart';
import 'package:my_first_app/tools/word_counter/word_counter_page.dart';

// ImmersiveToolScaffold 需要足夠的畫面空間。
const _testSurfaceSize = Size(414, 896);

Widget _buildApp() {
  return MaterialApp(
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    locale: const Locale('zh'),
    home: const WordCounterPage(),
  );
}

void main() {
  group('WordCounterPage widget', () {
    testWidgets('renders initial UI elements', (tester) async {
      await tester.binding.setSurfaceSize(_testSurfaceSize);
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(_buildApp());
      await tester.pumpAndSettle();

      // 頁面標題
      expect(find.text('文字計數器'), findsOneWidget);

      // TextField hint text
      expect(find.text('在這裡輸入或貼上文字...'), findsOneWidget);

      // 統計標籤
      expect(find.text('字數'), findsOneWidget);
      expect(find.text('行數'), findsOneWidget);
      expect(find.text('段落數'), findsOneWidget);

      // 初始值均為 "0"
      // 統計卡片共 6 個，其中 charsWithSpaces、charsNoSpaces、words、lines、paragraphs
      // 都顯示 "0"，readingTime 也顯示 "0"（輸入為空時特例）
      final zeroFinders = find.text('0');
      expect(zeroFinders, findsNWidgets(6));
    });

    testWidgets('typing text updates statistics', (tester) async {
      await tester.binding.setSurfaceSize(_testSurfaceSize);
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(_buildApp());
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'Hello World');
      await tester.pumpAndSettle();

      // 'Hello World' 含空白共 11 個字元
      expect(find.text('11'), findsOneWidget);
    });

    testWidgets('clear button resets text and statistics', (tester) async {
      await tester.binding.setSurfaceSize(_testSurfaceSize);
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(_buildApp());
      await tester.pumpAndSettle();

      // 先輸入文字
      await tester.enterText(find.byType(TextField), 'Hello World');
      await tester.pumpAndSettle();

      // 點擊 clear_all 圖示
      await tester.tap(find.byIcon(Icons.clear_all));
      await tester.pumpAndSettle();

      // TextField 應為空（hint text 重新顯示）
      expect(find.text('在這裡輸入或貼上文字...'), findsOneWidget);

      // 所有統計值回到 "0"
      expect(find.text('0'), findsNWidgets(6));
    });

    testWidgets('copy button copies summary and shows snackbar', (tester) async {
      await tester.binding.setSurfaceSize(_testSurfaceSize);
      addTearDown(() => tester.binding.setSurfaceSize(null));

      // 攔截 Clipboard platform channel，記錄呼叫
      String? capturedText;
      tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
        SystemChannels.platform,
        (MethodCall call) async {
          if (call.method == 'Clipboard.setData') {
            capturedText =
                (call.arguments as Map<Object?, Object?>)['text'] as String?;
          }
          return null;
        },
      );
      addTearDown(() {
        tester.binding.defaultBinaryMessenger
            .setMockMethodCallHandler(SystemChannels.platform, null);
      });

      await tester.pumpWidget(_buildApp());
      await tester.pumpAndSettle();

      // 先輸入文字（copy 按鈕在空白時為 disabled）
      await tester.enterText(find.byType(TextField), 'Hello');
      await tester.pumpAndSettle();

      // 點擊 copy 圖示
      await tester.tap(find.byIcon(Icons.copy));
      await tester.pumpAndSettle();

      // 應顯示 Snackbar
      expect(find.text('已複製統計摘要'), findsOneWidget);

      // 應呼叫 Clipboard.setData
      expect(capturedText, isNotNull);
      // 摘要包含統計標籤（非原始文字）
      expect(capturedText, contains('字數'));
    });
  });
}
