import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_first_app/services/settings_service.dart';

void main() {
  group('AppSettings', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    test('default themeMode is system', () async {
      final settings = AppSettings();
      await settings.init();
      expect(settings.themeMode, ThemeMode.system);
    });

    test('setThemeMode persists and notifies', () async {
      final settings = AppSettings();
      await settings.init();
      var notified = false;
      settings.addListener(() => notified = true);
      await settings.setThemeMode(ThemeMode.dark);
      expect(settings.themeMode, ThemeMode.dark);
      expect(notified, isTrue);
    });

    test('default locale is zh_TW', () async {
      final settings = AppSettings();
      await settings.init();
      expect(settings.locale, const Locale('zh', 'TW'));
    });

    test('setLocale persists and notifies', () async {
      final settings = AppSettings();
      await settings.init();
      var notified = false;
      settings.addListener(() => notified = true);
      await settings.setLocale(const Locale('en'));
      expect(settings.locale, const Locale('en'));
      expect(notified, isTrue);
    });

    test('favorites starts empty', () async {
      final settings = AppSettings();
      await settings.init();
      expect(settings.favorites, isEmpty);
    });

    test('toggleFavorite adds and removes', () async {
      final settings = AppSettings();
      await settings.init();
      await settings.toggleFavorite('calculator');
      expect(settings.favorites, contains('calculator'));
      await settings.toggleFavorite('calculator');
      expect(settings.favorites, isNot(contains('calculator')));
    });

    test('isFavorite returns correct state', () async {
      final settings = AppSettings();
      await settings.init();
      expect(settings.isFavorite('calculator'), isFalse);
      await settings.toggleFavorite('calculator');
      expect(settings.isFavorite('calculator'), isTrue);
    });

    test('settings persist across instances', () async {
      final settings1 = AppSettings();
      await settings1.init();
      await settings1.setThemeMode(ThemeMode.dark);
      await settings1.toggleFavorite('compass');

      final settings2 = AppSettings();
      await settings2.init();
      expect(settings2.themeMode, ThemeMode.dark);
      expect(settings2.favorites, contains('compass'));
    });

    test('hasCompletedOnboarding defaults to false', () async {
      final settings = AppSettings();
      await settings.init();
      expect(settings.hasCompletedOnboarding, isFalse);
    });

    test('completeOnboarding sets value to true and notifies', () async {
      final settings = AppSettings();
      await settings.init();
      var notified = false;
      settings.addListener(() => notified = true);
      await settings.completeOnboarding();
      expect(settings.hasCompletedOnboarding, isTrue);
      expect(notified, isTrue);
    });

    test('hasCompletedOnboarding persists across instances', () async {
      final settings1 = AppSettings();
      await settings1.init();
      await settings1.completeOnboarding();

      final settings2 = AppSettings();
      await settings2.init();
      expect(settings2.hasCompletedOnboarding, isTrue);
    });
  });
}
