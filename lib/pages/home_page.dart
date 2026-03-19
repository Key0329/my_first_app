import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_first_app/models/tool_item.dart';
import 'package:my_first_app/services/settings_service.dart';
import 'package:my_first_app/widgets/bento_grid.dart';
import 'package:my_first_app/widgets/staggered_fade_in.dart';
import 'package:my_first_app/widgets/tool_card.dart';

/// 首頁，以 BentoGrid 呈現所有工具並支援搜尋過濾。
///
/// 版面結構：
/// - 上方固定 [SearchBar]（不可捲動）
/// - 下方 [SingleChildScrollView] 包裹 [BentoGrid]
///
/// 功能：
/// - 搜尋過濾：即時根據輸入字詞篩選工具
/// - 收藏升格：已收藏的工具卡片使用 [BentoSize.large]，其餘使用各工具的 [ToolItem.defaultBentoSize]
/// - 動態響應：以 [ListenableBuilder] 監聽 [AppSettings] 收藏變更，自動重算 Bento 尺寸
class HomePage extends StatefulWidget {
  final AppSettings settings;

  const HomePage({super.key, required this.settings});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _searchQuery = '';

  /// 是否已播放過首次載入動畫。
  ///
  /// 因 ShellRoute 保留 State，tab 切換時此 State 不會重建，
  /// 所以旗標能持續保存，避免 tab 切換時重播動畫。
  bool _hasAnimated = false;

  /// 根據搜尋字詞過濾後的工具列表。
  List<ToolItem> get _filteredTools {
    if (_searchQuery.isEmpty) return allTools;
    final query = _searchQuery.toLowerCase();
    return allTools
        .where((tool) => tool.fallbackName.toLowerCase().contains(query))
        .toList();
  }

  /// 根據收藏狀態決定每個工具的 [BentoSize]。
  ///
  /// 收藏的工具升格為 [BentoSize.large]，其餘使用 [ToolItem.defaultBentoSize]。
  BentoSize _bentoSizeFor(ToolItem tool) {
    if (widget.settings.isFavorite(tool.id)) return BentoSize.large;
    return tool.defaultBentoSize;
  }

  void _openTool(BuildContext context, ToolItem tool) {
    context.push(tool.routePath);
  }

  @override
  Widget build(BuildContext context) {
    // 首次 build 完成後標記動畫已播放，之後 rebuild 不再觸發動畫
    final shouldAnimate = !_hasAnimated;
    if (!_hasAnimated) {
      // 於本次 build 後標記，下次 rebuild（如 tab 切換）不重播
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) setState(() => _hasAnimated = true);
      });
    }

    return Column(
      children: [
        // 固定於頂部、不隨內容捲動的搜尋列
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: SearchBar(
            hintText: '搜尋工具...',
            leading: const Icon(Icons.search),
            onChanged: (value) => setState(() => _searchQuery = value),
            elevation: const WidgetStatePropertyAll(0),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        // BentoGrid 區域可捲動，並透過 ListenableBuilder 響應收藏變更
        Expanded(
          child: ListenableBuilder(
            listenable: widget.settings,
            builder: (context, _) {
              final tools = _filteredTools;
              final sizes = tools.map(_bentoSizeFor).toList();

              return SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                child: BentoGrid(
                  sizes: sizes,
                  itemCount: tools.length,
                  itemBuilder: (context, index) {
                    final tool = tools[index];
                    return StaggeredFadeIn(
                      index: index,
                      totalItems: tools.length,
                      animate: shouldAnimate,
                      child: ToolCard(
                        tool: tool,
                        isFavorite: widget.settings.isFavorite(tool.id),
                        bentoSize: sizes[index],
                        onTap: () => _openTool(context, tool),
                        onLongPress: () =>
                            widget.settings.toggleFavorite(tool.id),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
