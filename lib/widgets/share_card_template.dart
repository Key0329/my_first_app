import 'package:flutter/material.dart';

/// 品牌化分享卡片樣板。
///
/// 渲染一張方形卡片，包含：
/// - 漸層邊框（使用工具的漸層色）
/// - 工具名稱
/// - 自訂結果內容 widget
/// - 底部「Spectra 工具箱」品牌水印
///
/// 使用方式：將此 widget 放在 [RepaintBoundary] 內，
/// 再用 [ShareCardGenerator.capture()] 截取為圖片。
class ShareCardTemplate extends StatelessWidget {
  const ShareCardTemplate({
    super.key,
    required this.toolName,
    required this.gradientColors,
    required this.resultChild,
  });

  /// 工具名稱，顯示在卡片頂部。
  final String toolName;

  /// 漸層色，用於邊框裝飾。
  final List<Color> gradientColors;

  /// 結果內容 widget，由各工具自行提供。
  final Widget resultChild;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 360,
      height: 360,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: gradientColors,
          ),
          borderRadius: BorderRadius.circular(24),
        ),
        padding: const EdgeInsets.all(4),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 工具名稱
              Text(
                toolName,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: gradientColors.first,
                ),
              ),
              const SizedBox(height: 16),
              // 結果內容
              Expanded(child: Center(child: resultChild)),
              const SizedBox(height: 16),
              // 品牌水印
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: gradientColors),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Spectra 工具箱',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF999999),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
