import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:my_first_app/l10n/app_localizations.dart';
import 'package:my_first_app/tools/currency_converter/currency_api.dart';
import 'package:my_first_app/tools/currency_converter/currency_converter_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

const _ratesJson = '''
{
  "amount": 1,
  "base": "USD",
  "date": "2026-03-21",
  "rates": {
    "EUR": 0.92,
    "GBP": 0.79,
    "JPY": 149.5,
    "TWD": 32.1
  }
}
''';

const _currenciesJson = '''
{
  "USD": "United States Dollar",
  "EUR": "Euro",
  "GBP": "British Pound",
  "JPY": "Japanese Yen",
  "TWD": "New Taiwan Dollar"
}
''';

http.Client _successClient() {
  return MockClient((request) async {
    if (request.url.path.contains('/currencies')) {
      return http.Response(_currenciesJson, 200);
    }
    return http.Response(_ratesJson, 200);
  });
}

http.Client _failClient() {
  return MockClient((request) async {
    return http.Response('Server Error', 500);
  });
}

/// Build the widget under test with localizations.
Widget _buildApp({CurrencyApi? api, CurrencyCache? cache}) {
  return MaterialApp(
    localizationsDelegates: const [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: const [Locale('zh'), Locale('en')],
    locale: const Locale('zh'),
    home: CurrencyConverterPage(api: api, cache: cache),
  );
}

// ImmersiveToolScaffold needs a tall viewport.
const _testSurfaceSize = Size(414, 896);

void main() {
  // --------------------------------------------------------------------------
  // Widget Tests
  // --------------------------------------------------------------------------
  group('CurrencyConverterPage widget', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    testWidgets('shows loading then displays rates on success', (tester) async {
      await tester.binding.setSurfaceSize(_testSurfaceSize);
      addTearDown(() => tester.binding.setSurfaceSize(null));

      final api = CurrencyApi(client: _successClient());
      await tester.pumpWidget(_buildApp(api: api));

      // Initially loading
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      // Pump until futures complete
      await tester.pumpAndSettle();

      // Should show currency dropdowns
      expect(find.byKey(const Key('from_currency_dropdown')), findsOneWidget);
      expect(find.byKey(const Key('to_currency_dropdown')), findsOneWidget);
      expect(find.byKey(const Key('amount_input')), findsOneWidget);
    });

    testWidgets('entering amount shows converted result', (tester) async {
      await tester.binding.setSurfaceSize(_testSurfaceSize);
      addTearDown(() => tester.binding.setSurfaceSize(null));

      final api = CurrencyApi(client: _successClient());
      await tester.pumpWidget(_buildApp(api: api));
      await tester.pumpAndSettle();

      // Enter amount
      await tester.enterText(find.byKey(const Key('amount_input')), '100');
      await tester.pumpAndSettle();

      // Result should show conversion (100 USD -> EUR = 92)
      expect(find.text('92'), findsOneWidget);
    });

    testWidgets('swap button exchanges currencies', (tester) async {
      await tester.binding.setSurfaceSize(_testSurfaceSize);
      addTearDown(() => tester.binding.setSurfaceSize(null));

      final api = CurrencyApi(client: _successClient());
      await tester.pumpWidget(_buildApp(api: api));
      await tester.pumpAndSettle();

      // Enter amount first
      await tester.enterText(find.byKey(const Key('amount_input')), '100');
      await tester.pumpAndSettle();

      // Initial conversion: USD -> EUR = 92
      expect(find.text('92'), findsOneWidget);

      // Tap swap button
      await tester.tap(find.byKey(const Key('swap_button')));
      await tester.pumpAndSettle();

      // After swap: EUR -> USD = 100 / 0.92 ≈ 108.70
      expect(find.text('108.70'), findsOneWidget);
    });

    testWidgets('shows error when API fails and no cache', (tester) async {
      await tester.binding.setSurfaceSize(_testSurfaceSize);
      addTearDown(() => tester.binding.setSurfaceSize(null));

      final api = CurrencyApi(client: _failClient());
      await tester.pumpWidget(_buildApp(api: api));
      await tester.pumpAndSettle();

      // Should show error message
      expect(find.byKey(const Key('error_message')), findsOneWidget);
      expect(find.byKey(const Key('retry_button')), findsOneWidget);
    });

    testWidgets('shows offline indicator when using cached data', (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(_testSurfaceSize);
      addTearDown(() => tester.binding.setSurfaceSize(null));

      // Pre-populate cache
      final cache = CurrencyCache();
      final ratesResult = ExchangeRatesResult(
        base: 'USD',
        date: '2026-03-20',
        rates: {'EUR': 0.91, 'GBP': 0.78},
      );
      await cache.saveRates(ratesResult);
      await cache.saveCurrencies({
        'USD': 'United States Dollar',
        'EUR': 'Euro',
        'GBP': 'British Pound',
      });

      // Use failing client so it falls back to cache
      final api = CurrencyApi(client: _failClient());
      await tester.pumpWidget(_buildApp(api: api, cache: cache));
      await tester.pumpAndSettle();

      // Should show offline indicator
      expect(find.byKey(const Key('offline_indicator')), findsOneWidget);

      // Should still show dropdowns (data loaded from cache)
      expect(find.byKey(const Key('from_currency_dropdown')), findsOneWidget);
    });

    testWidgets('retry button re-triggers data load', (tester) async {
      await tester.binding.setSurfaceSize(_testSurfaceSize);
      addTearDown(() => tester.binding.setSurfaceSize(null));

      final api = CurrencyApi(client: _failClient());
      await tester.pumpWidget(_buildApp(api: api));
      await tester.pumpAndSettle();

      // Error state
      expect(find.byKey(const Key('error_message')), findsOneWidget);

      // Tap retry — it will still fail, but the button should be tappable
      await tester.tap(find.byKey(const Key('retry_button')));
      await tester.pumpAndSettle();

      // Still showing error (since client still fails)
      expect(find.byKey(const Key('error_message')), findsOneWidget);
    });
  });
}
