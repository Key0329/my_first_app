import 'package:flutter/material.dart';

/// 沉浸式工具頁面 Scaffold。
///
/// 提供漸層背景的上半區（工具色）與白色圓角的下半操作區，
/// 搭配透明 AppBar，形成沉浸式的工具頁面視覺體驗。
///
/// 佈局結構：
/// ```
/// ┌────────────────────────┐
/// │  透明 AppBar + 返回鍵    │
/// │  ▼ 漸層背景區（工具色）   │  ← headerFlex（預設 2）
/// │  ▼ headerChild          │
/// ├────── 圓角分隔 ──────────┤
/// │                        │  ← bodyFlex（預設 3）
/// │  bodyChild              │    top corners radius = 24
/// │                        │
/// └────────────────────────┘
/// ```
///
/// 範例：
/// ```dart
/// ImmersiveToolScaffold(
///   toolColor: Colors.teal,
///   title: '手電筒',
///   headerChild: FlashlightDisplay(),
///   bodyChild: FlashlightControls(),
/// )
/// ```
class ImmersiveToolScaffold extends StatelessWidget {
  const ImmersiveToolScaffold({
    super.key,
    required this.toolColor,
    required this.title,
    required this.headerChild,
    required this.bodyChild,
    this.headerFlex = 2,
    this.bodyFlex = 3,
    this.heroTag,
  });

  /// 工具指定顏色，用於計算漸層背景色
  final Color toolColor;

  /// 顯示於 AppBar 的工具名稱
  final String title;

  /// 上方漸層區的主要內容
  final Widget headerChild;

  /// 下方表面區的操作內容
  final Widget bodyChild;

  /// 上方漸層區的 flex 比例，預設 2
  final int headerFlex;

  /// 下方操作區的 flex 比例，預設 3
  final int bodyFlex;

  /// 可選的 Hero 動畫標籤。設定後，漸層 header Container 會被
  /// Hero widget 包裹，與首頁 ToolCard 的 Hero(tag: 'tool_hero_${tool.id}')
  /// 形成配對，產生共享元素過渡動畫。
  final String? heroTag;

  /// 根據 brightness 計算漸層色彩
  ///
  /// - Light mode: [toolColor.withValues(alpha: 0.8), toolColor.withValues(alpha: 0.4)]
  /// - Dark mode:  [toolColor.withValues(alpha: 0.5), toolColor.withValues(alpha: 0.2)]
  List<Color> _gradientColors(Brightness brightness) {
    if (brightness == Brightness.dark) {
      return [
        toolColor.withValues(alpha: 0.5),
        toolColor.withValues(alpha: 0.2),
      ];
    }
    return [
      toolColor.withValues(alpha: 0.8),
      toolColor.withValues(alpha: 0.4),
    ];
  }

  /// 建構漸層 header Container。
  ///
  /// 若 [heroTag] 非空，以 [Hero] + [Material] 包裹以支援共享元素動畫；
  /// [Material] 使用 [MaterialType.transparency] 確保動畫過渡期間正確渲染。
  Widget _buildHeader(List<Color> gradientColors) {
    final gradientContainer = Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: gradientColors,
        ),
      ),
      child: headerChild,
    );

    if (heroTag == null) {
      return gradientContainer;
    }

    return Hero(
      tag: heroTag!,
      child: Material(
        type: MaterialType.transparency,
        child: gradientContainer,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final colorScheme = Theme.of(context).colorScheme;
    final gradientColors = _gradientColors(brightness);

    return Scaffold(
      // 透明 AppBar（主題已設定 backgroundColor: transparent）
      appBar: AppBar(
        title: Text(title),
      ),
      // 使漸層背景延伸至 AppBar 後方
      extendBodyBehindAppBar: true,
      body: Column(
        children: [
          // ── 上方漸層區 ─────────────────────────────────────────
          Expanded(
            flex: headerFlex,
            child: _buildHeader(gradientColors),
          ),

          // ── 下方圓角表面區 ─────────────────────────────────────
          // 使用負 margin 使圓角覆蓋在漸層上方（overlap 24px）
          Expanded(
            flex: bodyFlex,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: bodyChild,
            ),
          ),
        ],
      ),
    );
  }
}
