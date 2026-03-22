import 'package:flutter/material.dart';

/// 工具箱 App Design Tokens（Pixel 8 基準，411 x 914 dp）
abstract final class DT {
  // ── 品牌色 ──
  static const brandPrimary = Color(0xFF6C5CE7);
  static const brandPrimaryLight = Color(0xFF8B5CF6);
  static const brandPrimarySoft = Color(0xFFA78BFA);
  static const brandPrimaryBgLight = Color(0xFFF0EDFF);
  static const brandPrimaryBgDark = Color(0xFF2A2A4E);

  // ── 間距系統（4dp 基準）──
  static const spaceXs = 4.0;
  static const spaceSm = 8.0;
  static const spaceMd = 12.0;
  static const spaceLg = 16.0;
  static const spaceXl = 20.0;
  static const space2xl = 24.0;
  static const space3xl = 32.0;

  // ── 圓角系統 ──
  static const radiusSm = 10.0;
  static const radiusMd = 14.0;
  static const radiusLg = 16.0;
  static const radiusXl = 18.0;

  // ── 字體大小 ──
  static const fontTitle = 26.0;
  static const fontSubtitle = 14.0;
  static const fontTab = 14.0;
  static const fontToolName = 16.0;
  static const fontProBadge = 10.0;
  static const fontNavLabel = 12.0;

  // ── 工具頁面 Body ──
  static const toolBodyPadding = 16.0;
  static const toolSectionGap = 12.0;
  static const toolSectionRadius = 16.0;
  static const toolSectionPadding = 16.0;

  // ── 工具頁面按鈕 ──
  static const toolButtonRadius = 14.0;
  static const toolButtonHeight = 52.0;

  // ── 工具頁面字體 ──
  static const fontToolResult = 36.0;
  static const fontToolLabel = 14.0;
  static const fontToolButton = 16.0;

  // ── Motion Token ──
  static const durationFast = Duration(milliseconds: 150);
  static const durationMedium = Duration(milliseconds: 300);
  static const durationSlow = Duration(milliseconds: 500);

  // ── Opacity Token ──
  static const opacityDisabled = 0.38;
  static const opacityOverlay = 0.08;
  static const opacityHover = 0.04;

  // ── 元件尺寸 ──
  static const iconContainerSize = 48.0;
  static const iconSize = 24.0;
  static const searchButtonSize = 40.0;
  static const searchIconSize = 20.0;
  static const navIconSize = 24.0;
  static const gridSpacing = 12.0;

  // ── Light Mode ──
  static const lightPageBg = Color(0xFFFAFAFA);
  static const lightCardBg = Color(0xFFFFFFFF);
  static const lightCardBorder = Color(0xFFEEEEEE);
  static const lightTitle = Color(0xFF1A1A2E);
  static const lightSubtitle = Color(0xFF8888A0);
  static const lightTagActiveBg = Color(0xFF6C5CE7);
  static const lightTagActiveText = Color(0xFFFFFFFF);
  static const lightTagInactiveBg = Color(0xFFF0EDFF);
  static const lightTagInactiveText = Color(0xFF6C5CE7);
  static const lightNavActive = Color(0xFF6C5CE7);
  static const lightNavInactive = Color(0xFFAAAAAA);
  static const lightNavBg = Color(0xFFFFFFFF);
  static const lightNavBorder = Color(0xFFEEEEEE);

  // ── Dark Mode ──
  static const darkPageBg = Color(0xFF1A1A2E);
  static const darkCardBg = Color(0xFF16213E);
  static const darkCardBorder = Color(0xFF2A2A4E);
  static const darkTitle = Color(0xFFEEEEFF);
  static const darkSubtitle = Color(0xFF7777A0);
  static const darkTagActiveBg = Color(0xFF6C5CE7);
  static const darkTagActiveText = Color(0xFFFFFFFF);
  static const darkTagInactiveBg = Color(0xFF2A2A4E);
  static const darkTagInactiveText = Color(0xFFA78BFA);
  static const darkNavActive = Color(0xFFA78BFA);
  static const darkNavInactive = Color(0xFF555577);
  static const darkNavBg = Color(0xFF16213E);
  static const darkNavBorder = Color(0xFF2A2A4E);

  // ── Brightness helpers ──
  static Color pageBg(Brightness b) =>
      b == Brightness.dark ? darkPageBg : lightPageBg;
  static Color cardBg(Brightness b) =>
      b == Brightness.dark ? darkCardBg : lightCardBg;
  static Color cardBorder(Brightness b) =>
      b == Brightness.dark ? darkCardBorder : lightCardBorder;
  static Color title(Brightness b) =>
      b == Brightness.dark ? darkTitle : lightTitle;
  static Color subtitle(Brightness b) =>
      b == Brightness.dark ? darkSubtitle : lightSubtitle;
  static Color tagActiveBg(Brightness b) =>
      b == Brightness.dark ? darkTagActiveBg : lightTagActiveBg;
  static Color tagActiveText(Brightness b) =>
      b == Brightness.dark ? darkTagActiveText : lightTagActiveText;
  static Color tagInactiveBg(Brightness b) =>
      b == Brightness.dark ? darkTagInactiveBg : lightTagInactiveBg;
  static Color tagInactiveText(Brightness b) =>
      b == Brightness.dark ? darkTagInactiveText : lightTagInactiveText;
  static Color navActive(Brightness b) =>
      b == Brightness.dark ? darkNavActive : lightNavActive;
  static Color navInactive(Brightness b) =>
      b == Brightness.dark ? darkNavInactive : lightNavInactive;
  static Color navBg(Brightness b) =>
      b == Brightness.dark ? darkNavBg : lightNavBg;
  static Color navBorder(Brightness b) =>
      b == Brightness.dark ? darkNavBorder : lightNavBorder;
  static Color toolName(Brightness b) => title(b);
  static Color searchIconBg(Brightness b) =>
      b == Brightness.dark ? brandPrimaryBgDark : brandPrimaryBgLight;
  static Color searchIconColor(Brightness b) =>
      b == Brightness.dark ? brandPrimarySoft : brandPrimary;
}

/// 工具圖標漸層色，方向 135°（左上到右下）。
const Map<String, List<Color>> toolGradients = {
  'calculator': [Color(0xFF6C5CE7), Color(0xFFA855F7)],
  'unit_converter': [Color(0xFF0EA5E9), Color(0xFF38BDF8)],
  'bmi_calculator': [Color(0xFFEC4899), Color(0xFFF472B6)],
  'split_bill': [Color(0xFF8B5CF6), Color(0xFFA78BFA)],
  'level': [Color(0xFF0EA5E9), Color(0xFF38BDF8)],
  'compass': [Color(0xFF10B981), Color(0xFF34D399)],
  'protractor': [Color(0xFF14B8A6), Color(0xFF2DD4BF)],
  'screen_ruler': [Color(0xFFEF4444), Color(0xFFF87171)],
  'noise_meter': [Color(0xFF14B8A6), Color(0xFF2DD4BF)],
  'flashlight': [Color(0xFFF59E0B), Color(0xFFFBBF24)],
  'stopwatch_timer': [Color(0xFFF59E0B), Color(0xFFFBBF24)],
  'password_generator': [Color(0xFF6C5CE7), Color(0xFFA855F7)],
  'color_picker': [Color(0xFFEC4899), Color(0xFFF472B6)],
  'qr_generator': [Color(0xFF10B981), Color(0xFF34D399)],
  'random_wheel': [Color(0xFFEF4444), Color(0xFFF87171)],
};
