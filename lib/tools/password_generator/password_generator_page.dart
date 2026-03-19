import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_first_app/widgets/immersive_tool_scaffold.dart';

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

  static const _uppercaseChars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  static const _lowercaseChars = 'abcdefghijklmnopqrstuvwxyz';
  static const _numberChars = '0123456789';
  static const _specialChars = '!@#\$%^&*()_+-=[]{}|;:,.<>?';

  @override
  void initState() {
    super.initState();
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

  void _generatePassword() {
    final pool = _buildCharPool();
    if (pool.isEmpty) return;
    final random = Random.secure();
    final len = _length.round();
    final password = List.generate(len, (_) => pool[random.nextInt(pool.length)])
        .join();
    setState(() => _password = password);
  }

  int get _activeTypeCount =>
      [_uppercase, _lowercase, _numbers, _special].where((v) => v).length;

  PasswordStrength get _strength {
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
        const SnackBar(content: Text('至少需選擇一種字元類型')),
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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('已複製到剪貼簿')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ImmersiveToolScaffold(
      toolColor: const Color(0xFF3F51B5),
      title: '密碼產生器',
      heroTag: 'tool_hero_password_generator',
      headerFlex: 2,
      bodyFlex: 3,
      headerChild: _buildPasswordDisplay(context),
      bodyChild: _buildOptionsArea(context),
    );
  }

  /// 密碼顯示區（上方漸層 header）
  Widget _buildPasswordDisplay(BuildContext context) {
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
                    tooltip: '複製',
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
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Length slider
          Text('密碼長度：${_length.round()}'),
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
          const SizedBox(height: 16),

          // Character type toggles
          SwitchListTile(
            title: const Text('大寫字母 (A-Z)'),
            value: _uppercase,
            onChanged: (_) => _toggleType(_uppercase, (v) => _uppercase = v),
          ),
          SwitchListTile(
            title: const Text('小寫字母 (a-z)'),
            value: _lowercase,
            onChanged: (_) => _toggleType(_lowercase, (v) => _lowercase = v),
          ),
          SwitchListTile(
            title: const Text('數字 (0-9)'),
            value: _numbers,
            onChanged: (_) => _toggleType(_numbers, (v) => _numbers = v),
          ),
          SwitchListTile(
            title: const Text('特殊字元 (!@#\$...)'),
            value: _special,
            onChanged: (_) => _toggleType(_special, (v) => _special = v),
          ),
          const SizedBox(height: 24),

          // Generate button
          FilledButton.icon(
            onPressed: _generatePassword,
            icon: const Icon(Icons.refresh),
            label: const Text('產生新密碼'),
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

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              '密碼強度',
              style: TextStyle(color: Colors.white),
            ),
            Text(
              strength.label,
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
