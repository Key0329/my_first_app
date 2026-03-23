import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_first_app/l10n/app_localizations.dart';
import 'package:my_first_app/services/analytics_service.dart';
import 'package:my_first_app/services/haptic_service.dart';
import 'package:my_first_app/theme/design_tokens.dart';

class AppScaffold extends StatelessWidget {
  final Widget child;

  const AppScaffold({super.key, required this.child});

  static const _tabPaths = ['/tools', '/favorites', '/settings'];
  static const _tabIcons = [
    Icons.grid_view_rounded,
    Icons.favorite_outline,
    Icons.settings_outlined,
  ];

  int _currentIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    for (var i = 0; i < _tabPaths.length; i++) {
      if (location == _tabPaths[i]) return i;
    }
    return 0;
  }

  static const _wideBreakpoint = 900.0;

  void _onDestinationSelected(
    BuildContext context,
    int index,
    List<String> tabLabels,
  ) {
    HapticService.selection();
    AnalyticsService.instance.logTabSwitch(tabName: tabLabels[index]);
    context.go(_tabPaths[index]);
  }

  @override
  Widget build(BuildContext context) {
    final b = Theme.of(context).brightness;
    final currentIndex = _currentIndex(context);
    final l10n = AppLocalizations.of(context)!;
    final tabLabels = [l10n.tabTools, l10n.tabFavorites, l10n.tabSettings];
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isWide = screenWidth > _wideBreakpoint;

    if (isWide) {
      return Scaffold(
        body: Row(
          children: [
            NavigationRail(
              selectedIndex: currentIndex,
              onDestinationSelected: (index) =>
                  _onDestinationSelected(context, index, tabLabels),
              labelType: NavigationRailLabelType.all,
              destinations: List.generate(
                _tabPaths.length,
                (i) => NavigationRailDestination(
                  icon: Icon(_tabIcons[i]),
                  label: Text(tabLabels[i]),
                ),
              ),
            ),
            VerticalDivider(width: 0.5, thickness: 0.5, color: DT.navBorder(b)),
            Expanded(child: child),
          ],
        ),
      );
    }

    return Scaffold(
      body: child,
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(height: 0.5, thickness: 0.5, color: DT.navBorder(b)),
          NavigationBar(
            selectedIndex: currentIndex,
            onDestinationSelected: (index) =>
                _onDestinationSelected(context, index, tabLabels),
            destinations: List.generate(
              _tabPaths.length,
              (i) => NavigationDestination(
                icon: Icon(_tabIcons[i]),
                label: tabLabels[i],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
