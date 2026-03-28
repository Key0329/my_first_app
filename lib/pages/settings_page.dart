import 'package:flutter/material.dart';
import 'package:my_first_app/l10n/app_localizations.dart';
import 'package:my_first_app/pages/paywall_screen.dart';
import 'package:my_first_app/services/in_app_purchase_service.dart';
import 'package:my_first_app/services/pro_service.dart';
import 'package:my_first_app/services/settings_service.dart';
import 'package:my_first_app/services/theme_service.dart';
import 'package:my_first_app/theme/design_tokens.dart';
import 'package:my_first_app/widgets/staggered_fade_in.dart';
import 'package:my_first_app/widgets/tool_section_card.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  final AppSettings settings;

  const SettingsPage({super.key, required this.settings});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _hasAnimated = false;

  @override
  Widget build(BuildContext context) {
    final shouldAnimate = !_hasAnimated;
    if (!_hasAnimated) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) setState(() => _hasAnimated = true);
      });
    }

    final l10n = AppLocalizations.of(context)!;

    return SafeArea(
      child: ListenableBuilder(
        listenable: widget.settings,
        builder: (context, _) {
          final isPro = context.watch<ProService>().isPro;
          return ListView(
            padding: const EdgeInsets.all(DT.spaceLg),
            children: [
              // ── Pro 升級卡片 ──
              StaggeredFadeIn(
                index: 0,
                totalItems: 4,
                animate: shouldAnimate,
                child: _buildProCard(context, isPro),
              ),
              const SizedBox(height: DT.spaceMd),

              // ── 外觀區塊 ──
              StaggeredFadeIn(
                index: 1,
                totalItems: 5,
                animate: shouldAnimate,
                child: ToolSectionCard(
                  label: l10n.settingsAppearance,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildThemeModeSelector(),
                      const SizedBox(height: DT.spaceLg),
                      _buildLanguageSelector(),
                      const SizedBox(height: DT.spaceLg),
                      _buildAccentColorSelector(),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: DT.spaceMd),

              // ── 資料區塊 ──
              StaggeredFadeIn(
                index: 2,
                totalItems: 5,
                animate: shouldAnimate,
                child: ToolSectionCard(
                  label: l10n.settingsData,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildClearFavoritesButton(),
                      const SizedBox(height: DT.spaceSm),
                      _buildClearRecentToolsButton(),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: DT.spaceMd),

              // ── 進階功能區塊（Widget Pro gating in settings）──
              StaggeredFadeIn(
                index: 3,
                totalItems: 5,
                animate: shouldAnimate,
                child: ToolSectionCard(
                  label: '進階功能',
                  child: _buildWidgetSetupEntry(context, isPro),
                ),
              ),
              const SizedBox(height: DT.spaceMd),

              // ── 關於區塊 ──
              StaggeredFadeIn(
                index: 4,
                totalItems: 5,
                animate: shouldAnimate,
                child: ToolSectionCard(
                  label: l10n.settingsAbout,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoRow(
                        Icons.info_outline,
                        l10n.settingsVersion,
                        '1.0.0',
                      ),
                      const SizedBox(height: DT.spaceSm),
                      _buildTappableRow(
                        Icons.privacy_tip_outlined,
                        l10n.settingsPrivacyPolicy,
                        () {},
                      ),
                      const SizedBox(height: DT.spaceSm),
                      _buildTappableRow(
                        Icons.description_outlined,
                        l10n.settingsTermsOfService,
                        () {},
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // ── Pro 升級卡片（Pro upgrade card in settings）──
  Widget _buildProCard(BuildContext context, bool isPro) {
    if (isPro) {
      return Container(
        padding: const EdgeInsets.all(DT.spaceLg),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [DT.brandPrimary, DT.brandPrimaryLight],
          ),
          borderRadius: BorderRadius.circular(DT.radiusLg),
        ),
        child: const Row(
          children: [
            Icon(Icons.workspace_premium, color: Colors.white, size: 24),
            SizedBox(width: DT.spaceMd),
            Text(
              '已是 Pro 用戶 ✓',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      );
    }

    return GestureDetector(
      onTap: () => _openPaywall(context),
      child: Container(
        padding: const EdgeInsets.all(DT.spaceLg),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [DT.brandPrimary, DT.brandPrimaryLight],
          ),
          borderRadius: BorderRadius.circular(DT.radiusLg),
        ),
        child: Row(
          children: [
            const Icon(Icons.workspace_premium, color: Colors.white, size: 24),
            const SizedBox(width: DT.spaceMd),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '升級至 Pro',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    '去廣告 · 自訂主題 · Widget',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: DT.spaceMd,
                vertical: DT.spaceSm,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(DT.radiusSm),
              ),
              child: const Text(
                'NT\$90',
                style: TextStyle(
                  color: DT.brandPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── 主題模式 SegmentedButton ──
  Widget _buildThemeModeSelector() {
    final b = Theme.of(context).brightness;
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.settingsThemeMode, style: DT.labelLarge(b)),
        const SizedBox(height: DT.spaceSm),
        SizedBox(
          width: double.infinity,
          child: SegmentedButton<ThemeMode>(
            segments: [
              ButtonSegment(
                value: ThemeMode.light,
                label: Text(l10n.settingsThemeLight),
              ),
              ButtonSegment(
                value: ThemeMode.system,
                label: Text(l10n.settingsThemeSystem),
              ),
              ButtonSegment(
                value: ThemeMode.dark,
                label: Text(l10n.settingsThemeDark),
              ),
            ],
            selected: {widget.settings.themeMode},
            onSelectionChanged: (selection) {
              widget.settings.setThemeMode(selection.first);
            },
          ),
        ),
      ],
    );
  }

  // ── 語言 SegmentedButton ──
  Widget _buildLanguageSelector() {
    final b = Theme.of(context).brightness;
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.settingsLanguage, style: DT.labelLarge(b)),
        const SizedBox(height: DT.spaceSm),
        SizedBox(
          width: double.infinity,
          child: SegmentedButton<String>(
            segments: [
              ButtonSegment(value: 'zh', label: Text(l10n.settingsLanguageZh)),
              ButtonSegment(value: 'en', label: Text('English')),
            ],
            selected: {widget.settings.locale.languageCode},
            onSelectionChanged: (selection) {
              final locale = selection.first == 'zh'
                  ? const Locale('zh', 'TW')
                  : const Locale('en');
              widget.settings.setLocale(locale);
            },
          ),
        ),
      ],
    );
  }

  // ── 品牌色選擇（Accent color selection — 軟鎖定）──
  Widget _buildAccentColorSelector() {
    final b = Theme.of(context).brightness;
    final l10n = AppLocalizations.of(context)!;
    final current = widget.settings.themeService.accentColor;
    final isPro = context.watch<ProService>().isPro;

    String colorName(AccentColorOption opt) {
      switch (opt) {
        case AccentColorOption.purple:
          return l10n.accentColorPurple;
        case AccentColorOption.blue:
          return l10n.accentColorBlue;
        case AccentColorOption.green:
          return l10n.accentColorGreen;
        case AccentColorOption.red:
          return l10n.accentColorRed;
        case AccentColorOption.orange:
          return l10n.accentColorOrange;
        case AccentColorOption.pink:
          return l10n.accentColorPink;
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(l10n.settingsAccentColor, style: DT.labelLarge(b)),
            if (!isPro) ...[
              const SizedBox(width: DT.spaceSm),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: DT.spaceSm,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: DT.brandPrimaryBgLight,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'Pro',
                  style: TextStyle(
                    fontSize: 10,
                    color: DT.brandPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: DT.spaceSm),
        Wrap(
          spacing: DT.spaceMd,
          runSpacing: DT.spaceSm,
          children: AccentColorOption.values.map((opt) {
            final isSelected = opt == current;
            // 免費用戶：僅預設紫色可用，其餘加鎖
            final isLocked = !isPro && opt != AccentColorOption.purple;

            return Tooltip(
              message: isLocked ? '${ colorName(opt)} — Pro 專屬' : colorName(opt),
              child: GestureDetector(
                onTap: isLocked
                    ? () => _openPaywall(context)
                    : () => widget.settings.themeService.setAccentColor(opt),
                child: Stack(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: opt.color.withValues(alpha: isLocked ? 0.4 : 1.0),
                        shape: BoxShape.circle,
                        border: isSelected
                            ? Border.all(
                                color: b == Brightness.dark
                                    ? Colors.white
                                    : Colors.black87,
                                width: 2.5,
                              )
                            : null,
                      ),
                      child: isSelected && !isLocked
                          ? const Icon(Icons.check, color: Colors.white, size: 18)
                          : null,
                    ),
                    if (isLocked)
                      const Positioned(
                        right: 0,
                        bottom: 0,
                        child: Icon(Icons.lock, size: 14, color: Colors.white70),
                      ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  // ── Widget 設定入口（Widget Pro gating in settings）──
  Widget _buildWidgetSetupEntry(BuildContext context, bool isPro) {
    final b = Theme.of(context).brightness;
    return InkWell(
      onTap: isPro ? null : () => _openPaywall(context),
      borderRadius: BorderRadius.circular(DT.radiusSm),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: DT.spaceSm,
          horizontal: DT.spaceXs,
        ),
        child: Row(
          children: [
            Icon(Icons.widgets_outlined, size: 20, color: DT.subtitle(b)),
            const SizedBox(width: DT.spaceMd),
            Expanded(
              child: Text('主螢幕 Widget', style: DT.bodyMedium(b)),
            ),
            if (!isPro)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: DT.spaceSm,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: DT.brandPrimaryBgLight,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'Pro',
                  style: TextStyle(
                    fontSize: 10,
                    color: DT.brandPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            else
              Icon(Icons.chevron_right, size: 20, color: DT.subtitle(b)),
          ],
        ),
      ),
    );
  }

  void _openPaywall(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => MultiProvider(
        providers: [
          ChangeNotifierProvider<ProService>.value(
            value: context.read<ProService>(),
          ),
          Provider<InAppPurchaseService>.value(
            value: context.read<InAppPurchaseService>(),
          ),
        ],
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(DT.radiusLg),
            ),
          ),
          child: const PaywallScreen(),
        ),
      ),
    );
  }

  // ── 清除收藏按鈕 ──
  Widget _buildClearFavoritesButton() {
    final l10n = AppLocalizations.of(context)!;
    return _buildActionButton(
      icon: Icons.favorite_border,
      label: l10n.settingsClearFavorites,
      onTap: () => _showClearDialog(
        title: l10n.settingsClearFavoritesTitle,
        message: l10n.settingsClearFavoritesMessage,
        onConfirm: () {
          for (final toolId in widget.settings.favorites.toList()) {
            widget.settings.toggleFavorite(toolId);
          }
        },
      ),
    );
  }

  // ── 清除最近使用按鈕 ──
  Widget _buildClearRecentToolsButton() {
    final l10n = AppLocalizations.of(context)!;
    return _buildActionButton(
      icon: Icons.history,
      label: l10n.settingsClearRecent,
      onTap: () => _showClearDialog(
        title: l10n.settingsClearRecentTitle,
        message: l10n.settingsClearRecentMessage,
        onConfirm: () {
          widget.settings.clearRecentTools();
        },
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    final b = Theme.of(context).brightness;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(DT.radiusSm),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: DT.spaceSm,
          horizontal: DT.spaceXs,
        ),
        child: Row(
          children: [
            Icon(icon, size: 20, color: DT.subtitle(b)),
            const SizedBox(width: DT.spaceMd),
            Text(label, style: DT.bodyMedium(b)),
          ],
        ),
      ),
    );
  }

  // ── 資訊列 ──
  Widget _buildInfoRow(IconData icon, String label, String value) {
    final b = Theme.of(context).brightness;
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: DT.spaceXs,
        horizontal: DT.spaceXs,
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: DT.subtitle(b)),
          const SizedBox(width: DT.spaceMd),
          Text(label, style: DT.bodyMedium(b)),
          const Spacer(),
          Text(value, style: DT.bodyMedium(b).copyWith(color: DT.subtitle(b))),
        ],
      ),
    );
  }

  // ── 可點擊列 ──
  Widget _buildTappableRow(IconData icon, String label, VoidCallback onTap) {
    final b = Theme.of(context).brightness;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(DT.radiusSm),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: DT.spaceSm,
          horizontal: DT.spaceXs,
        ),
        child: Row(
          children: [
            Icon(icon, size: 20, color: DT.subtitle(b)),
            const SizedBox(width: DT.spaceMd),
            Text(label, style: DT.bodyMedium(b)),
            const Spacer(),
            Icon(Icons.chevron_right, size: 20, color: DT.subtitle(b)),
          ],
        ),
      ),
    );
  }

  // ── 確認清除對話框 ──
  void _showClearDialog({
    required String title,
    required String message,
    required VoidCallback onConfirm,
  }) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.commonCancel),
          ),
          TextButton(
            onPressed: () {
              onConfirm();
              Navigator.of(context).pop();
            },
            child: Text(l10n.commonConfirm),
          ),
        ],
      ),
    );
  }
}
