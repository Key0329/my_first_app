import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_first_app/models/tool_item.dart';
import 'package:my_first_app/services/settings_service.dart';
import 'package:my_first_app/widgets/tool_card.dart';

class FavoritesPage extends StatelessWidget {
  final AppSettings settings;

  const FavoritesPage({super.key, required this.settings});

  @override
  Widget build(BuildContext context) {
    final favoriteTools =
        allTools.where((tool) => settings.isFavorite(tool.id)).toList();

    if (favoriteTools.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite_border,
              size: 64,
              color: Theme.of(context).colorScheme.outline,
            ),
            const SizedBox(height: 16),
            Text(
              '尚未收藏任何工具',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.outline,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              '長按工具卡片即可加入收藏',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.outline,
                  ),
            ),
          ],
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 1.1,
      ),
      itemCount: favoriteTools.length,
      itemBuilder: (context, index) {
        final tool = favoriteTools[index];
        return ToolCard(
          tool: tool,
          isFavorite: true,
          onTap: () => context.push(tool.routePath),
          onLongPress: () => settings.toggleFavorite(tool.id),
        );
      },
    );
  }
}
