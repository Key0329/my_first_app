import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_first_app/models/tool_item.dart';
import 'package:my_first_app/services/settings_service.dart';
import 'package:my_first_app/widgets/bento_grid.dart';
import 'package:my_first_app/widgets/tool_card.dart';

/// 收藏頁面。
///
/// 顯示使用者收藏的工具，使用 [BentoGrid] 排版，所有收藏工具以
/// [BentoSize.large] 呈現（凸顯收藏品的重要性）。
///
/// 使用 [ListenableBuilder] 監聽 [AppSettings] 的變更，讓畫面在
/// 收藏狀態改變時即時更新，不需要重建整個頁面。
class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key, required this.settings});

  final AppSettings settings;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: settings,
      builder: (context, _) {
        final favoriteTools =
            allTools.where((tool) => settings.isFavorite(tool.id)).toList();

        if (favoriteTools.isEmpty) {
          return _EmptyState();
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: BentoGrid(
            itemCount: favoriteTools.length,
            sizes: List.filled(favoriteTools.length, BentoSize.large),
            itemBuilder: (context, index) {
              final tool = favoriteTools[index];
              return ToolCard(
                key: ValueKey(tool.id),
                tool: tool,
                isFavorite: true,
                bentoSize: BentoSize.large,
                onTap: () => context.push(tool.routePath),
                onLongPress: () => settings.toggleFavorite(tool.id),
              );
            },
          ),
        );
      },
    );
  }
}

/// 無收藏時的空狀態 widget。
///
/// 顯示愛心輪廓圖示與提示文字，引導使用者至工具頁面進行收藏。
class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final outline = Theme.of(context).colorScheme.outline;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.favorite_border, size: 64, color: outline),
          const SizedBox(height: 16),
          Text(
            '尚未收藏任何工具',
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: outline),
          ),
          const SizedBox(height: 8),
          Text(
            '長按工具卡片即可加入收藏',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: outline),
          ),
        ],
      ),
    );
  }
}
