import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_first_app/l10n/app_localizations.dart';
import 'package:my_first_app/theme/design_tokens.dart';
import 'package:my_first_app/utils/platform_check.dart';
import 'package:my_first_app/widgets/bouncing_button.dart';
import 'package:my_first_app/widgets/immersive_tool_scaffold.dart';
import 'package:my_first_app/widgets/staggered_fade_in.dart';
import 'package:my_first_app/widgets/tool_section_card.dart';
import 'package:torch_light/torch_light.dart';

final Color _toolColor =
    toolGradients['flashlight']?.first ?? const Color(0xFFFFC107);

/// 手電筒工具頁面
///
/// 提供開關手電筒與 SOS 模式功能。
class FlashlightPage extends StatefulWidget {
  const FlashlightPage({super.key});

  @override
  State<FlashlightPage> createState() => _FlashlightPageState();
}

class _FlashlightPageState extends State<FlashlightPage> {
  bool _isOn = false;
  bool _isSosActive = false;
  bool _isTorchAvailable = true;
  String? _errorMessage;
  Timer? _sosTimer;
  int _sosStepIndex = 0;

  // SOS pattern: 3 short, 3 long, 3 short
  // Each entry is (on duration ms, off duration ms)
  // Short = 200ms on, 200ms off
  // Long  = 600ms on, 200ms off
  // Gap between letter groups = 400ms extra off (total 600ms off)
  // Gap after full SOS cycle = 1400ms off (word gap)
  static const List<_SosStep> _sosPattern = [
    // S: 3 short
    _SosStep(onMs: 200, offMs: 200),
    _SosStep(onMs: 200, offMs: 200),
    _SosStep(onMs: 200, offMs: 600), // extra gap after letter
    // O: 3 long
    _SosStep(onMs: 600, offMs: 200),
    _SosStep(onMs: 600, offMs: 200),
    _SosStep(onMs: 600, offMs: 600), // extra gap after letter
    // S: 3 short
    _SosStep(onMs: 200, offMs: 200),
    _SosStep(onMs: 200, offMs: 200),
    _SosStep(onMs: 200, offMs: 1400), // word gap before repeat
  ];

  @override
  void initState() {
    super.initState();
    _checkTorchAvailability();
  }

  Future<void> _checkTorchAvailability() async {
    try {
      final available = await TorchLight.isTorchAvailable();
      if (!mounted) return;
      setState(() {
        _isTorchAvailable = available;
        if (!available) {
          _errorMessage = '此裝置沒有閃光燈';
        }
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isTorchAvailable = false;
        _errorMessage = '無法偵測閃光燈：$e';
      });
    }
  }

  Future<void> _toggleFlashlight() async {
    if (!_isTorchAvailable) return;

    // Stop SOS if active
    if (_isSosActive) {
      _stopSos();
    }

    try {
      if (_isOn) {
        await TorchLight.disableTorch();
      } else {
        await TorchLight.enableTorch();
      }
      if (!mounted) return;
      setState(() {
        _isOn = !_isOn;
        _errorMessage = null;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = '操作失敗：$e';
      });
    }
  }

  void _toggleSos() {
    if (!_isTorchAvailable) return;

    if (_isSosActive) {
      _stopSos();
    } else {
      _startSos();
    }
  }

  void _startSos() {
    setState(() {
      _isSosActive = true;
      _sosStepIndex = 0;
      _errorMessage = null;
    });
    _executeSosStep();
  }

  void _stopSos() {
    _sosTimer?.cancel();
    _sosTimer = null;

    // Turn off torch when stopping SOS
    TorchLight.disableTorch().catchError((_) {});

    if (!mounted) return;
    setState(() {
      _isSosActive = false;
      _isOn = false;
      _sosStepIndex = 0;
    });
  }

  void _executeSosStep() {
    if (!_isSosActive || !mounted) return;

    final step = _sosPattern[_sosStepIndex];

    // Turn on
    TorchLight.enableTorch().then((_) {
      if (!_isSosActive || !mounted) return;
      setState(() => _isOn = true);

      // Schedule turn off after on duration
      _sosTimer = Timer(Duration(milliseconds: step.onMs), () {
        if (!_isSosActive || !mounted) return;

        TorchLight.disableTorch().then((_) {
          if (!_isSosActive || !mounted) return;
          setState(() => _isOn = false);

          // Schedule next step after off duration
          _sosTimer = Timer(Duration(milliseconds: step.offMs), () {
            if (!_isSosActive || !mounted) return;
            _sosStepIndex = (_sosStepIndex + 1) % _sosPattern.length;
            _executeSosStep();
          });
        }).catchError((e) {
          if (mounted) _stopSos();
        });
      });
    }).catchError((e) {
      if (mounted) {
        setState(() {
          _errorMessage = 'SOS 操作失敗：$e';
        });
        _stopSos();
      }
    });
  }

  @override
  void dispose() {
    _sosTimer?.cancel();
    _sosTimer = null;
    // Ensure torch is off when leaving
    TorchLight.disableTorch().catchError((_) {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!isMobilePlatform()) {
      return const PlatformUnsupportedView(toolName: '手電筒');
    }

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return ImmersiveToolScaffold(
      toolId: 'flashlight',
      toolColor: _toolColor,
      title: '手電筒',
      heroTag: 'tool_hero_flashlight',
      headerFlex: 3,
      bodyFlex: 2,
      headerChild: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Main toggle button
              _buildToggleButton(theme, colorScheme),
              const SizedBox(height: 16),
              // Status text
              Text(
                _isSosActive
                    ? l10n.flashlightSosMode
                    : _isOn
                        ? l10n.flashlightOn
                        : l10n.flashlightOff,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: _isOn || _isSosActive
                      ? colorScheme.primary
                      : colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
      bodyChild: Padding(
        padding: const EdgeInsets.all(DT.toolBodyPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StaggeredFadeIn(
              index: 0,
              totalItems: 1,
              child: ToolSectionCard(
                label: 'SOS 模式',
                child: Column(
                  children: [
                    // SOS button
                    BouncingButton(
                      child: _buildSosButtonContent(theme, colorScheme),
                    ),
                    // Error message
                    if (_errorMessage != null) ...[
                      const SizedBox(height: DT.toolSectionGap),
                      Text(
                        _errorMessage!,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colorScheme.error,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleButton(ThemeData theme, ColorScheme colorScheme) {
    final isActive = _isOn || _isSosActive;

    return GestureDetector(
      onTap: _isTorchAvailable && !_isSosActive ? _toggleFlashlight : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 180,
        height: 180,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isActive
              ? Colors.amber.shade300
              : colorScheme.surfaceContainerHighest,
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: Colors.amber.shade200.withValues(alpha: 0.6),
                    blurRadius: 40,
                    spreadRadius: 10,
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 8,
                    spreadRadius: 1,
                  ),
                ],
        ),
        child: Icon(
          isActive ? Icons.flashlight_on : Icons.flashlight_off,
          size: 72,
          color: isActive
              ? Colors.orange.shade900
              : colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }

  Widget _buildSosButtonContent(ThemeData theme, ColorScheme colorScheme) {
    return FilledButton.tonalIcon(
      onPressed: _isTorchAvailable ? _toggleSos : null,
      icon: Icon(
        _isSosActive ? Icons.stop : Icons.sos,
      ),
      label: Text(_isSosActive ? '停止 SOS' : 'SOS 模式'),
      style: FilledButton.styleFrom(
        backgroundColor: _isSosActive
            ? colorScheme.errorContainer
            : null,
        foregroundColor: _isSosActive
            ? colorScheme.onErrorContainer
            : null,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      ),
    );
  }
}

/// A single step in the SOS blink pattern.
class _SosStep {
  final int onMs;
  final int offMs;

  const _SosStep({required this.onMs, required this.offMs});
}
