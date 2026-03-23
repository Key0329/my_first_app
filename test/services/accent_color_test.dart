import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_first_app/services/theme_service.dart';

void main() {
  group('AccentColorOption', () {
    test('has 6 values', () {
      expect(AccentColorOption.values.length, 6);
    });
  });

  group('ThemeService accent color', () {
    late SharedPreferences prefs;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      prefs = await SharedPreferences.getInstance();
    });

    test('default accent color is purple', () {
      final service = ThemeService(prefs);
      expect(service.accentColor, AccentColorOption.purple);
    });

    test('setAccentColor changes accentColor', () async {
      final service = ThemeService(prefs);
      await service.setAccentColor(AccentColorOption.blue);
      expect(service.accentColor, AccentColorOption.blue);
    });

    test('setAccentColor notifies listeners', () async {
      final service = ThemeService(prefs);
      var notified = false;
      service.addListener(() => notified = true);
      await service.setAccentColor(AccentColorOption.green);
      expect(notified, isTrue);
    });

    test('accentColorValue returns correct Color for each option', () {
      final service = ThemeService(prefs);

      const expected = {
        AccentColorOption.purple: Color(0xFF6C5CE7),
        AccentColorOption.blue: Color(0xFF3B82F6),
        AccentColorOption.green: Color(0xFF10B981),
        AccentColorOption.red: Color(0xFFEF4444),
        AccentColorOption.orange: Color(0xFFF59E0B),
        AccentColorOption.pink: Color(0xFFEC4899),
      };

      for (final entry in expected.entries) {
        expect(
          entry.key.color,
          entry.value,
          reason: 'Color mismatch for ${entry.key.name}',
        );
      }

      // verify accentColorValue reflects current selection
      expect(service.accentColorValue, const Color(0xFF6C5CE7));
    });

    test('loadFromPrefs restores saved accent color', () async {
      // simulate a previously saved index — blue is index 1
      SharedPreferences.setMockInitialValues({
        'accent_color': AccentColorOption.blue.index,
      });
      final savedPrefs = await SharedPreferences.getInstance();
      final service = ThemeService(savedPrefs);
      service.loadFromPrefs();
      expect(service.accentColor, AccentColorOption.blue);
    });

    test('loadFromPrefs with invalid index keeps default purple', () async {
      SharedPreferences.setMockInitialValues({
        'accent_color': 999, // out of range
      });
      final savedPrefs = await SharedPreferences.getInstance();
      final service = ThemeService(savedPrefs);
      service.loadFromPrefs();
      expect(service.accentColor, AccentColorOption.purple);
    });

    test('loadFromPrefs with negative index keeps default purple', () async {
      SharedPreferences.setMockInitialValues({'accent_color': -1});
      final savedPrefs = await SharedPreferences.getInstance();
      final service = ThemeService(savedPrefs);
      service.loadFromPrefs();
      expect(service.accentColor, AccentColorOption.purple);
    });
  });
}
