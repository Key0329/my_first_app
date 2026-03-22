import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_first_app/models/tool_item.dart';
import 'package:my_first_app/theme/design_tokens.dart';

/// Filters [allTools] by matching [query] against tool name, route path,
/// and category label (case-insensitive).
List<ToolItem> filterTools(String query) {
  if (query.isEmpty) return allTools;
  final q = query.toLowerCase();
  return allTools.where((tool) {
    final name = tool.fallbackName.toLowerCase();
    final route = tool.routePath.toLowerCase();
    final category = tool.category.label.toLowerCase();
    return name.contains(q) || route.contains(q) || category.contains(q);
  }).toList();
}

class ToolSearchDelegate extends SearchDelegate<ToolItem?> {
  ToolSearchDelegate()
      : super(
          searchFieldLabel: '搜尋工具...',
          searchFieldStyle: const TextStyle(fontSize: 16),
        );

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () => query = '',
        ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) => _buildList(context);

  @override
  Widget buildSuggestions(BuildContext context) => _buildList(context);

  Widget _buildList(BuildContext context) {
    final results = filterTools(query);

    if (results.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.search_off,
              size: 56,
              color: Theme.of(context).colorScheme.outline,
            ),
            const SizedBox(height: 16),
            Text(
              '找不到符合的工具',
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.outline,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final tool = results[index];
        final gradient = toolGradients[tool.id];

        return ListTile(
          leading: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              gradient: gradient != null
                  ? LinearGradient(colors: gradient)
                  : null,
              color: gradient == null ? tool.color : null,
              borderRadius: BorderRadius.circular(DT.radiusSm),
            ),
            child: Icon(tool.icon, color: Colors.white, size: 20),
          ),
          title: Text(tool.fallbackName),
          subtitle: Text(tool.category.label),
          onTap: () {
            final router = GoRouter.of(context);
            close(context, null);
            router.push(tool.routePath);
          },
        );
      },
    );
  }
}
