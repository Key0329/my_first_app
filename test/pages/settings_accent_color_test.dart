import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_first_app/l10n/app_localizations.dart';
import 'package:my_first_app/pages/settings_page.dart';
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
    home: Scaffold(body: SettingsPage(settings: settings)),
  );
}

void main() {
  group('主題色選擇器', () {
    testWidgets('shows accent color section', (WidgetTester tester) async {
      await tester.binding.setSurfaceSize(const Size(414, 896));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      final settings = await _makeSettings();
      await tester.pumpWidget(_buildApp(settings));
      // 等待 localizations 載入與初始 frame
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text('主題色'), findsOneWidget);
    });

    testWidgets('shows 6 color circles', (WidgetTester tester) async {
      await tester.binding.setSurfaceSize(const Size(414, 896));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      final settings = await _makeSettings();
      await tester.pumpWidget(_buildApp(settings));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      final circleContainers = find.byWidgetPredicate((widget) {
        if (widget is Container) {
          final decoration = widget.decoration;
          if (decoration is BoxDecoration) {
            return decoration.shape == BoxShape.circle;
          }
        }
        return false;
      });

      expect(circleContainers, findsAtLeastNWidgets(6));
    });

    testWidgets('selected color has check icon', (WidgetTester tester) async {
      await tester.binding.setSurfaceSize(const Size(414, 896));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      final settings = await _makeSettings();
      await tester.pumpWidget(_buildApp(settings));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // 預設為 purple，accent color 圓圈內應有白色 check icon（size: 18）
      final checkIcons = find.byWidgetPredicate((widget) {
        if (widget is Icon) {
          return widget.icon == Icons.check &&
              widget.size == 18 &&
              widget.color == Colors.white;
        }
        return false;
      });

      expect(checkIcons, findsOneWidget);
    });
  });
}
