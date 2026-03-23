import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_first_app/services/user_preferences_service.dart';

// 輔助：格式化日期字串
String _fmt(DateTime d) => DateFormat('yyyy-MM-dd').format(d);

// 輔助：建立並載入 service
Future<UserPreferencesService> _buildService(Map<String, Object> values) async {
  SharedPreferences.setMockInitialValues(values);
  final prefs = await SharedPreferences.getInstance();
  final service = UserPreferencesService(prefs);
  service.loadFromPrefs();
  return service;
}

void main() {
  group('UserPreferencesService — streak', () {
    // 1. 初始 streakCount 為 0（SharedPreferences 無任何值）
    test('initial streakCount is 0 when no prefs stored', () async {
      final service = await _buildService({});
      expect(service.streakCount, 0);
    });

    // 2. 首次 addRecentTool（_streakLastDate 為空）→ streak 設為 1
    test('first addRecentTool sets streak to 1', () async {
      final service = await _buildService({});
      expect(service.streakCount, 0);

      await service.addRecentTool('calculator');
      expect(service.streakCount, 1);
    });

    // 3. loadFromPrefs 正確讀取已儲存的 streak 值
    test('loadFromPrefs restores persisted streak correctly', () async {
      final today = _fmt(DateTime.now());
      // 模擬已有 streak = 5 且今天已記錄（不會再變動）
      final service = await _buildService({
        'streak_count': 5,
        'streak_last_date': today,
      });
      expect(service.streakCount, 5);
    });

    // 4. 昨天有使用 → addRecentTool 今天呼叫 → streak +1
    test('addRecentTool after one day gap increments streak', () async {
      final yesterday = _fmt(DateTime.now().subtract(const Duration(days: 1)));
      final service = await _buildService({
        'streak_count': 3,
        'streak_last_date': yesterday,
      });
      expect(service.streakCount, 3);

      await service.addRecentTool('bmi-calculator');
      expect(service.streakCount, 4);
    });

    // 5. 超過一天未使用 → streak 重置為 1
    test('addRecentTool after more than one day resets streak to 1', () async {
      final twoDaysAgo = _fmt(DateTime.now().subtract(const Duration(days: 2)));
      final service = await _buildService({
        'streak_count': 7,
        'streak_last_date': twoDaysAgo,
      });
      expect(service.streakCount, 7);

      await service.addRecentTool('qr-scanner');
      expect(service.streakCount, 1);
    });

    // 6. 同一天重複呼叫 addRecentTool → streak 不變
    test('same-day addRecentTool does not change streak', () async {
      final today = _fmt(DateTime.now());
      final service = await _buildService({
        'streak_count': 3,
        'streak_last_date': today,
      });
      expect(service.streakCount, 3);

      await service.addRecentTool('currency-converter');
      // 同一天，streak 應維持 3
      expect(service.streakCount, 3);
    });

    // 7. streak 更新後寫入 SharedPreferences，新實例 loadFromPrefs 可讀到
    test('streak persists to SharedPreferences after addRecentTool', () async {
      final yesterday = _fmt(DateTime.now().subtract(const Duration(days: 1)));
      SharedPreferences.setMockInitialValues({
        'streak_count': 2,
        'streak_last_date': yesterday,
      });
      final prefs = await SharedPreferences.getInstance();
      final service = UserPreferencesService(prefs);
      service.loadFromPrefs();

      await service.addRecentTool('date-calculator');
      // streak 應增加到 3
      expect(service.streakCount, 3);

      // 新實例從同一 prefs 讀取
      final service2 = UserPreferencesService(prefs);
      service2.loadFromPrefs();
      expect(service2.streakCount, 3);
    });
  });

  group('UserPreferencesService — getDailyRecommendation', () {
    // 8. 空清單回傳 null
    test('returns null for empty allToolIds list', () async {
      final service = await _buildService({});
      expect(service.getDailyRecommendation([]), isNull);
    });

    // 9. 非空清單回傳非 null 字串
    test('returns non-null for non-empty allToolIds list', () async {
      final service = await _buildService({});
      final result = service.getDailyRecommendation(['a', 'b', 'c', 'd', 'e']);
      expect(result, isNotNull);
      expect(result, isA<String>());
    });

    // 10. 優先推薦不在最近使用清單的工具
    test('excludes recent tools when candidates are available', () async {
      final today = _fmt(DateTime.now());
      // recent_tools 內含 'a', 'b', 'c', 'd', 'e'
      SharedPreferences.setMockInitialValues({
        'recent_tools': ['a', 'b', 'c', 'd', 'e'],
        'streak_last_date': today,
      });
      final prefs = await SharedPreferences.getInstance();
      final service = UserPreferencesService(prefs);
      service.loadFromPrefs();

      // allToolIds 包含 recent 外加 'x', 'y'
      final result = service.getDailyRecommendation([
        'a',
        'b',
        'c',
        'd',
        'e',
        'x',
        'y',
      ]);
      expect(result, isNotNull);
      // 應從非 recent 的 ['x', 'y'] 中選
      expect(['x', 'y'], contains(result));
    });

    // 11. 所有工具都在最近使用時，仍回傳非 null
    test('returns something even when all tools are recent', () async {
      final today = _fmt(DateTime.now());
      SharedPreferences.setMockInitialValues({
        'recent_tools': ['a', 'b', 'c'],
        'streak_last_date': today,
      });
      final prefs = await SharedPreferences.getInstance();
      final service = UserPreferencesService(prefs);
      service.loadFromPrefs();

      final result = service.getDailyRecommendation(['a', 'b', 'c']);
      expect(result, isNotNull);
      expect(['a', 'b', 'c'], contains(result));
    });

    // 12. 同一天呼叫兩次回傳相同結果（日期 hash 確定性）
    test('same day returns same recommendation (deterministic)', () async {
      final service = await _buildService({});
      const tools = ['a', 'b', 'c', 'd', 'e'];

      final result1 = service.getDailyRecommendation(tools);
      final result2 = service.getDailyRecommendation(tools);
      expect(result1, equals(result2));
    });

    // 13. 回傳值一定在 allToolIds 之內
    test('returned id is always from allToolIds', () async {
      final service = await _buildService({});
      const tools = ['tool-1', 'tool-2', 'tool-3'];
      final result = service.getDailyRecommendation(tools);
      expect(tools, contains(result));
    });
  });
}
