import 'package:flutter/material.dart';
import 'package:my_first_app/l10n/app_localizations.dart';
import 'package:my_first_app/services/settings_service.dart';
import 'package:my_first_app/theme/design_tokens.dart';
import 'package:my_first_app/widgets/staggered_fade_in.dart';
import 'package:my_first_app/widgets/tool_section_card.dart';

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
          return ListView(
            padding: const EdgeInsets.all(DT.spaceLg),
            children: [
              // ── 外觀區塊 ──
              StaggeredFadeIn(
                index: 0,
                totalItems: 3,
                animate: shouldAnimate,
                child: ToolSectionCard(
                  label: l10n.settingsAppearance,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildThemeModeSelector(),
                      const SizedBox(height: DT.spaceLg),
                      _buildLanguageSelector(),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: DT.spaceMd),

              // ── 資料區塊 ──
              StaggeredFadeIn(
                index: 1,
                totalItems: 3,
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

              // ── 關於區塊 ──
              StaggeredFadeIn(
                index: 2,
                totalItems: 3,
                animate: shouldAnimate,
                child: ToolSectionCard(
                  label: l10n.settingsAbout,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoRow(Icons.info_outline, l10n.settingsVersion, '1.0.0'),
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

  // ── 主題模式 SegmentedButton ──
  Widget _buildThemeModeSelector() {
    final b = Theme.of(context).brightness;
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.settingsThemeMode,
          style: TextStyle(
            fontSize: DT.fontToolLabel,
            fontWeight: FontWeight.w500,
            color: DT.title(b),
          ),
        ),
        const SizedBox(height: DT.spaceSm),
        SizedBox(
          width: double.infinity,
          child: SegmentedButton<ThemeMode>(
            segments: [
              ButtonSegment(value: ThemeMode.light, label: Text(l10n.settingsThemeLight)),
              ButtonSegment(value: ThemeMode.system, label: Text(l10n.settingsThemeSystem)),
              ButtonSegment(value: ThemeMode.dark, label: Text(l10n.settingsThemeDark)),
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
        Text(
          l10n.settingsLanguage,
          style: TextStyle(
            fontSize: DT.fontToolLabel,
            fontWeight: FontWeight.w500,
            color: DT.title(b),
          ),
        ),
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
            Text(
              label,
              style: TextStyle(
                fontSize: DT.fontToolLabel,
                color: DT.title(b),
              ),
            ),
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
          Text(
            label,
            style: TextStyle(
              fontSize: DT.fontToolLabel,
              color: DT.title(b),
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              fontSize: DT.fontToolLabel,
              color: DT.subtitle(b),
            ),
          ),
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
            Text(
              label,
              style: TextStyle(
                fontSize: DT.fontToolLabel,
                color: DT.title(b),
              ),
            ),
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
