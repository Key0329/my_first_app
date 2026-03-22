import 'package:flutter/material.dart';

/// 共用確認對話框，用於破壞性操作（清除、刪除、重設等）。
///
/// 確認按鈕使用 `colorScheme.error` 色彩，表示破壞性操作。
/// 使用 `showAdaptiveDialog` + `AlertDialog.adaptive` 確保平台適配。
Future<bool> showConfirmDialog({
  required BuildContext context,
  required String title,
  required String message,
  String confirmLabel = '確認',
  String cancelLabel = '取消',
}) async {
  final result = await showAdaptiveDialog<bool>(
    context: context,
    builder: (ctx) {
      final colorScheme = Theme.of(ctx).colorScheme;
      return AlertDialog.adaptive(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(cancelLabel),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style: TextButton.styleFrom(
              foregroundColor: colorScheme.error,
            ),
            child: Text(confirmLabel),
          ),
        ],
      );
    },
  );
  return result ?? false;
}
