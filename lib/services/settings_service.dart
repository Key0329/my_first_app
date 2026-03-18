import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettings extends ChangeNotifier {
  static const _keyThemeMode = 'theme_mode';
  static const _keyLocale = 'locale';
  static const _keyFavorites = 'favorites';

  ThemeMode _themeMode = ThemeMode.system;
  Locale _locale = const Locale('zh', 'TW');
  Set<String> _favorites = {};

  ThemeMode get themeMode => _themeMode;
  Locale get locale => _locale;
  Set<String> get favorites => Set.unmodifiable(_favorites);

  bool isFavorite(String toolId) => _favorites.contains(toolId);

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final themeModeIndex = prefs.getInt(_keyThemeMode);
    if (themeModeIndex != null &&
        themeModeIndex >= 0 &&
        themeModeIndex < ThemeMode.values.length) {
      _themeMode = ThemeMode.values[themeModeIndex];
    }

    final localeStr = prefs.getString(_keyLocale);
    if (localeStr != null) {
      final parts = localeStr.split('_');
      _locale = parts.length > 1
          ? Locale(parts[0], parts[1])
          : Locale(parts[0]);
    }

    final favList = prefs.getStringList(_keyFavorites);
    if (favList != null) {
      _favorites = favList.toSet();
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyThemeMode, mode.index);
  }

  Future<void> setLocale(Locale locale) async {
    _locale = locale;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyLocale, locale.toLanguageTag().replaceAll('-', '_'));
  }

  Future<void> toggleFavorite(String toolId) async {
    if (_favorites.contains(toolId)) {
      _favorites.remove(toolId);
    } else {
      _favorites.add(toolId);
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_keyFavorites, _favorites.toList());
  }
}
