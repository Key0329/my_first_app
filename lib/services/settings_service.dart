import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettings extends ChangeNotifier {
  static const _keyThemeMode = 'theme_mode';
  static const _keyLocale = 'locale';
  static const _keyFavorites = 'favorites';
  static const _keyOnboarding = 'hasCompletedOnboarding';
  static const _keyRecentTools = 'recent_tools';

  ThemeMode _themeMode = ThemeMode.system;
  Locale _locale = const Locale('zh', 'TW');
  Set<String> _favorites = {};
  bool _hasCompletedOnboarding = false;
  List<String> _recentTools = [];

  ThemeMode get themeMode => _themeMode;
  Locale get locale => _locale;
  Set<String> get favorites => Set.unmodifiable(_favorites);
  bool get hasCompletedOnboarding => _hasCompletedOnboarding;
  List<String> get recentTools => List.unmodifiable(_recentTools);

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

    _hasCompletedOnboarding = prefs.getBool(_keyOnboarding) ?? false;

    final recentList = prefs.getStringList(_keyRecentTools);
    if (recentList != null) {
      _recentTools = recentList;
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

  Future<void> completeOnboarding() async {
    _hasCompletedOnboarding = true;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyOnboarding, true);
  }

  static const _maxRecentTools = 5;

  Future<void> addRecentTool(String toolId) async {
    _recentTools.remove(toolId);
    _recentTools.insert(0, toolId);
    if (_recentTools.length > _maxRecentTools) {
      _recentTools = _recentTools.sublist(0, _maxRecentTools);
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_keyRecentTools, _recentTools);
  }

  Future<void> clearRecentTools() async {
    _recentTools.clear();
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyRecentTools);
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
