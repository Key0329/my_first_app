import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_first_app/l10n/app_localizations.dart';
import 'package:my_first_app/services/pro_service.dart';
import 'package:my_first_app/tools/quick_notes/quick_notes_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _testSurfaceSize = Size(414, 896);

Widget _buildApp() {
  return ChangeNotifierProvider<ProService>.value(
    value: ProService(),
    child: MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('zh'),
      home: const QuickNotesPage(),
    ),
  );
}

void main() {
  group('QuickNotesPage widget', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    testWidgets('renders empty state', (tester) async {
      await tester.binding.setSurfaceSize(_testSurfaceSize);
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(_buildApp());
      await tester.pumpAndSettle();

      // 空白狀態文字
      expect(find.text('還沒有筆記'), findsOneWidget);
      expect(find.text('點擊右下角按鈕開始記錄'), findsOneWidget);

      // FAB 含新增 icon
      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    testWidgets('search field exists', (tester) async {
      await tester.binding.setSurfaceSize(_testSurfaceSize);
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(_buildApp());
      await tester.pumpAndSettle();

      // 搜尋欄 hint text
      expect(find.text('搜尋筆記...'), findsOneWidget);
    });

    testWidgets('FAB navigates to edit page', (tester) async {
      await tester.binding.setSurfaceSize(_testSurfaceSize);
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(_buildApp());
      await tester.pumpAndSettle();

      // 點擊 FAB
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      // 應導航至 NoteEditPage，顯示「編輯筆記」標題
      expect(find.text('編輯筆記'), findsOneWidget);
    });

    testWidgets('note count shown', (tester) async {
      await tester.binding.setSurfaceSize(_testSurfaceSize);
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(_buildApp());
      await tester.pumpAndSettle();

      // 標頭顯示筆記數量
      expect(find.text('0 則筆記'), findsOneWidget);
    });
  });
}
