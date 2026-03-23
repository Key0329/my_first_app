import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:my_first_app/l10n/app_localizations.dart';
import 'package:my_first_app/pages/home_page.dart';
import 'package:my_first_app/services/settings_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<AppSettings> _makeSettings() async {
  SharedPreferences.setMockInitialValues({});
  final settings = AppSettings();
  await settings.init();
  return settings;
}

Widget _buildApp(AppSettings settings) {
  return MaterialApp(
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    locale: const Locale('zh'),
    home: HomePage(settings: settings),
    onGenerateRoute: (routeSettings) =>
        MaterialPageRoute(builder: (_) => const Scaffold(body: SizedBox())),
  );
}

void main() {
  group('成長引擎功能 - Growth Engine Widget Tests', () {
    testWidgets('shows streak display', (WidgetTester tester) async {
      await tester.binding.setSurfaceSize(const Size(414, 896));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
      SharedPreferences.setMockInitialValues({
        'streak_count': 5,
        'streak_last_date': today,
      });
      final settings = AppSettings();
      await settings.init();

      await tester.pumpWidget(_buildApp(settings));
      await tester.pump();

      expect(find.byIcon(Icons.local_fire_department), findsOneWidget);
      expect(find.text('連續 5 天'), findsOneWidget);
    });

    testWidgets('shows daily recommendation card', (WidgetTester tester) async {
      await tester.binding.setSurfaceSize(const Size(414, 896));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      final settings = await _makeSettings();

      await tester.pumpWidget(_buildApp(settings));
      await tester.pump();

      expect(find.text('今日推薦'), findsOneWidget);
      expect(find.text('試試這個工具吧！'), findsOneWidget);
    });

    testWidgets('streak with 0 still shows after using a tool', (
      WidgetTester tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(414, 896));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      final settings = await _makeSettings();

      await tester.pumpWidget(_buildApp(settings));
      await tester.pump();

      // 初始 streak 為 0，fire icon 不顯示
      expect(find.byIcon(Icons.local_fire_department), findsNothing);

      // 使用工具後 streak 變成 1
      await settings.addRecentTool('bmi-calculator');

      // 等待 ListenableBuilder 重建
      await tester.pump();

      expect(find.byIcon(Icons.local_fire_department), findsOneWidget);
    });
  });
}
