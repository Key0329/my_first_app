import 'package:flutter/material.dart';
import 'package:my_first_app/services/settings_service.dart';

class SettingsPage extends StatelessWidget {
  final AppSettings settings;

  const SettingsPage({super.key, required this.settings});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(height: 8),
        _buildSectionTitle(context, '外觀'),
        _buildThemeModeTile(context),
        const Divider(),
        _buildSectionTitle(context, '語言'),
        _buildLanguageTile(context),
        const Divider(),
        _buildSectionTitle(context, '關於'),
        ListTile(
          leading: const Icon(Icons.info_outline),
          title: const Text('版本'),
          subtitle: const Text('1.0.0'),
        ),
        ListTile(
          leading: const Icon(Icons.privacy_tip_outlined),
          title: const Text('隱私政策'),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.description_outlined),
          title: const Text('使用條款'),
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
      ),
    );
  }

  Widget _buildThemeModeTile(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.brightness_6),
      title: const Text('主題模式'),
      subtitle: Text(_themeModeLabel(settings.themeMode)),
      onTap: () => _showThemeModeDialog(context),
    );
  }

  Widget _buildLanguageTile(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.language),
      title: const Text('語言'),
      subtitle: Text(
        settings.locale.languageCode == 'zh' ? '繁體中文' : 'English',
      ),
      onTap: () => _showLanguageDialog(context),
    );
  }

  String _themeModeLabel(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return '亮色';
      case ThemeMode.dark:
        return '暗色';
      case ThemeMode.system:
        return '跟隨系統';
    }
  }

  void _showThemeModeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('選擇主題模式'),
        children: ThemeMode.values.map((mode) {
          return ListTile(
            title: Text(_themeModeLabel(mode)),
            leading: Icon(
              settings.themeMode == mode
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
            ),
            onTap: () {
              settings.setThemeMode(mode);
              Navigator.of(context).pop();
            },
          );
        }).toList(),
      ),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('選擇語言'),
        children: [
          ListTile(
            title: const Text('繁體中文'),
            leading: Icon(
              settings.locale.languageCode == 'zh'
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
            ),
            onTap: () {
              settings.setLocale(const Locale('zh', 'TW'));
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            title: const Text('English'),
            leading: Icon(
              settings.locale.languageCode == 'en'
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
            ),
            onTap: () {
              settings.setLocale(const Locale('en'));
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
