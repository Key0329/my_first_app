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
  static const lightSubtitle = Color(0xFF6B6B82);
  static const lightTagActiveBg = Color(0xFF6C5CE7);
  static const lightTagActiveText = Color(0xFFFFFFFF);
  static const lightTagInactiveBg = Color(0xFFF0EDFF);
  static const lightTagInactiveText = Color(0xFF6C5CE7);
  static const lightNavActive = Color(0xFF6C5CE7);
  static const lightNavInactive = Color(0xFF757575);
  static const lightNavBg = Color(0xFFFFFFFF);
  static const lightNavBorder = Color(0xFFEEEEEE);

  // ── Dark Mode ──
  static const darkPageBg = Color(0xFF1A1A2E);
  static const darkCardBg = Color(0xFF16213E);
  static const darkCardBorder = Color(0xFF2A2A4E);
  static const darkTitle = Color(0xFFEEEEFF);
  static const darkSubtitle = Color(0xFF9999BB);
  static const darkTagActiveBg = Color(0xFF6C5CE7);
  static const darkTagActiveText = Color(0xFFFFFFFF);
  static const darkTagInactiveBg = Color(0xFF2A2A4E);
  static const darkTagInactiveText = Color(0xFFA78BFA);
  static const darkNavActive = Color(0xFFA78BFA);
  static const darkNavInactive = Color(0xFF8888AA);
  static const darkNavBg = Color(0xFF16213E);
  static const darkNavBorder = Color(0xFF2A2A4E);

  // ── Typography Scale ──
  static TextStyle displayLarge(Brightness b) =>
      TextStyle(fontSize: 36, fontWeight: FontWeight.w700, color: title(b));
  static TextStyle displayMedium(Brightness b) =>
      TextStyle(fontSize: 26, fontWeight: FontWeight.w600, color: title(b));
  static TextStyle headlineLarge(Brightness b) =>
      TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: title(b));
  static TextStyle headlineMedium(Brightness b) =>
      TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: title(b));
  static TextStyle titleLarge(Brightness b) =>
      TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: title(b));
  static TextStyle titleMedium(Brightness b) =>
      TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: title(b));
  static TextStyle bodyLarge(Brightness b) =>
      TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: title(b));
  static TextStyle bodyMedium(Brightness b) =>
      TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: title(b));
  static TextStyle bodySmall(Brightness b) =>
      TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: subtitle(b));
  static TextStyle labelLarge(Brightness b) =>
      TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: title(b));
  static TextStyle labelMedium(Brightness b) =>
      TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: title(b));
  static TextStyle labelSmall(Brightness b) =>
      TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: subtitle(b));

  // ── Shadow / Elevation Token ──
  static List<BoxShadow> shadowNone(Brightness b) => const [];
  static List<BoxShadow> shadowSm(Brightness b) => b == Brightness.dark
      ? const []
      : const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 4,
            offset: Offset(0, 1),
          ),
        ];
  static List<BoxShadow> shadowMd(Brightness b) => b == Brightness.dark
      ? const []
      : const [
          BoxShadow(
            color: Color(0x1F000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ];
  static List<BoxShadow> shadowLg(Brightness b) => b == Brightness.dark
      ? const []
      : const [
          BoxShadow(
            color: Color(0x29000000),
            blurRadius: 16,
            offset: Offset(0, 4),
          ),
        ];

  // ── Semantic Color Token ──
  static const lightSuccess = Color(0xFF0D8F63);
  static const lightError = Color(0xFFEF4444);
  static const lightWarning = Color(0xFFF59E0B);
  static const lightInfo = Color(0xFF3B82F6);

  static const darkSuccess = Color(0xFF34D399);
  static const darkError = Color(0xFFF87171);
  static const darkWarning = Color(0xFFFBBF24);
  static const darkInfo = Color(0xFF60A5FA);

  static Color success(Brightness b) =>
      b == Brightness.dark ? darkSuccess : lightSuccess;
  static Color error(Brightness b) =>
      b == Brightness.dark ? darkError : lightError;
  static Color warning(Brightness b) =>
      b == Brightness.dark ? darkWarning : lightWarning;
  static Color info(Brightness b) =>
      b == Brightness.dark ? darkInfo : lightInfo;

  // ── Animation Curve Token ──
  static const curveStandard = Curves.easeInOut;
  static const curveDecelerate = Curves.easeOut;
  static const curveAccelerate = Curves.easeIn;
  static const curveSpring = Curves.elasticOut;

  // ── Iconography 尺寸標準化 ──
  static const iconXs = 16.0;
  static const iconSm = 20.0;
  static const iconMd = 24.0;
  static const iconLg = 32.0;
  static const iconXl = 48.0;

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
  'date_calculator': [Color(0xFF5C6BC0), Color(0xFF7986CB)],
  'qr_scanner_live': [Color(0xFF00BCD4), Color(0xFF4DD0E1)],
  'currency_converter': [Color(0xFF26A69A), Color(0xFF4DB6AC)],
  'word_counter': [Color(0xFF3B82F6), Color(0xFF60A5FA)],
  'pomodoro': [Color(0xFFE74C3C), Color(0xFFEF5350)],
  'quick_notes': [Color(0xFFF59E0B), Color(0xFFFBBF24)],
};
