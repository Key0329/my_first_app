import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

/// Returns `true` on Android and iOS (non-web). These are the only platforms
/// that support hardware sensors (accelerometer, magnetometer, camera, etc.).
bool isMobilePlatform() {
  if (kIsWeb) return false;
  return Platform.isAndroid || Platform.isIOS;
}

/// Fallback UI shown when a tool requires hardware not available on the
/// current platform (Web, macOS, Linux, Windows).
class PlatformUnsupportedView extends StatelessWidget {
  const PlatformUnsupportedView({
    super.key,
    this.toolName = '',
  });

  final String toolName;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(toolName),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.devices_other,
                size: 64,
                color: theme.colorScheme.outline,
              ),
              const SizedBox(height: 16),
              Text(
                '此功能需要行動裝置',
                style: theme.textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                '此工具需要手機的硬體感測器，\n目前的平台不支援。',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: theme.colorScheme.outline,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
