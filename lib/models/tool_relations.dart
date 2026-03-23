import 'tool_item.dart';

/// 工具推薦關聯圖譜。
///
/// 每個工具 ID 對應 1-2 個推薦的相關工具 ID。
/// 策展邏輯：同場景關聯 > 互補關聯 > 同類別。
const Map<String, List<String>> toolRelations = {
  // ── 計算 ──
  'calculator': ['unit_converter', 'currency_converter'],
  'unit_converter': ['calculator', 'bmi_calculator'],
  'bmi_calculator': ['unit_converter', 'date_calculator'],
  'split_bill': ['calculator', 'currency_converter'],
  'date_calculator': ['stopwatch_timer', 'calculator'],
  'currency_converter': ['split_bill', 'unit_converter'],
  // ── 測量 ──
  'level': ['protractor', 'screen_ruler'],
  'compass': ['level', 'noise_meter'],
  'protractor': ['level', 'screen_ruler'],
  'screen_ruler': ['protractor', 'level'],
  'noise_meter': ['compass', 'stopwatch_timer'],
  // ── 生活 ──
  'flashlight': ['compass', 'stopwatch_timer'],
  'stopwatch_timer': ['date_calculator', 'flashlight'],
  'password_generator': ['qr_generator', 'random_wheel'],
  'color_picker': ['qr_generator', 'screen_ruler'],
  'qr_generator': ['qr_scanner_live', 'password_generator'],
  'qr_scanner_live': ['qr_generator', 'currency_converter'],
  'random_wheel': ['split_bill', 'password_generator'],
};

/// 取得指定工具的推薦工具列表。
///
/// 如果 [toolRelations] 中有定義，直接回傳；
/// 否則 fallback 至同 category 的其他工具（最多 2 個）。
List<ToolItem> getRecommendations(String toolId) {
  final relatedIds = toolRelations[toolId];

  if (relatedIds != null && relatedIds.isNotEmpty) {
    return relatedIds
        .map(
          (id) => allTools.cast<ToolItem?>().firstWhere(
            (t) => t!.id == id,
            orElse: () => null,
          ),
        )
        .whereType<ToolItem>()
        .toList();
  }

  // Fallback: same category
  final currentTool = allTools.cast<ToolItem?>().firstWhere(
    (t) => t!.id == toolId,
    orElse: () => null,
  );
  if (currentTool == null) return [];

  return allTools
      .where((t) => t.category == currentTool.category && t.id != toolId)
      .take(2)
      .toList();
}
