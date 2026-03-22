import 'dart:ui';

/// 根據分貝值回傳對應的顏色。
///
/// - db < 45 → 綠色 (安靜)
/// - 45 <= db < 70 → 黃色 (中等)
/// - 70 <= db < 90 → 橘色 (嘈雜)
/// - db >= 90 → 紅色 (危險)
Color getDbColor(double db) {
  if (db < 45) return const Color(0xFF4CAF50);
  if (db < 70) return const Color(0xFFFFC107);
  if (db < 90) return const Color(0xFFFF9800);
  return const Color(0xFFF44336);
}

/// 根據分貝值回傳噪音等級分類字串。
///
/// - db < 30 → `'quiet'`
/// - 30 <= db < 60 → `'moderate'`
/// - 60 <= db < 85 → `'loud'`
/// - db >= 85 → `'dangerous'`
String classifyDbLevel(double db) {
  if (db < 30) return 'quiet';
  if (db < 60) return 'moderate';
  if (db < 85) return 'loud';
  return 'dangerous';
}

/// 取得目前分貝值所落在的參考等級索引。
///
/// 對應常見噪音等級參考：
/// - db >= 110 → 3 (演唱會)
/// - 80 <= db < 110 → 2 (交通)
/// - 60 <= db < 80 → 1 (對話)
/// - 30 <= db < 60 → 0 (耳語)
/// - db < 30 → -1 (低於最低參考值)
int getActiveReferenceIndex(double db) {
  if (db >= 110) return 3;
  if (db >= 80) return 2;
  if (db >= 60) return 1;
  if (db >= 30) return 0;
  return -1;
}
