import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_first_app/l10n/app_localizations.dart';
import 'package:my_first_app/widgets/tool_recommendation_bar.dart';

void main() {
  group('ToolRecommendationBar', () {
    testWidgets('renders recommendation chips for known tool',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: const Locale('zh'),
          home: const Scaffold(
            body: ToolRecommendationBar(toolId: 'calculator'),
          ),
        ),
      );

      // Should show "你可能也需要" label
      expect(find.text('你可能也需要'), findsOneWidget);

      // Should show at least one ActionChip
      expect(find.byType(ActionChip), findsWidgets);
    });

    testWidgets('renders nothing for unknown tool', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: const Locale('zh'),
          home: const Scaffold(
            body: ToolRecommendationBar(toolId: 'nonexistent'),
          ),
        ),
      );

      // Should not show label
      expect(find.text('你可能也需要'), findsNothing);

      // Should show SizedBox.shrink
      expect(find.byType(ActionChip), findsNothing);
    });

    testWidgets('shows correct recommended tool names', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: const Locale('zh'),
          home: const Scaffold(
            body: ToolRecommendationBar(toolId: 'calculator'),
          ),
        ),
      );

      // calculator recommends unit_converter and currency_converter
      expect(find.text('單位換算'), findsOneWidget);
      expect(find.text('匯率換算'), findsOneWidget);
    });
  });
}
