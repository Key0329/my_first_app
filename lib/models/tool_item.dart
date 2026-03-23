import 'package:flutter/material.dart';
import 'package:my_first_app/theme/design_tokens.dart';
import 'package:my_first_app/tools/calculator/calculator_page.dart';
import 'package:my_first_app/tools/unit_converter/unit_converter_page.dart';
import 'package:my_first_app/tools/bmi_calculator/bmi_calculator_page.dart';
import 'package:my_first_app/tools/split_bill/split_bill_page.dart';
import 'package:my_first_app/tools/date_calculator/date_calculator_page.dart';
import 'package:my_first_app/tools/level/level_page.dart';
import 'package:my_first_app/tools/compass/compass_page.dart';
import 'package:my_first_app/tools/protractor/protractor_page.dart';
import 'package:my_first_app/tools/screen_ruler/screen_ruler_page.dart';
import 'package:my_first_app/tools/noise_meter/noise_meter_page.dart';
import 'package:my_first_app/tools/flashlight/flashlight_page.dart';
import 'package:my_first_app/tools/stopwatch_timer/stopwatch_timer_page.dart';
import 'package:my_first_app/tools/password_generator/password_generator_page.dart';
import 'package:my_first_app/tools/color_picker/color_picker_page.dart';
import 'package:my_first_app/tools/qr_generator/qr_generator_page.dart';
import 'package:my_first_app/tools/qr_scanner_live/qr_scanner_live_page.dart';
import 'package:my_first_app/tools/currency_converter/currency_converter_page.dart';
import 'package:my_first_app/tools/random_wheel/random_wheel_page.dart';
import 'package:my_first_app/tools/word_counter/word_counter_page.dart';
import 'package:my_first_app/tools/pomodoro/pomodoro_page.dart';
import 'package:my_first_app/tools/quick_notes/quick_notes_page.dart';

/// 工具分類，用於首頁 Tab 篩選（保留向下相容）。
enum ToolCategory {
  calculate('計算'),
  measure('測量'),
  life('生活');

  const ToolCategory(this.label);
  final String label;
}

/// 多標籤分類系統，每個工具可有 1-3 個 tag。
enum ToolTag { calculate, measure, life, productivity, finance }

class ToolItem {
  final String id;
  final String nameKey;
  final String fallbackName;
  final IconData icon;
  final String routePath;
  final Set<ToolTag> tags;
  final Widget Function() pageBuilder;

  /// 向下相容：回傳主要分類（tags 的第一個元素對應的 ToolCategory）。
  ToolCategory get category {
    final first = tags.first;
    switch (first) {
      case ToolTag.calculate:
      case ToolTag.finance:
        return ToolCategory.calculate;
      case ToolTag.measure:
        return ToolCategory.measure;
      case ToolTag.life:
      case ToolTag.productivity:
        return ToolCategory.life;
    }
  }

  /// 工具色彩，自動從 [toolGradients] 的第一色取得，確保色彩一致性。
  Color get color => toolGradients[id]?.first ?? DT.brandPrimary;

  ToolItem({
    required this.id,
    required this.nameKey,
    required this.fallbackName,
    required this.icon,
    required this.routePath,
    required this.tags,
    required this.pageBuilder,
  });
}

final List<ToolItem> allTools = [
  // ── 計算 ──
  ToolItem(
    id: 'calculator',
    nameKey: 'tool_calculator',
    fallbackName: '計算機',
    icon: Icons.calculate,
    routePath: '/tools/calculator',
    tags: {ToolTag.calculate, ToolTag.finance},
    pageBuilder: () => const CalculatorPage(),
  ),
  ToolItem(
    id: 'unit_converter',
    nameKey: 'tool_unit_converter',
    fallbackName: '單位換算',
    icon: Icons.swap_horiz,
    routePath: '/tools/unit-converter',
    tags: {ToolTag.calculate},
    pageBuilder: () => const UnitConverterPage(),
  ),
  ToolItem(
    id: 'bmi_calculator',
    nameKey: 'tool_bmi_calculator',
    fallbackName: 'BMI 計算機',
    icon: Icons.monitor_heart,
    routePath: '/tools/bmi-calculator',
    tags: {ToolTag.calculate, ToolTag.life},
    pageBuilder: () => const BmiCalculatorPage(),
  ),
  ToolItem(
    id: 'split_bill',
    nameKey: 'tool_split_bill',
    fallbackName: 'AA 制分帳',
    icon: Icons.groups,
    routePath: '/tools/split-bill',
    tags: {ToolTag.calculate, ToolTag.finance},
    pageBuilder: () => const SplitBillPage(),
  ),
  ToolItem(
    id: 'date_calculator',
    nameKey: 'tool_date_calculator',
    fallbackName: '日期計算機',
    icon: Icons.date_range,
    routePath: '/tools/date-calculator',
    tags: {ToolTag.calculate, ToolTag.productivity},
    pageBuilder: () => const DateCalculatorPage(),
  ),
  // ── 測量 ──
  ToolItem(
    id: 'level',
    nameKey: 'tool_level',
    fallbackName: '水平儀',
    icon: Icons.straighten,
    routePath: '/tools/level',
    tags: {ToolTag.measure},
    pageBuilder: () => const LevelPage(),
  ),
  ToolItem(
    id: 'compass',
    nameKey: 'tool_compass',
    fallbackName: '指南針',
    icon: Icons.explore,
    routePath: '/tools/compass',
    tags: {ToolTag.measure},
    pageBuilder: () => const CompassPage(),
  ),
  ToolItem(
    id: 'protractor',
    nameKey: 'tool_protractor',
    fallbackName: '量角器',
    icon: Icons.architecture,
    routePath: '/tools/protractor',
    tags: {ToolTag.measure},
    pageBuilder: () => const ProtractorPage(),
  ),
  ToolItem(
    id: 'screen_ruler',
    nameKey: 'tool_screen_ruler',
    fallbackName: '螢幕尺規',
    icon: Icons.square_foot,
    routePath: '/tools/screen-ruler',
    tags: {ToolTag.measure},
    pageBuilder: () => const ScreenRulerPage(),
  ),
  ToolItem(
    id: 'noise_meter',
    nameKey: 'tool_noise_meter',
    fallbackName: '噪音計',
    icon: Icons.mic,
    routePath: '/tools/noise-meter',
    tags: {ToolTag.measure},
    pageBuilder: () => const NoiseMeterPage(),
  ),
  // ── 生活 ──
  ToolItem(
    id: 'flashlight',
    nameKey: 'tool_flashlight',
    fallbackName: '手電筒',
    icon: Icons.flashlight_on,
    routePath: '/tools/flashlight',
    tags: {ToolTag.life},
    pageBuilder: () => const FlashlightPage(),
  ),
  ToolItem(
    id: 'stopwatch_timer',
    nameKey: 'tool_stopwatch_timer',
    fallbackName: '碼錶',
    icon: Icons.timer,
    routePath: '/tools/stopwatch-timer',
    tags: {ToolTag.life, ToolTag.productivity},
    pageBuilder: () => const StopwatchTimerPage(),
  ),
  ToolItem(
    id: 'password_generator',
    nameKey: 'tool_password_generator',
    fallbackName: '密碼產生器',
    icon: Icons.lock,
    routePath: '/tools/password-generator',
    tags: {ToolTag.life, ToolTag.productivity},
    pageBuilder: () => const PasswordGeneratorPage(),
  ),
  ToolItem(
    id: 'color_picker',
    nameKey: 'tool_color_picker',
    fallbackName: '色彩擷取',
    icon: Icons.colorize,
    routePath: '/tools/color-picker',
    tags: {ToolTag.life},
    pageBuilder: () => const ColorPickerPage(),
  ),
  ToolItem(
    id: 'qr_generator',
    nameKey: 'tool_qr_generator',
    fallbackName: 'QR Code 產生器',
    icon: Icons.qr_code,
    routePath: '/tools/qr-generator',
    tags: {ToolTag.life},
    pageBuilder: () => const QrGeneratorPage(),
  ),
  ToolItem(
    id: 'qr_scanner_live',
    nameKey: 'tool_qr_scanner_live',
    fallbackName: 'QR 掃描',
    icon: Icons.qr_code_scanner,
    routePath: '/tools/qr-scanner-live',
    tags: {ToolTag.life},
    pageBuilder: () => const QrScannerLivePage(),
  ),
  ToolItem(
    id: 'currency_converter',
    nameKey: 'tool_currency_converter',
    fallbackName: '匯率換算',
    icon: Icons.currency_exchange,
    routePath: '/tools/currency-converter',
    tags: {ToolTag.calculate, ToolTag.finance},
    pageBuilder: () => const CurrencyConverterPage(),
  ),
  ToolItem(
    id: 'random_wheel',
    nameKey: 'tool_random_wheel',
    fallbackName: '隨機決定器',
    icon: Icons.casino,
    routePath: '/tools/random-wheel',
    tags: {ToolTag.life},
    pageBuilder: () => const RandomWheelPage(),
  ),
  ToolItem(
    id: 'word_counter',
    nameKey: 'tool_word_counter',
    fallbackName: '文字計數器',
    icon: Icons.text_fields,
    routePath: '/tools/word-counter',
    tags: {ToolTag.life, ToolTag.productivity},
    pageBuilder: () => const WordCounterPage(),
  ),
  ToolItem(
    id: 'pomodoro',
    nameKey: 'tool_pomodoro',
    fallbackName: '番茄鐘',
    icon: Icons.timer_outlined,
    routePath: '/tools/pomodoro',
    tags: {ToolTag.productivity, ToolTag.life},
    pageBuilder: () => const PomodoroPage(),
  ),
  ToolItem(
    id: 'quick_notes',
    nameKey: 'tool_quick_notes',
    fallbackName: '快速筆記',
    icon: Icons.note_alt_outlined,
    routePath: '/tools/quick-notes',
    tags: {ToolTag.productivity, ToolTag.life},
    pageBuilder: () => const QuickNotesPage(),
  ),
];
