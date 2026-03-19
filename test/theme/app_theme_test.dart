import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_first_app/theme/app_theme.dart';

void main() {
  group('AppTheme.light()', () {
    late ThemeData theme;

    setUp(() {
      theme = AppTheme.light();
    });

    test('AppBar theme 使用透明背景色', () {
      expect(theme.appBarTheme.backgroundColor, Colors.transparent);
    });

    test('AppBar theme 消除陰影 elevation = 0', () {
      expect(theme.appBarTheme.elevation, 0);
    });

    test('AppBar theme scrolledUnderElevation = 0', () {
      expect(theme.appBarTheme.scrolledUnderElevation, 0);
    });

    test('Card theme 設有 clipBehavior 以支援 gradient', () {
      expect(theme.cardTheme.clipBehavior, Clip.antiAlias);
    });

    test('Card theme 保留 borderRadius 16', () {
      final shape = theme.cardTheme.shape as RoundedRectangleBorder;
      expect(shape.borderRadius, const BorderRadius.all(Radius.circular(16)));
    });
  });

  group('AppTheme.dark()', () {
    late ThemeData theme;

    setUp(() {
      theme = AppTheme.dark();
    });

    test('AppBar theme 使用透明背景色', () {
      expect(theme.appBarTheme.backgroundColor, Colors.transparent);
    });

    test('AppBar theme 消除陰影 elevation = 0', () {
      expect(theme.appBarTheme.elevation, 0);
    });

    test('AppBar theme scrolledUnderElevation = 0', () {
      expect(theme.appBarTheme.scrolledUnderElevation, 0);
    });

    test('Card theme 設有 clipBehavior 以支援 gradient', () {
      expect(theme.cardTheme.clipBehavior, Clip.antiAlias);
    });

    test('Card theme 保留 borderRadius 16', () {
      final shape = theme.cardTheme.shape as RoundedRectangleBorder;
      expect(shape.borderRadius, const BorderRadius.all(Radius.circular(16)));
    });
  });
}
