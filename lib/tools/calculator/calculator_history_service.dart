import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'calculator_logic.dart';

/// 計算機歷史紀錄持久化服務。
///
/// 使用 [SharedPreferences] 儲存最多 [maxEntries] 筆歷史紀錄。
class CalculatorHistoryService {
  static const String _key = 'calculator_history';

  /// 歷史紀錄上限。
  static const int maxEntries = 100;

  /// 從 SharedPreferences 載入歷史紀錄。
  Future<List<CalculationEntry>> load() async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_key);
    if (list == null) return [];

    return list.map((jsonStr) {
      final map = jsonDecode(jsonStr) as Map<String, dynamic>;
      return CalculationEntry.fromJson(map);
    }).toList();
  }

  /// 儲存歷史紀錄至 SharedPreferences。
  Future<void> save(List<CalculationEntry> entries) async {
    final prefs = await SharedPreferences.getInstance();
    final trimmed =
        entries.length > maxEntries ? entries.sublist(0, maxEntries) : entries;
    final list = trimmed.map((e) => jsonEncode(e.toJson())).toList();
    await prefs.setStringList(_key, list);
  }

  /// 新增一筆紀錄並儲存（插入到最前面，超過上限則移除最舊的）。
  Future<List<CalculationEntry>> add(
    CalculationEntry entry,
    List<CalculationEntry> current,
  ) async {
    final updated = [entry, ...current];
    if (updated.length > maxEntries) {
      updated.removeRange(maxEntries, updated.length);
    }
    await save(updated);
    return updated;
  }

  /// 清除所有歷史紀錄。
  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
