import 'package:flutter/material.dart';
import 'package:my_first_app/theme/design_tokens.dart';

class AppTheme {
  static ThemeData light({Color? accentColor}) {
    final seed = accentColor ?? DT.brandPrimary;
    final scheme = ColorScheme.fromSeed(
      seedColor: seed,
      brightness: Brightness.light,
    ).copyWith(surface: DT.lightPageBg, primary: seed);

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: DT.lightPageBg,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      cardTheme: CardThemeData(
        clipBehavior: Clip.antiAlias,
        color: DT.lightCardBg,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(DT.radiusLg),
          side: BorderSide(color: DT.lightCardBorder, width: 0.5),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: DT.lightNavBg,
        indicatorColor: Colors.transparent,
        height: 64,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          final active = states.contains(WidgetState.selected);
          return TextStyle(
            fontSize: DT.fontNavLabel,
            fontWeight: active ? FontWeight.w600 : FontWeight.w400,
            color: active ? DT.lightNavActive : DT.lightNavInactive,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          final active = states.contains(WidgetState.selected);
          return IconThemeData(
            size: DT.navIconSize,
            color: active ? DT.lightNavActive : DT.lightNavInactive,
          );
        }),
      ),
    );
  }

  static ThemeData dark({Color? accentColor}) {
    final seed = accentColor ?? DT.brandPrimary;
    final scheme =
        ColorScheme.fromSeed(
          seedColor: seed,
          brightness: Brightness.dark,
        ).copyWith(
          surface: DT.darkPageBg,
          primary: seed,
          surfaceContainerLowest: DT.darkCardBg,
          surfaceContainerLow: DT.darkCardBg,
          surfaceContainer: DT.darkCardBg,
          surfaceContainerHigh: DT.darkCardBg,
          surfaceContainerHighest: DT.darkCardBg,
        );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: DT.darkPageBg,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      cardTheme: CardThemeData(
        clipBehavior: Clip.antiAlias,
        color: DT.darkCardBg,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(DT.radiusLg),
          side: BorderSide(color: DT.darkCardBorder, width: 0.5),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: DT.darkNavBg,
        indicatorColor: Colors.transparent,
        height: 64,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          final active = states.contains(WidgetState.selected);
          return TextStyle(
            fontSize: DT.fontNavLabel,
            fontWeight: active ? FontWeight.w600 : FontWeight.w400,
            color: active ? DT.darkNavActive : DT.darkNavInactive,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          final active = states.contains(WidgetState.selected);
          return IconThemeData(
            size: DT.navIconSize,
            color: active ? DT.darkNavActive : DT.darkNavInactive,
          );
        }),
      ),
    );
  }
}
