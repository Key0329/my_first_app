import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferencesService extends ChangeNotifier {
  static const _keyOnboarding = 'hasCompletedOnboarding';
  static const _keyRecentTools = 'recent_tools';
  static const _maxRecentTools = 5;
  static const _keyStreakCount = 'streak_count';
  static const _keyStreakLastDate = 'streak_last_date';
  static const _keyToolOrder = 'tool_order';

  final SharedPreferences _prefs;

  bool _hasCompletedOnboarding = false;
  List<String> _recentTools = [];
  int _streakCount = 0;
  String _streakLastDate = '';
  List<String> _toolOrder = [];

  UserPreferencesService(this._prefs);

  bool get hasCompletedOnboarding => _hasCompletedOnboarding;
  List<String> get recentTools => List.unmodifiable(_recentTools);
  int get streakCount => _streakCount;
  List<String> get toolOrder => List.unmodifiable(_toolOrder);

  void loadFromPrefs() {
    _hasCompletedOnboarding = _prefs.getBool(_keyOnboarding) ?? false;
    _recentTools = _prefs.getStringList(_keyRecentTools) ?? [];
    _streakCount = _prefs.getInt(_keyStreakCount) ?? 0;
    _streakLastDate = _prefs.getString(_keyStreakLastDate) ?? '';
    _toolOrder = _prefs.getStringList(_keyToolOrder) ?? [];
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
    await _recordDailyUsage();
    notifyListeners();
    await _prefs.setStringList(_keyRecentTools, _recentTools);
  }

  Future<void> clearRecentTools() async {
    _recentTools.clear();
    notifyListeners();
    await _prefs.remove(_keyRecentTools);
  }

  // ── 工具排序 ──

  /// 根據儲存的排序重新排列工具 ID 列表。不在排序中的 ID 附加到尾部。
  List<String> getOrderedToolIds(List<String> allToolIds) {
    if (_toolOrder.isEmpty) return allToolIds;

    final ordered = <String>[];
    for (final id in _toolOrder) {
      if (allToolIds.contains(id)) {
        ordered.add(id);
      }
    }
    // 新工具附加到尾部
    for (final id in allToolIds) {
      if (!ordered.contains(id)) {
        ordered.add(id);
      }
    }
    return ordered;
  }

  Future<void> setToolOrder(List<String> order) async {
    _toolOrder = List.from(order);
    notifyListeners();
    await _prefs.setStringList(_keyToolOrder, _toolOrder);
  }

  // ── Streak 追蹤 ──

  Future<void> _recordDailyUsage() async {
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    if (_streakLastDate == today) return; // 同一天不重複計算

    if (_streakLastDate.isNotEmpty) {
      final lastDate = DateTime.parse(_streakLastDate);
      final todayDate = DateTime.parse(today);
      final diff = todayDate.difference(lastDate).inDays;

      if (diff == 1) {
        _streakCount++;
      } else if (diff > 1) {
        _streakCount = 1; // Streak broken
      }
    } else {
      _streakCount = 1; // First usage
    }

    _streakLastDate = today;
    await _prefs.setInt(_keyStreakCount, _streakCount);
    await _prefs.setString(_keyStreakLastDate, _streakLastDate);
  }

  // ── 每日推薦工具 ──

  /// 根據今日日期和最近使用的工具，推薦一個不常用的工具 ID。
  String? getDailyRecommendation(List<String> allToolIds) {
    if (allToolIds.isEmpty) return null;

    // 排除最近使用的前 5 個
    final candidates = allToolIds
        .where((id) => !_recentTools.contains(id))
        .toList();
    final pool = candidates.isNotEmpty ? candidates : allToolIds;

    // 用今日日期做 seed，確保同一天推薦同一個
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final seed = today.hashCode.abs();
    return pool[seed % pool.length];
  }
}
