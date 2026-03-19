import 'package:flutter/material.dart';

/// Bento grid tile size variants.
///
/// - [large]: spans 2 columns, 1.5x height (used for favorited tools at display time)
/// - [medium]: 1 column, 1.2x height (standard default)
/// - [small]: 1 column, 1x height (compact)
enum BentoSize { large, medium, small }

class ToolItem {
  final String id;
  final String nameKey;
  final String fallbackName;
  final IconData icon;
  final Color color;
  final String routePath;

  /// The default bento tile size for this tool.
  ///
  /// Favorited tools are dynamically upgraded to [BentoSize.large] at display
  /// time; this field stores the non-favorited default only.
  final BentoSize defaultBentoSize;

  const ToolItem({
    required this.id,
    required this.nameKey,
    required this.fallbackName,
    required this.icon,
    required this.color,
    required this.routePath,
    this.defaultBentoSize = BentoSize.medium,
  });
}

const List<ToolItem> allTools = [
  ToolItem(
    id: 'calculator',
    nameKey: 'tool_calculator',
    fallbackName: '計算機',
    icon: Icons.calculate,
    color: Color(0xFF4CAF50),
    routePath: '/tools/calculator',
  ),
  ToolItem(
    id: 'unit_converter',
    nameKey: 'tool_unit_converter',
    fallbackName: '單位換算',
    icon: Icons.swap_horiz,
    color: Color(0xFF2196F3),
    routePath: '/tools/unit-converter',
  ),
  ToolItem(
    id: 'qr_generator',
    nameKey: 'tool_qr_generator',
    fallbackName: 'QR Code 產生器',
    icon: Icons.qr_code,
    color: Color(0xFF9C27B0),
    routePath: '/tools/qr-generator',
  ),
  ToolItem(
    id: 'flashlight',
    nameKey: 'tool_flashlight',
    fallbackName: '手電筒',
    icon: Icons.flashlight_on,
    color: Color(0xFFFFC107),
    routePath: '/tools/flashlight',
  ),
  ToolItem(
    id: 'level',
    nameKey: 'tool_level',
    fallbackName: '水平儀',
    icon: Icons.straighten,
    color: Color(0xFF00BCD4),
    routePath: '/tools/level',
  ),
  ToolItem(
    id: 'compass',
    nameKey: 'tool_compass',
    fallbackName: '指南針',
    icon: Icons.explore,
    color: Color(0xFFFF5722),
    routePath: '/tools/compass',
  ),
  ToolItem(
    id: 'stopwatch_timer',
    nameKey: 'tool_stopwatch_timer',
    fallbackName: '碼錶',
    icon: Icons.timer,
    color: Color(0xFF607D8B),
    routePath: '/tools/stopwatch-timer',
  ),
  ToolItem(
    id: 'noise_meter',
    nameKey: 'tool_noise_meter',
    fallbackName: '噪音計',
    icon: Icons.mic,
    color: Color(0xFFE91E63),
    routePath: '/tools/noise-meter',
  ),
  ToolItem(
    id: 'password_generator',
    nameKey: 'tool_password_generator',
    fallbackName: '密碼產生器',
    icon: Icons.lock,
    color: Color(0xFF3F51B5),
    routePath: '/tools/password-generator',
  ),
  ToolItem(
    id: 'color_picker',
    nameKey: 'tool_color_picker',
    fallbackName: '色彩擷取',
    icon: Icons.colorize,
    color: Color(0xFFFF9800),
    routePath: '/tools/color-picker',
  ),
  ToolItem(
    id: 'protractor',
    nameKey: 'tool_protractor',
    fallbackName: '量角器',
    icon: Icons.architecture,
    color: Color(0xFF795548),
    routePath: '/tools/protractor',
  ),
  ToolItem(
    id: 'invoice_checker',
    nameKey: 'tool_invoice_checker',
    fallbackName: '發票對獎',
    icon: Icons.receipt_long,
    color: Color(0xFF009688),
    routePath: '/tools/invoice-checker',
  ),
];
