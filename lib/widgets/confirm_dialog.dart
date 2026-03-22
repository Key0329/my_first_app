import 'package:flutter/material.dart';
import 'package:my_first_app/l10n/app_localizations.dart';

/// 共用確認對話框，用於破壞性操作（清除、刪除、重設等）。
///
/// 確認按鈕使用 `colorScheme.error` 色彩，表示破壞性操作。
/// 使用 `showAdaptiveDialog` + `AlertDialog.adaptive` 確保平台適配。
Future<bool> showConfirmDialog({
  required BuildContext context,
  required String title,
  required String message,
  String? confirmLabel,
  String? cancelLabel,
}) async {
  final l10n = AppLocalizations.of(context)!;
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
            child: Text(cancelLabel ?? l10n.commonCancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style: TextButton.styleFrom(
              foregroundColor: colorScheme.error,
            ),
            child: Text(confirmLabel ?? l10n.commonConfirm),
          ),
        ],
      );
    },
  );
  return result ?? false;
}
