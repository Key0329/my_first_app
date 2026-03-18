import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppScaffold extends StatelessWidget {
  final Widget child;

  const AppScaffold({super.key, required this.child});

  static const _tabs = [
    ('/tools', Icons.build, '工具'),
    ('/favorites', Icons.favorite, '收藏'),
    ('/settings', Icons.settings, '設定'),
  ];

  int _currentIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    for (var i = 0; i < _tabs.length; i++) {
      if (location == _tabs[i].$1) return i;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = _currentIndex(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('工具箱 Pro'),
      ),
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          context.go(_tabs[index].$1);
        },
        destinations: _tabs
            .map(
              (tab) => NavigationDestination(
                icon: Icon(tab.$2),
                label: tab.$3,
              ),
            )
            .toList(),
      ),
    );
  }
}
