import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_first_app/l10n/app_localizations.dart';
import 'package:my_first_app/services/pro_service.dart';
import 'package:my_first_app/tools/password_generator/password_generator_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Widget _buildApp() {
  return ChangeNotifierProvider<ProService>.value(
    value: ProService(),
    child: MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('zh'),
      home: const PasswordGeneratorPage(),
    ),
  );
}

void main() {
  group('PasswordGeneratorPage', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    testWidgets('renders initial UI elements', (tester) async {
      await tester.pumpWidget(_buildApp());
      await tester.pumpAndSettle();

      // AppBar title
      expect(find.text('密碼產生器'), findsOneWidget);

      // Memorable mode toggle (new)
      expect(find.text('易記模式'), findsOneWidget);

      // Character type toggles (need to scroll to see them)
      expect(find.text('大寫字母 (A-Z)'), findsOneWidget);
      expect(find.text('小寫字母 (a-z)'), findsOneWidget);
      expect(find.text('數字 (0-9)'), findsOneWidget);
      expect(
        find.widgetWithText(SwitchListTile, '特殊字元 (!@#\$...)'),
        findsOneWidget,
      );

      // Generate button
      expect(find.text('產生新密碼'), findsOneWidget);

      // Strength label
      expect(find.text('強度'), findsOneWidget);

      // Copy button in header — may have multiple copy icons (header + history)
      expect(find.byIcon(Icons.copy), findsAtLeast(1));

      // Slider exists
      expect(find.byType(Slider), findsOneWidget);
    });

    testWidgets('generates a password on init', (tester) async {
      await tester.pumpWidget(_buildApp());

      // A password should be generated immediately (displayed as SelectableText)
      final selectableText = tester.widget<SelectableText>(
        find.byType(SelectableText),
      );
      expect(selectableText.data, isNotNull);
      expect(selectableText.data, isNotEmpty);
      // Default length is 16
      expect(selectableText.data!.length, 16);
    });

    testWidgets('generates new password when button tapped', (tester) async {
      await tester.pumpWidget(_buildApp());

      final firstPassword = tester
          .widget<SelectableText>(find.byType(SelectableText))
          .data;

      // Tap generate button multiple times to increase chance of different password
      String? newPassword;
      for (var i = 0; i < 10; i++) {
        await tester.ensureVisible(find.text('產生新密碼'));
        await tester.pumpAndSettle();
        await tester.tap(find.text('產生新密碼'));
        await tester.pump();
        newPassword = tester
            .widget<SelectableText>(find.byType(SelectableText))
            .data;
        if (newPassword != firstPassword) break;
      }

      // With 16-char random passwords, they should eventually differ
      // (astronomically unlikely to match 10 times in a row)
      expect(newPassword, isNot(equals(firstPassword)));
    });

    testWidgets('slider changes password length', (tester) async {
      await tester.pumpWidget(_buildApp());

      // Default is 16 chars
      var password = tester
          .widget<SelectableText>(find.byType(SelectableText))
          .data!;
      expect(password.length, 16);

      // Move slider to right end (64)
      final slider = find.byType(Slider);
      // Drag to the right for a longer password
      await tester.drag(slider, const Offset(300, 0));
      await tester.pump();

      password = tester
          .widget<SelectableText>(find.byType(SelectableText))
          .data!;
      expect(password.length, greaterThan(16));
    });

    testWidgets('password contains only expected character types', (
      tester,
    ) async {
      await tester.pumpWidget(_buildApp());

      // Default: uppercase, lowercase, numbers ON; special OFF
      final password = tester
          .widget<SelectableText>(find.byType(SelectableText))
          .data!;

      // Should only contain alphanumeric chars (no special)
      expect(password, matches(RegExp(r'^[A-Za-z0-9]+$')));
    });

    testWidgets('toggling special characters on includes them in pool', (
      tester,
    ) async {
      await tester.pumpWidget(_buildApp());

      // Turn on special characters
      final specialSwitch = find.widgetWithText(
        SwitchListTile,
        '特殊字元 (!@#\$...)',
      );
      await tester.ensureVisible(specialSwitch);
      await tester.pumpAndSettle();
      await tester.tap(specialSwitch);
      await tester.pump();

      // Generate several passwords and check at least one contains special chars
      bool foundSpecial = false;
      final genBtn = find.text('產生新密碼');
      await tester.ensureVisible(genBtn);
      await tester.pumpAndSettle();
      for (var i = 0; i < 20; i++) {
        await tester.tap(genBtn);
        await tester.pump();
        final password = tester
            .widget<SelectableText>(find.byType(SelectableText))
            .data!;
        if (password.contains(RegExp(r'[!@#$%^&*()_+\-=\[\]{}|;:,.<>?]'))) {
          foundSpecial = true;
          break;
        }
      }
      expect(foundSpecial, isTrue);
    });

    testWidgets('cannot disable all character types', (tester) async {
      await tester.pumpWidget(_buildApp());

      // Default: uppercase, lowercase, numbers ON (3 active)
      // Turn off uppercase
      final upperSwitch = find.widgetWithText(SwitchListTile, '大寫字母 (A-Z)');
      await tester.ensureVisible(upperSwitch);
      await tester.pumpAndSettle();
      await tester.tap(upperSwitch);
      await tester.pump();
      // Turn off lowercase
      final lowerSwitch = find.widgetWithText(SwitchListTile, '小寫字母 (a-z)');
      await tester.ensureVisible(lowerSwitch);
      await tester.pumpAndSettle();
      await tester.tap(lowerSwitch);
      await tester.pump();
      // Now only numbers is ON. Trying to turn off numbers should show snackbar
      final numSwitch = find.widgetWithText(SwitchListTile, '數字 (0-9)');
      await tester.ensureVisible(numSwitch);
      await tester.pumpAndSettle();
      await tester.tap(numSwitch);
      await tester.pump();

      expect(find.text('至少需選擇一種字元類型'), findsOneWidget);
    });

    testWidgets('copy button copies password and shows snackbar', (
      tester,
    ) async {
      await tester.pumpWidget(_buildApp());
      await tester.pumpAndSettle();

      // Set up mock clipboard
      final List<MethodCall> clipboardCalls = [];
      tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
        SystemChannels.platform,
        (methodCall) async {
          if (methodCall.method == 'Clipboard.setData') {
            clipboardCalls.add(methodCall);
          }
          return null;
        },
      );

      // Tap the first copy icon (in the header area, not the history)
      await tester.tap(find.byIcon(Icons.copy).first);
      await tester.pump();

      expect(find.text('已複製到剪貼簿'), findsOneWidget);
      expect(clipboardCalls, hasLength(1));

      // Clean up
      tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
        SystemChannels.platform,
        null,
      );
    });

    testWidgets('strength indicator shows correct level', (tester) async {
      await tester.pumpWidget(_buildApp());

      // Default: length 16, 3 types (uppercase, lowercase, numbers) → strong
      expect(find.text('強'), findsOneWidget);
    });

    testWidgets(
      'strength changes to very strong with long password + many types',
      (tester) async {
        await tester.pumpWidget(_buildApp());

        // Turn on special characters (4 types)
        await tester.tap(
          find.widgetWithText(SwitchListTile, '特殊字元 (!@#\$...)'),
        );
        await tester.pump();

        // Drag slider to make length >= 20
        final slider = find.byType(Slider);
        await tester.drag(slider, const Offset(100, 0));
        await tester.pump();

        final password = tester
            .widget<SelectableText>(find.byType(SelectableText))
            .data!;

        // If length >= 20 and types >= 3, should be very strong
        if (password.length >= 20) {
          expect(find.text('非常強'), findsOneWidget);
        }
      },
    );

    testWidgets('strength shows weak for short password with few types', (
      tester,
    ) async {
      await tester.pumpWidget(_buildApp());

      // Turn off uppercase and numbers so only lowercase remains
      await tester.tap(find.widgetWithText(SwitchListTile, '大寫字母 (A-Z)'));
      await tester.pump();
      await tester.tap(find.widgetWithText(SwitchListTile, '數字 (0-9)'));
      await tester.pump();

      // Now only lowercase, and we need to move slider to min (8)
      // Drag slider all the way left
      final slider = find.byType(Slider);
      await tester.drag(slider, const Offset(-500, 0));
      await tester.pump();

      // With 1 type and length 8 → weak
      expect(find.text('弱'), findsOneWidget);
    });
  });

  group('PasswordStrength enum', () {
    test('has correct values', () {
      expect(PasswordStrength.weak.label, '弱');
      expect(PasswordStrength.medium.label, '中等');
      expect(PasswordStrength.strong.label, '強');
      expect(PasswordStrength.veryStrong.label, '非常強');
    });

    test('has increasing value progression', () {
      expect(
        PasswordStrength.weak.value,
        lessThan(PasswordStrength.medium.value),
      );
      expect(
        PasswordStrength.medium.value,
        lessThan(PasswordStrength.strong.value),
      );
      expect(
        PasswordStrength.strong.value,
        lessThan(PasswordStrength.veryStrong.value),
      );
    });
  });
}
