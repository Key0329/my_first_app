import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_first_app/services/theme_service.dart';
import 'package:my_first_app/services/favorites_service.dart';
import 'package:my_first_app/services/user_preferences_service.dart';

class AppSettings extends ChangeNotifier {
  late final ThemeService themeService;
  late final FavoritesService favoritesService;
  late final UserPreferencesService userPreferencesService;
  bool _initialized = false;

  // — Theme delegates —
  ThemeMode get themeMode => themeService.themeMode;
  Locale get locale => themeService.locale;

  // — Favorites delegates —
  Set<String> get favorites => favoritesService.favorites;
  bool isFavorite(String toolId) => favoritesService.isFavorite(toolId);

  // — User preferences delegates —
  bool get hasCompletedOnboarding =>
      userPreferencesService.hasCompletedOnboarding;
  List<String> get recentTools => userPreferencesService.recentTools;

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();

    themeService = ThemeService(prefs);
    favoritesService = FavoritesService(prefs);
    userPreferencesService = UserPreferencesService(prefs);

    themeService.loadFromPrefs();
    favoritesService.loadFromPrefs();
    userPreferencesService.loadFromPrefs();

    // Forward sub-service notifications to AppSettings listeners
    themeService.addListener(notifyListeners);
    favoritesService.addListener(notifyListeners);
    userPreferencesService.addListener(notifyListeners);

    _initialized = true;
  }

  Future<void> setThemeMode(ThemeMode mode) => themeService.setThemeMode(mode);

  Future<void> setLocale(Locale locale) => themeService.setLocale(locale);

  Future<void> completeOnboarding() =>
      userPreferencesService.completeOnboarding();

  Future<void> addRecentTool(String toolId) =>
      userPreferencesService.addRecentTool(toolId);

  Future<void> clearRecentTools() => userPreferencesService.clearRecentTools();

  int get streakCount => userPreferencesService.streakCount;

  String? getDailyRecommendation(List<String> allToolIds) =>
      userPreferencesService.getDailyRecommendation(allToolIds);

  List<String> getOrderedToolIds(List<String> allToolIds) =>
      userPreferencesService.getOrderedToolIds(allToolIds);

  Future<void> setToolOrder(List<String> order) =>
      userPreferencesService.setToolOrder(order);

  Future<void> toggleFavorite(String toolId) =>
      favoritesService.toggleFavorite(toolId);

  @override
  void dispose() {
    if (_initialized) {
      themeService.removeListener(notifyListeners);
      favoritesService.removeListener(notifyListeners);
      userPreferencesService.removeListener(notifyListeners);
      themeService.dispose();
      favoritesService.dispose();
      userPreferencesService.dispose();
    }
    super.dispose();
  }
}
