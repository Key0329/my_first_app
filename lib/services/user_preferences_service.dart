import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferencesService extends ChangeNotifier {
  static const _keyOnboarding = 'hasCompletedOnboarding';
  static const _keyRecentTools = 'recent_tools';
  static const _maxRecentTools = 5;

  final SharedPreferences _prefs;

  bool _hasCompletedOnboarding = false;
  List<String> _recentTools = [];

  UserPreferencesService(this._prefs);

  bool get hasCompletedOnboarding => _hasCompletedOnboarding;
  List<String> get recentTools => List.unmodifiable(_recentTools);

  void loadFromPrefs() {
    _hasCompletedOnboarding = _prefs.getBool(_keyOnboarding) ?? false;
    _recentTools = _prefs.getStringList(_keyRecentTools) ?? [];
  }

  Future<void> completeOnboarding() async {
    _hasCompletedOnboarding = true;
    notifyListeners();
    await _prefs.setBool(_keyOnboarding, true);
  }

  Future<void> addRecentTool(String toolId) async {
    _recentTools.remove(toolId);
    _recentTools.insert(0, toolId);
    if (_recentTools.length > _maxRecentTools) {
      _recentTools = _recentTools.sublist(0, _maxRecentTools);
    }
    notifyListeners();
    await _prefs.setStringList(_keyRecentTools, _recentTools);
  }

  Future<void> clearRecentTools() async {
    _recentTools.clear();
    notifyListeners();
    await _prefs.remove(_keyRecentTools);
  }
}
