import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 預設品牌色選項。
enum AccentColorOption {
  purple(Color(0xFF6C5CE7), 'accentColorPurple'),
  blue(Color(0xFF3B82F6), 'accentColorBlue'),
  green(Color(0xFF10B981), 'accentColorGreen'),
  red(Color(0xFFEF4444), 'accentColorRed'),
  orange(Color(0xFFF59E0B), 'accentColorOrange'),
  pink(Color(0xFFEC4899), 'accentColorPink');

  const AccentColorOption(this.color, this.l10nKey);
  final Color color;
  final String l10nKey;
}

class ThemeService extends ChangeNotifier {
  static const _keyThemeMode = 'theme_mode';
  static const _keyLocale = 'locale';
  static const _keyAccentColor = 'accent_color';

  final SharedPreferences _prefs;

  ThemeMode _themeMode = ThemeMode.system;
  Locale _locale = const Locale('zh', 'TW');
  AccentColorOption _accentColor = AccentColorOption.purple;

  ThemeService(this._prefs);

  ThemeMode get themeMode => _themeMode;
  Locale get locale => _locale;
  AccentColorOption get accentColor => _accentColor;
  Color get accentColorValue => _accentColor.color;

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

    final accentIndex = _prefs.getInt(_keyAccentColor);
    if (accentIndex != null &&
        accentIndex >= 0 &&
        accentIndex < AccentColorOption.values.length) {
      _accentColor = AccentColorOption.values[accentIndex];
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
    final localeString = locale.countryCode != null
        ? '${locale.languageCode}_${locale.countryCode}'
        : locale.languageCode;
    await _prefs.setString(_keyLocale, localeString);
  }

  Future<void> setAccentColor(AccentColorOption option) async {
    _accentColor = option;
    notifyListeners();
    await _prefs.setInt(_keyAccentColor, option.index);
  }
}
