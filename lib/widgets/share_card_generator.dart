import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

/// 分享卡片圖片生成工具。
///
/// 使用 [RepaintBoundary] 截取 Widget 為 PNG 圖片，
/// 儲存至暫存目錄並回傳 [XFile]。
class ShareCardGenerator {
  ShareCardGenerator._();

  /// 截取 [RepaintBoundary] 並儲存為 PNG 檔案。
  ///
  /// [boundaryKey] 必須綁定到一個 [RepaintBoundary] widget。
  /// [pixelRatio] 控制解析度（預設 3.0 適合社群分享）。
  static Future<XFile?> capture(
    GlobalKey boundaryKey, {
    double pixelRatio = 3.0,
  }) async {
    try {
      final boundary = boundaryKey.currentContext?.findRenderObject()
          as RenderRepaintBoundary?;
      if (boundary == null) return null;

      final image = await boundary.toImage(pixelRatio: pixelRatio);
      final byteData = await image.toByteData(
        format: ui.ImageByteFormat.png,
      );
      if (byteData == null) return null;

      final bytes = byteData.buffer.asUint8List();
      final dir = await getTemporaryDirectory();
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final file = File('${dir.path}/spectra_share_$timestamp.png');
      await file.writeAsBytes(bytes);

      return XFile(file.path);
    } catch (e) {
      debugPrint('分享卡片生成失敗: $e');
      return null;
    }
  }
}
