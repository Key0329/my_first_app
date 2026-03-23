import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_first_app/l10n/app_localizations.dart';
import 'package:my_first_app/theme/design_tokens.dart';
import 'package:my_first_app/widgets/immersive_tool_scaffold.dart';
import 'package:my_first_app/widgets/staggered_fade_in.dart';
import 'package:my_first_app/widgets/tool_gradient_button.dart';
import 'package:my_first_app/widgets/tool_section_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

final Color _toolColor =
    toolGradients['password_generator']?.first ?? const Color(0xFF3F51B5);

class PasswordGeneratorPage extends StatefulWidget {
  const PasswordGeneratorPage({super.key});

  @override
  State<PasswordGeneratorPage> createState() => PasswordGeneratorPageState();
}

@visibleForTesting
class PasswordGeneratorPageState extends State<PasswordGeneratorPage> {
  double _length = 16;
  bool _uppercase = true;
  bool _lowercase = true;
  bool _numbers = true;
  bool _special = false;
  String _password = '';
  bool _isMemorableMode = false;
  int _wordCount = 4;

  // Password history state
  final List<String> _passwordHistory = [];
  final Set<int> _revealedIndices = {};
  static const _historyKey = 'password_history';
  static const _maxHistory = 20;

  static const _uppercaseChars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  static const _lowercaseChars = 'abcdefghijklmnopqrstuvwxyz';
  static const _numberChars = '0123456789';
  static const _specialChars = '!@#\$%^&*()_+-=[]{}|;:,.<>?';

  static const _words = [
    'apple',
    'beach',
    'cloud',
    'dance',
    'eagle',
    'flame',
    'grape',
    'honey',
    'ivory',
    'jewel',
    'karma',
    'lemon',
    'mango',
    'noble',
    'ocean',
    'pearl',
    'quest',
    'river',
    'storm',
    'tiger',
    'ultra',
    'vivid',
    'whale',
    'xenon',
    'youth',
    'zebra',
    'amber',
    'bloom',
    'coral',
    'dream',
    'ember',
    'frost',
    'glow',
    'haven',
    'inlet',
    'lunar',
    'maple',
    'north',
    'oasis',
    'plume',
    'quilt',
    'ridge',
    'solar',
    'trail',
    'unity',
    'vapor',
    'winds',
    'axis',
    'blaze',
    'crest',
    'delta',
    'epoch',
    'flora',
    'grain',
    'haste',
    'irony',
    'joint',
    'knelt',
    'light',
    'march',
    'nerve',
    'orbit',
    'pilot',
    'razor',
    'scale',
    'thorn',
    'urban',
    'vault',
    'wrist',
    'yield',
    'acorn',
    'brave',
    'charm',
    'drift',
    'elect',
    'forge',
    'glide',
    'hound',
    'image',
    'judge',
    'knack',
    'lance',
    'minor',
    'novel',
    'oxide',
    'plaza',
    'reign',
    'slate',
    'tempo',
    'usher',
    'vigor',
    'worth',
    'atlas',
    'brine',
    'cliff',
    'dune',
    'elfin',
    'fable',
    'guild',
    'hazel',
  ];

  @override
  void initState() {
    super.initState();
    _loadHistory();
    _generatePassword();
  }

  String _buildCharPool() {
    final pool = StringBuffer();
    if (_uppercase) pool.write(_uppercaseChars);
    if (_lowercase) pool.write(_lowercaseChars);
    if (_numbers) pool.write(_numberChars);
    if (_special) pool.write(_specialChars);
    return pool.toString();
  }

  String _generateMemorablePassword() {
    final random = Random.secure();
    return List.generate(
      _wordCount,
      (_) => _words[random.nextInt(_words.length)],
    ).join('-');
  }

  void _generatePassword() {
    if (_isMemorableMode) {
      final password = _generateMemorablePassword();
      setState(() => _password = password);
    } else {
      final pool = _buildCharPool();
      if (pool.isEmpty) return;
      final random = Random.secure();
      final len = _length.round();
      final password = List.generate(
        len,
        (_) => pool[random.nextInt(pool.length)],
      ).join();
      setState(() => _password = password);
    }
    _addToHistory(_password);
  }

  void _addToHistory(String password) {
    if (password.isEmpty) return;
    setState(() {
      _passwordHistory.insert(0, password);
      if (_passwordHistory.length > _maxHistory) {
        _passwordHistory.removeRange(_maxHistory, _passwordHistory.length);
      }
      // Reset revealed indices since list shifted
      _revealedIndices.clear();
    });
    _saveHistory();
  }

  Future<void> _loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final historyJson = prefs.getString(_historyKey);
    if (historyJson != null) {
      final List<dynamic> decoded = json.decode(historyJson) as List<dynamic>;
      setState(() {
        _passwordHistory.clear();
        _passwordHistory.addAll(decoded.cast<String>());
      });
    }
  }

  Future<void> _saveHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_historyKey, json.encode(_passwordHistory));
  }

  void _clearHistory() {
    setState(() {
      _passwordHistory.clear();
      _revealedIndices.clear();
    });
    _saveHistory();
  }

  int get _activeTypeCount =>
      [_uppercase, _lowercase, _numbers, _special].where((v) => v).length;

  PasswordStrength get _strength {
    if (_isMemorableMode) {
      if (_wordCount >= 6) return PasswordStrength.veryStrong;
      if (_wordCount >= 5) return PasswordStrength.strong;
      if (_wordCount >= 4) return PasswordStrength.medium;
      return PasswordStrength.weak;
    }
    final len = _length.round();
    final types = _activeTypeCount;
    if (len >= 20 && types >= 3) return PasswordStrength.veryStrong;
    if (len >= 14 && types >= 2) return PasswordStrength.strong;
    if (len >= 10 && types >= 2) return PasswordStrength.medium;
    return PasswordStrength.weak;
  }

  bool _canToggleOff(bool value) {
    if (!value) return true; // turning on is always ok
    return _activeTypeCount > 1;
  }

  void _toggleType(bool current, void Function(bool) setter) {
    if (current && !_canToggleOff(current)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.passwordMinOneType),
        ),
      );
      return;
    }
    setState(() => setter(!current));
    _generatePassword();
  }

  Future<void> _copyToClipboard() async {
    if (_password.isEmpty) return;
    await Clipboard.setData(ClipboardData(text: _password));
    if (mounted) {
      final l10n = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.copiedToClipboard)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ImmersiveToolScaffold(
      toolId: 'password_generator',
      toolColor: _toolColor,
      title: AppLocalizations.of(context)!.toolPasswordGenerator,
      heroTag: 'tool_hero_password_generator',
      headerFlex: 2,
      bodyFlex: 3,
      headerChild: _buildPasswordDisplay(context),
      bodyChild: _buildOptionsArea(context),
    );
  }

  /// 密碼顯示區（上方漸層 header）
  Widget _buildPasswordDisplay(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final strength = _strength;

    return SafeArea(
      top: true,
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Password text
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: SelectableText(
                      _password,
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 16,
                        letterSpacing: 1.2,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.copy, color: Colors.white),
                    tooltip: l10n.commonCopy,
                    onPressed: _copyToClipboard,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            // Strength indicator
            _StrengthBar(strength: strength),
          ],
        ),
      ),
    );
  }

  /// 選項控制區（下方操作區）
  Widget _buildOptionsArea(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    const totalSections = 5; // 易記模式、密碼長度/單詞數、字元類型、按鈕、歷史

    return SingleChildScrollView(
      padding: const EdgeInsets.all(DT.toolBodyPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 易記模式切換
          StaggeredFadeIn(
            index: 0,
            totalItems: totalSections,
            child: ToolSectionCard(
              child: SwitchListTile(
                title: Text(l10n.passwordMemorable),
                value: _isMemorableMode,
                contentPadding: EdgeInsets.zero,
                onChanged: (v) {
                  setState(() => _isMemorableMode = v);
                  _generatePassword();
                },
              ),
            ),
          ),

          const SizedBox(height: DT.toolSectionGap),

          if (_isMemorableMode) ...[
            // 單詞數量滑桿卡片
            StaggeredFadeIn(
              index: 1,
              totalItems: totalSections,
              child: ToolSectionCard(
                label: l10n.passwordWordCount,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '$_wordCount',
                          style: const TextStyle(
                            fontSize: DT.fontToolLabel,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '3 - 6',
                          style: TextStyle(
                            fontSize: DT.fontToolLabel,
                            color: Theme.of(context).colorScheme.outline,
                          ),
                        ),
                      ],
                    ),
                    Slider(
                      value: _wordCount.toDouble(),
                      min: 3,
                      max: 6,
                      divisions: 3,
                      label: _wordCount.toString(),
                      onChanged: (v) {
                        setState(() => _wordCount = v.round());
                        _generatePassword();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ] else ...[
            // 密碼長度滑桿卡片
            StaggeredFadeIn(
              index: 1,
              totalItems: totalSections,
              child: ToolSectionCard(
                label: l10n.passwordLength,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${_length.round()}',
                          style: const TextStyle(
                            fontSize: DT.fontToolLabel,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '8 - 64',
                          style: TextStyle(
                            fontSize: DT.fontToolLabel,
                            color: Theme.of(context).colorScheme.outline,
                          ),
                        ),
                      ],
                    ),
                    Slider(
                      value: _length,
                      min: 8,
                      max: 64,
                      divisions: 56,
                      label: _length.round().toString(),
                      onChanged: (v) {
                        setState(() => _length = v);
                        _generatePassword();
                      },
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: DT.toolSectionGap),

            // 字元類型開關卡片
            StaggeredFadeIn(
              index: 2,
              totalItems: totalSections,
              child: ToolSectionCard(
                label: l10n.passwordCharTypes,
                child: Column(
                  children: [
                    SwitchListTile(
                      title: Text(l10n.passwordUppercase),
                      value: _uppercase,
                      contentPadding: EdgeInsets.zero,
                      onChanged: (_) =>
                          _toggleType(_uppercase, (v) => _uppercase = v),
                    ),
                    SwitchListTile(
                      title: Text(l10n.passwordLowercase),
                      value: _lowercase,
                      contentPadding: EdgeInsets.zero,
                      onChanged: (_) =>
                          _toggleType(_lowercase, (v) => _lowercase = v),
                    ),
                    SwitchListTile(
                      title: Text(l10n.passwordDigits),
                      value: _numbers,
                      contentPadding: EdgeInsets.zero,
                      onChanged: (_) =>
                          _toggleType(_numbers, (v) => _numbers = v),
                    ),
                    SwitchListTile(
                      title: Text(l10n.passwordSpecial),
                      value: _special,
                      contentPadding: EdgeInsets.zero,
                      onChanged: (_) =>
                          _toggleType(_special, (v) => _special = v),
                    ),
                  ],
                ),
              ),
            ),
          ],

          const SizedBox(height: DT.toolSectionGap),

          // 產生新密碼按鈕
          StaggeredFadeIn(
            index: 3,
            totalItems: totalSections,
            child: ToolGradientButton(
              gradientColors: toolGradients['password_generator']!,
              label: l10n.passwordGenerate,
              icon: Icons.refresh,
              onPressed: _generatePassword,
            ),
          ),

          const SizedBox(height: DT.toolSectionGap),

          // 密碼歷史
          if (_passwordHistory.isNotEmpty)
            StaggeredFadeIn(
              index: 4,
              totalItems: totalSections,
              child: ToolSectionCard(
                label: l10n.passwordHistory,
                child: Column(
                  children: [
                    ...List.generate(_passwordHistory.length, (index) {
                      final isRevealed = _revealedIndices.contains(index);
                      final password = _passwordHistory[index];
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          isRevealed
                              ? password
                              : '\u2022' * (password.length.clamp(5, 20)),
                          style: TextStyle(
                            fontFamily: isRevealed ? 'monospace' : null,
                            fontSize: 14,
                            letterSpacing: isRevealed ? 1.0 : 2.0,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(
                                isRevealed
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                size: 20,
                              ),
                              tooltip: isRevealed
                                  ? l10n.passwordHidePassword
                                  : l10n.passwordShowPassword,
                              onPressed: () {
                                setState(() {
                                  if (isRevealed) {
                                    _revealedIndices.remove(index);
                                  } else {
                                    _revealedIndices.add(index);
                                  }
                                });
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.copy, size: 20),
                              tooltip: l10n.commonCopy,
                              onPressed: () async {
                                final messenger = ScaffoldMessenger.of(context);
                                await Clipboard.setData(
                                  ClipboardData(text: password),
                                );
                                if (mounted) {
                                  messenger.showSnackBar(
                                    SnackBar(
                                      content: Text(l10n.copiedToClipboard),
                                    ),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      );
                    }),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton.icon(
                        onPressed: _clearHistory,
                        icon: const Icon(Icons.delete_outline, size: 18),
                        label: Text(l10n.passwordClearHistory),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

enum PasswordStrength {
  weak('弱', Colors.red, 0.25),
  medium('中等', Colors.orange, 0.5),
  strong('強', Colors.lightGreen, 0.75),
  veryStrong('非常強', Colors.green, 1.0);

  const PasswordStrength(this.label, this.color, this.value);
  final String label;
  final Color color;
  final double value;
}

class _StrengthBar extends StatelessWidget {
  const _StrengthBar({required this.strength});
  final PasswordStrength strength;

  String _strengthLabel(AppLocalizations l10n) {
    switch (strength) {
      case PasswordStrength.weak:
        return l10n.passwordStrengthWeak;
      case PasswordStrength.medium:
        return l10n.passwordStrengthMedium;
      case PasswordStrength.strong:
        return l10n.passwordStrengthStrong;
      case PasswordStrength.veryStrong:
        return l10n.passwordStrengthVeryStrong;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              l10n.passwordStrength,
              style: const TextStyle(color: Colors.white),
            ),
            Text(
              _strengthLabel(l10n),
              style: TextStyle(
                color: strength.color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: strength.value,
            color: strength.color,
            backgroundColor: Colors.white.withValues(alpha: 0.3),
            minHeight: 8,
          ),
        ),
      ],
    );
  }
}
