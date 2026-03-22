import 'package:flutter_test/flutter_test.dart';
import 'package:my_first_app/theme/design_tokens.dart';

void main() {
  group('DT 工具頁面 Token', () {
    test('toolBodyPadding 為 16.0', () {
      expect(DT.toolBodyPadding, 16.0);
    });

    test('toolSectionGap 為 12.0', () {
      expect(DT.toolSectionGap, 12.0);
    });

    test('toolSectionRadius 為 16.0', () {
      expect(DT.toolSectionRadius, 16.0);
    });

    test('toolSectionPadding 為 16.0', () {
      expect(DT.toolSectionPadding, 16.0);
    });

    test('toolButtonRadius 為 14.0', () {
      expect(DT.toolButtonRadius, 14.0);
    });

    test('toolButtonHeight 為 52.0', () {
      expect(DT.toolButtonHeight, 52.0);
    });

    test('fontToolResult 為 36.0', () {
      expect(DT.fontToolResult, 36.0);
    });

    test('fontToolLabel 為 14.0', () {
      expect(DT.fontToolLabel, 14.0);
    });

    test('fontToolButton 為 16.0', () {
      expect(DT.fontToolButton, 16.0);
    });
  });
}
