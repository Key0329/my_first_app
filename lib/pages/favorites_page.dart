import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_first_app/models/tool_item.dart';
import 'package:my_first_app/services/settings_service.dart';
import 'package:my_first_app/widgets/tool_card.dart';

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

        return GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.0,
          ),
          itemCount: favoriteTools.length,
          itemBuilder: (context, index) {
            final tool = favoriteTools[index];
            return ToolCard(
              key: ValueKey(tool.id),
              tool: tool,
              isFavorite: true,
              onTap: () => context.push(tool.routePath),
              onLongPress: () => settings.toggleFavorite(tool.id),
              onFavoriteToggle: () => settings.toggleFavorite(tool.id),
            );
          },
        );
      },
    );
  }
}

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
