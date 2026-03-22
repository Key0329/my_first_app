import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeService extends ChangeNotifier {
  static const _keyThemeMode = 'theme_mode';
  static const _keyLocale = 'locale';

  final SharedPreferences _prefs;

  ThemeMode _themeMode = ThemeMode.system;
  Locale _locale = const Locale('zh', 'TW');

  ThemeService(this._prefs);

  ThemeMode get themeMode => _themeMode;
  Locale get locale => _locale;

  void loadFromPrefs() {
    final themeModeIndex = _prefs.getInt(_keyThemeMode);
    if (themeModeIndex != null &&
        themeModeIndex >= 0 &&
        themeModeIndex < ThemeMode.values.length) {
      _themeMode = ThemeMode.values[themeModeIndex];
    }

    final localeString = _prefs.getString(_keyLocale);
    if (localeString != null && localeString.isNotEmpty) {
      final parts = localeString.split('_');
      if (parts.length >= 2) {
        _locale = Locale(parts[0], parts[1]);
      } else {
        _locale = Locale(parts[0]);
      }
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    notifyListeners();
    await _prefs.setInt(_keyThemeMode, mode.index);
  }

  Future<void> setLocale(Locale locale) async {
    _locale = locale;
    notifyListeners();
    final localeString =
        locale.countryCode != null
            ? '${locale.languageCode}_${locale.countryCode}'
            : locale.languageCode;
    await _prefs.setString(_keyLocale, localeString);
  }
}
