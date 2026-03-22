import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:my_first_app/services/analytics_service.dart';

/// 分享按鈕，放在 ImmersiveToolScaffold 的 actions 區域。
///
/// 未產生結果前顯示為 disabled（半透明、不可點擊）。
class ShareButton extends StatelessWidget {
  const ShareButton({
    super.key,
    required this.toolId,
    this.enabled = false,
    this.shareText,
    this.shareFiles,
  });

  /// 工具 ID，用於 analytics 追蹤。
  final String toolId;

  /// 是否啟用（產生結果後設為 true）。
  final bool enabled;

  /// 分享的文字內容。
  final String? shareText;

  /// 分享的檔案路徑列表（如 QR Code 圖片）。
  final List<XFile>? shareFiles;

  Future<void> _share() async {
    AnalyticsService.instance.logToolShare(
      toolId: toolId,
      shareMethod: 'system_share',
    );

    if (shareFiles != null && shareFiles!.isNotEmpty) {
      await Share.shareXFiles(
        shareFiles!,
        text: shareText,
      );
    } else if (shareText != null) {
      await Share.share(shareText!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: enabled ? 1.0 : 0.4,
      child: IconButton(
        onPressed: enabled ? _share : null,
        icon: const Icon(Icons.share),
        tooltip: '分享',
      ),
    );
  }
}
