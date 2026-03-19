import 'package:flutter/material.dart';

/// 工具分類，用於首頁 Tab 篩選。
enum ToolCategory {
  calculate('計算'),
  measure('測量'),
  life('生活');

  const ToolCategory(this.label);
  final String label;
}

class ToolItem {
  final String id;
  final String nameKey;
  final String fallbackName;
  final IconData icon;
  final Color color;
  final String routePath;
  final ToolCategory category;

  const ToolItem({
    required this.id,
    required this.nameKey,
    required this.fallbackName,
    required this.icon,
    required this.color,
    required this.routePath,
    required this.category,
  });
}

const List<ToolItem> allTools = [
  // ── 計算 ──
  ToolItem(
    id: 'calculator',
    nameKey: 'tool_calculator',
    fallbackName: '計算機',
    icon: Icons.calculate,
    color: Color(0xFF4CAF50),
    routePath: '/tools/calculator',
    category: ToolCategory.calculate,
  ),
  ToolItem(
    id: 'unit_converter',
    nameKey: 'tool_unit_converter',
    fallbackName: '單位換算',
    icon: Icons.swap_horiz,
    color: Color(0xFF2196F3),
    routePath: '/tools/unit-converter',
    category: ToolCategory.calculate,
  ),
  ToolItem(
    id: 'bmi_calculator',
    nameKey: 'tool_bmi_calculator',
    fallbackName: 'BMI 計算機',
    icon: Icons.monitor_heart,
    color: Color(0xFFE91E63),
    routePath: '/tools/bmi-calculator',
    category: ToolCategory.calculate,
  ),
  ToolItem(
    id: 'split_bill',
    nameKey: 'tool_split_bill',
    fallbackName: 'AA 制分帳',
    icon: Icons.groups,
    color: Color(0xFF26A69A),
    routePath: '/tools/split-bill',
    category: ToolCategory.calculate,
  ),
  // ── 測量 ──
  ToolItem(
    id: 'level',
    nameKey: 'tool_level',
    fallbackName: '水平儀',
    icon: Icons.straighten,
    color: Color(0xFF00BCD4),
    routePath: '/tools/level',
    category: ToolCategory.measure,
  ),
  ToolItem(
    id: 'compass',
    nameKey: 'tool_compass',
    fallbackName: '指南針',
    icon: Icons.explore,
    color: Color(0xFFFF5722),
    routePath: '/tools/compass',
    category: ToolCategory.measure,
  ),
  ToolItem(
    id: 'protractor',
    nameKey: 'tool_protractor',
    fallbackName: '量角器',
    icon: Icons.architecture,
    color: Color(0xFF795548),
    routePath: '/tools/protractor',
    category: ToolCategory.measure,
  ),
  ToolItem(
    id: 'screen_ruler',
    nameKey: 'tool_screen_ruler',
    fallbackName: '螢幕尺規',
    icon: Icons.square_foot,
    color: Color(0xFF5C6BC0),
    routePath: '/tools/screen-ruler',
    category: ToolCategory.measure,
  ),
  ToolItem(
    id: 'noise_meter',
    nameKey: 'tool_noise_meter',
    fallbackName: '噪音計',
    icon: Icons.mic,
    color: Color(0xFFE91E63),
    routePath: '/tools/noise-meter',
    category: ToolCategory.measure,
  ),
  // ── 生活 ──
  ToolItem(
    id: 'flashlight',
    nameKey: 'tool_flashlight',
    fallbackName: '手電筒',
    icon: Icons.flashlight_on,
    color: Color(0xFFFFC107),
    routePath: '/tools/flashlight',
    category: ToolCategory.life,
  ),
  ToolItem(
    id: 'stopwatch_timer',
    nameKey: 'tool_stopwatch_timer',
    fallbackName: '碼錶',
    icon: Icons.timer,
    color: Color(0xFF607D8B),
    routePath: '/tools/stopwatch-timer',
    category: ToolCategory.life,
  ),
  ToolItem(
    id: 'password_generator',
    nameKey: 'tool_password_generator',
    fallbackName: '密碼產生器',
    icon: Icons.lock,
    color: Color(0xFF3F51B5),
    routePath: '/tools/password-generator',
    category: ToolCategory.life,
  ),
  ToolItem(
    id: 'color_picker',
    nameKey: 'tool_color_picker',
    fallbackName: '色彩擷取',
    icon: Icons.colorize,
    color: Color(0xFFFF9800),
    routePath: '/tools/color-picker',
    category: ToolCategory.life,
  ),
  ToolItem(
    id: 'qr_generator',
    nameKey: 'tool_qr_generator',
    fallbackName: 'QR Code 產生器',
    icon: Icons.qr_code,
    color: Color(0xFF9C27B0),
    routePath: '/tools/qr-generator',
    category: ToolCategory.life,
  ),
  ToolItem(
    id: 'random_wheel',
    nameKey: 'tool_random_wheel',
    fallbackName: '隨機決定器',
    icon: Icons.casino,
    color: Color(0xFFFF7043),
    routePath: '/tools/random-wheel',
    category: ToolCategory.life,
  ),
];
