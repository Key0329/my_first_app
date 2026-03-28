import 'package:flutter/material.dart';
import 'package:my_first_app/theme/design_tokens.dart';
import 'package:my_first_app/widgets/banner_ad_widget.dart';

import 'tool_recommendation_bar.dart';

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
/// 所有 15 個工具頁面均使用此 Scaffold 作為基礎佈局。
/// body 區域內部應使用 [ToolSectionCard] 分組控件，
/// 並以 [DT.toolBodyPadding] 設定外層邊距。
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
    this.showHeaderGradient = true,
    this.actions,
    this.toolId,
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

  /// 是否在 header 區域顯示漸層背景，預設 true。
  /// 設為 false 時 header 背景透明，適用於相機預覽等需要完整顯示內容的場景。
  final bool showHeaderGradient;

  /// AppBar 右側的 action 按鈕列表（如分享按鈕）。
  final List<Widget>? actions;

  /// 工具 ID，提供後在 body 底部顯示「你可能也需要」推薦列。
  final String? toolId;

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
    return [toolColor.withValues(alpha: 0.8), toolColor.withValues(alpha: 0.4)];
  }

  /// 建構漸層 header Container。
  ///
  /// 若 [heroTag] 非空，以 [Hero] + [Material] 包裹以支援共享元素動畫；
  /// [Material] 使用 [MaterialType.transparency] 確保動畫過渡期間正確渲染。
  Widget _buildHeader(List<Color> gradientColors) {
    final decoration = showHeaderGradient
        ? BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: gradientColors,
            ),
          )
        : null;

    final headerContainer = Container(
      width: double.infinity,
      decoration: decoration,
      child: headerChild,
    );

    if (heroTag == null) {
      return headerContainer;
    }

    return Hero(
      tag: heroTag!,
      // 飛行期間漸層背景 + borderRadius 從圓角卡片過渡到矩形 header
      flightShuttleBuilder:
          (flightContext, animation, direction, fromContext, toContext) {
            final borderRadius =
                BorderRadiusTween(
                  begin: BorderRadius.circular(DT.radiusLg),
                  end: BorderRadius.zero,
                ).animate(
                  CurvedAnimation(parent: animation, curve: DT.curveStandard),
                );
            return AnimatedBuilder(
              animation: borderRadius,
              builder: (context, _) => Container(
                decoration: BoxDecoration(
                  borderRadius: borderRadius.value,
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: gradientColors,
                  ),
                ),
              ),
            );
          },
      child: Material(type: MaterialType.transparency, child: headerContainer),
    );
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final colorScheme = Theme.of(context).colorScheme;
    final gradientColors = _gradientColors(brightness);

    return Scaffold(
      // 透明 AppBar（主題已設定 backgroundColor: transparent）
      appBar: AppBar(title: Text(title), actions: actions),
      // AdMob banner（免費用戶顯示，Pro 用戶零高度）
      bottomNavigationBar: const BannerAdWidget(),
      // 使漸層背景延伸至 AppBar 後方
      extendBodyBehindAppBar: true,
      body: Column(
        children: [
          // ── 上方漸層區 ─────────────────────────────────────────
          Expanded(flex: headerFlex, child: _buildHeader(gradientColors)),

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
              child: LayoutBuilder(
                builder: (context, constraints) {
                  Widget content = toolId != null
                      ? Column(
                          children: [
                            Expanded(child: bodyChild),
                            ToolRecommendationBar(toolId: toolId!),
                          ],
                        )
                      : bodyChild;
                  // 寬螢幕（> 900dp）時限寬 600dp 並置中
                  if (constraints.maxWidth > 900) {
                    content = Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 600),
                        child: content,
                      ),
                    );
                  }
                  return content;
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
