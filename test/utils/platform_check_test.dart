import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_first_app/utils/platform_check.dart';

void main() {
  group('isMobilePlatform', () {
    test('returns a boolean value', () {
      // On macOS test runner, this should return false
      final result = isMobilePlatform();
      expect(result, isA<bool>());
    });

    test('returns false on macOS test runner', () {
      // Tests run on macOS, which is not a mobile platform
      expect(isMobilePlatform(), isFalse);
    });
  });

  group('PlatformUnsupportedView', () {
    testWidgets('renders fallback UI with tool name', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PlatformUnsupportedView(toolName: '水平儀'),
        ),
      );

      expect(find.text('水平儀'), findsOneWidget);
      expect(find.text('此功能需要行動裝置'), findsOneWidget);
      expect(find.byIcon(Icons.devices_other), findsOneWidget);
    });

    testWidgets('renders without tool name', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PlatformUnsupportedView(),
        ),
      );

      expect(find.text('此功能需要行動裝置'), findsOneWidget);
      expect(find.text('此工具需要手機的硬體感測器，\n目前的平台不支援。'), findsOneWidget);
    });

    testWidgets('has back button in app bar', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        const PlatformUnsupportedView(toolName: '測試'),
                  ),
                ),
                child: const Text('Go'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Go'));
      await tester.pumpAndSettle();

      // Should show the fallback view with a back button
      expect(find.text('此功能需要行動裝置'), findsOneWidget);
      expect(find.byType(BackButton), findsOneWidget);
    });
  });
}
