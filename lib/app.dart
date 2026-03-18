import 'package:flutter/material.dart';
import 'package:my_first_app/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:my_first_app/l10n/l10n.dart';
import 'package:my_first_app/pages/favorites_page.dart';
import 'package:my_first_app/pages/home_page.dart';
import 'package:my_first_app/pages/settings_page.dart';
import 'package:my_first_app/services/settings_service.dart';
import 'package:my_first_app/theme/app_theme.dart';
import 'package:my_first_app/tools/calculator/calculator_page.dart';
import 'package:my_first_app/tools/password_generator/password_generator_page.dart';
import 'package:my_first_app/tools/stopwatch_timer/stopwatch_timer_page.dart';
import 'package:my_first_app/tools/invoice_checker/invoice_checker_page.dart';
import 'package:my_first_app/tools/qr_scanner/qr_scanner_page.dart';
import 'package:my_first_app/tools/color_picker/color_picker_page.dart';
import 'package:my_first_app/tools/compass/compass_page.dart';
import 'package:my_first_app/tools/flashlight/flashlight_page.dart';
import 'package:my_first_app/tools/level/level_page.dart';
import 'package:my_first_app/tools/noise_meter/noise_meter_page.dart';
import 'package:my_first_app/tools/protractor/protractor_page.dart';
import 'package:my_first_app/tools/unit_converter/unit_converter_page.dart';
import 'package:my_first_app/widgets/app_scaffold.dart';

class ToolboxApp extends StatefulWidget {
  final AppSettings settings;

  const ToolboxApp({super.key, required this.settings});

  @override
  State<ToolboxApp> createState() => _ToolboxAppState();
}

class _ToolboxAppState extends State<ToolboxApp> {
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _router = _buildRouter();
  }

  @override
  void dispose() {
    _router.dispose();
    super.dispose();
  }

  GoRouter _buildRouter() {
    return GoRouter(
      initialLocation: '/tools',
      routes: [
        ShellRoute(
          builder: (context, state, child) {
            return AppScaffold(child: child);
          },
          routes: [
            GoRoute(
              path: '/tools',
              builder: (context, state) =>
                  HomePage(settings: widget.settings),
            ),
            GoRoute(
              path: '/favorites',
              builder: (context, state) =>
                  FavoritesPage(settings: widget.settings),
            ),
            GoRoute(
              path: '/settings',
              builder: (context, state) =>
                  SettingsPage(settings: widget.settings),
            ),
          ],
        ),
        // Tool routes (full screen, no bottom nav)
        GoRoute(
          path: '/tools/calculator',
          builder: (context, state) => const CalculatorPage(),
        ),
        GoRoute(
          path: '/tools/unit-converter',
          builder: (context, state) => const UnitConverterPage(),
        ),
        GoRoute(
          path: '/tools/qr-scanner',
          builder: (context, state) => const QrScannerPage(),
        ),
        GoRoute(
          path: '/tools/flashlight',
          builder: (context, state) => const FlashlightPage(),
        ),
        GoRoute(
          path: '/tools/level',
          builder: (context, state) => const LevelPage(),
        ),
        GoRoute(
          path: '/tools/compass',
          builder: (context, state) => const CompassPage(),
        ),
        GoRoute(
          path: '/tools/stopwatch-timer',
          builder: (context, state) => const StopwatchTimerPage(),
        ),
        GoRoute(
          path: '/tools/noise-meter',
          builder: (context, state) => const NoiseMeterPage(),
        ),
        GoRoute(
          path: '/tools/password-generator',
          builder: (context, state) => const PasswordGeneratorPage(),
        ),
        GoRoute(
          path: '/tools/color-picker',
          builder: (context, state) => const ColorPickerPage(),
        ),
        GoRoute(
          path: '/tools/protractor',
          builder: (context, state) => const ProtractorPage(),
        ),
        GoRoute(
          path: '/tools/invoice-checker',
          builder: (context, state) => const InvoiceCheckerPage(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.settings,
      builder: (context, _) {
        return MaterialApp.router(
          title: '工具箱 Pro',
          theme: AppTheme.light(),
          darkTheme: AppTheme.dark(),
          themeMode: widget.settings.themeMode,
          locale: widget.settings.locale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: L10n.supportedLocales,
          routerConfig: _router,
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
