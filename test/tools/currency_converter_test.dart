import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:my_first_app/tools/currency_converter/currency_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

// --------------------------------------------------------------------------
// Helpers
// --------------------------------------------------------------------------

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

http.Client _timeoutClient() {
  return MockClient((request) async {
    throw http.ClientException('Connection timed out');
  });
}

void main() {
  // --------------------------------------------------------------------------
  // CurrencyApi — unit tests
  // --------------------------------------------------------------------------
  group('CurrencyApi', () {
    test('fetchRates returns rates map on success', () async {
      final api = CurrencyApi(client: _successClient());
      final result = await api.fetchRates('USD');

      expect(result.base, equals('USD'));
      expect(result.rates, isA<Map<String, double>>());
      expect(result.rates['EUR'], equals(0.92));
      expect(result.rates['GBP'], equals(0.79));
      expect(result.rates['JPY'], equals(149.5));
      expect(result.rates['TWD'], equals(32.1));
      expect(result.date, equals('2026-03-21'));
    });

    test('fetchRates throws on server error', () async {
      final api = CurrencyApi(client: _failClient());

      expect(
        () => api.fetchRates('USD'),
        throwsA(isA<CurrencyApiException>()),
      );
    });

    test('fetchRates throws on network error', () async {
      final api = CurrencyApi(client: _timeoutClient());

      expect(
        () => api.fetchRates('USD'),
        throwsA(isA<CurrencyApiException>()),
      );
    });

    test('fetchCurrencies returns currency names', () async {
      final api = CurrencyApi(client: _successClient());
      final currencies = await api.fetchCurrencies();

      expect(currencies, isA<Map<String, String>>());
      expect(currencies['USD'], equals('United States Dollar'));
      expect(currencies['TWD'], equals('New Taiwan Dollar'));
      expect(currencies.length, equals(5));
    });

    test('fetchCurrencies throws on server error', () async {
      final api = CurrencyApi(client: _failClient());

      expect(
        () => api.fetchCurrencies(),
        throwsA(isA<CurrencyApiException>()),
      );
    });

    test('convert calculates correct amount', () {
      final rates = {'EUR': 0.92, 'GBP': 0.79, 'JPY': 149.5};

      // USD -> EUR: 100 * 0.92 = 92
      expect(CurrencyApi.convert(100, 'USD', 'EUR', rates, 'USD'), closeTo(92, 0.01));

      // USD -> JPY: 100 * 149.5 = 14950
      expect(CurrencyApi.convert(100, 'USD', 'JPY', rates, 'USD'), closeTo(14950, 0.01));

      // EUR -> GBP: 100 / 0.92 * 0.79 ≈ 85.87
      expect(CurrencyApi.convert(100, 'EUR', 'GBP', rates, 'USD'), closeTo(85.87, 0.01));

      // EUR -> USD: 100 / 0.92 ≈ 108.70
      expect(CurrencyApi.convert(100, 'EUR', 'USD', rates, 'USD'), closeTo(108.70, 0.01));

      // USD -> USD: identity
      expect(CurrencyApi.convert(100, 'USD', 'USD', rates, 'USD'), equals(100));
    });

    test('convert with zero amount returns 0', () {
      final rates = {'EUR': 0.92};
      expect(CurrencyApi.convert(0, 'USD', 'EUR', rates, 'USD'), equals(0));
    });

    test('convert throws ArgumentError for unknown fromCurrency', () {
      final rates = {'EUR': 0.92};
      expect(
        () => CurrencyApi.convert(100, 'XYZ', 'EUR', rates, 'USD'),
        throwsA(isA<ArgumentError>().having(
          (e) => e.message,
          'message',
          contains('XYZ'),
        )),
      );
    });

    test('convert throws ArgumentError for unknown toCurrency', () {
      final rates = {'EUR': 0.92};
      expect(
        () => CurrencyApi.convert(100, 'EUR', 'XYZ', rates, 'USD'),
        throwsA(isA<ArgumentError>().having(
          (e) => e.message,
          'message',
          contains('XYZ'),
        )),
      );
    });
  });

  // --------------------------------------------------------------------------
  // CurrencyCache — unit tests
  // --------------------------------------------------------------------------
  group('CurrencyCache', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    test('saveRates and loadRates round-trip', () async {
      final cache = CurrencyCache();
      final ratesResult = ExchangeRatesResult(
        base: 'USD',
        date: '2026-03-21',
        rates: {'EUR': 0.92, 'GBP': 0.79},
      );

      await cache.saveRates(ratesResult);
      final loaded = await cache.loadRates();

      expect(loaded, isNotNull);
      expect(loaded!.base, equals('USD'));
      expect(loaded.rates['EUR'], equals(0.92));
      expect(loaded.rates['GBP'], equals(0.79));
      expect(loaded.date, equals('2026-03-21'));
    });

    test('loadRates returns null when no cache exists', () async {
      final cache = CurrencyCache();
      final loaded = await cache.loadRates();
      expect(loaded, isNull);
    });

    test('saveCurrencies and loadCurrencies round-trip', () async {
      final cache = CurrencyCache();
      final currencies = {'USD': 'United States Dollar', 'EUR': 'Euro'};

      await cache.saveCurrencies(currencies);
      final loaded = await cache.loadCurrencies();

      expect(loaded, isNotNull);
      expect(loaded!['USD'], equals('United States Dollar'));
      expect(loaded['EUR'], equals('Euro'));
    });

    test('loadCurrencies returns null when no cache', () async {
      final cache = CurrencyCache();
      final loaded = await cache.loadCurrencies();
      expect(loaded, isNull);
    });

    test('getCacheTimestamp returns timestamp after save', () async {
      final cache = CurrencyCache();
      final ratesResult = ExchangeRatesResult(
        base: 'USD',
        date: '2026-03-21',
        rates: {'EUR': 0.92},
      );

      await cache.saveRates(ratesResult);
      final timestamp = await cache.getCacheTimestamp();

      expect(timestamp, isNotNull);
      // Timestamp should be recent (within last 5 seconds)
      expect(
        DateTime.now().difference(timestamp!).inSeconds.abs(),
        lessThan(5),
      );
    });

    test('getCacheTimestamp returns null when no cache', () async {
      final cache = CurrencyCache();
      final timestamp = await cache.getCacheTimestamp();
      expect(timestamp, isNull);
    });
  });

  // --------------------------------------------------------------------------
  // ExchangeRatesResult — serialization tests
  // --------------------------------------------------------------------------
  group('ExchangeRatesResult', () {
    test('fromJson parses API response correctly', () {
      final json = jsonDecode(_ratesJson) as Map<String, dynamic>;
      final result = ExchangeRatesResult.fromJson(json);

      expect(result.base, equals('USD'));
      expect(result.date, equals('2026-03-21'));
      expect(result.rates['EUR'], equals(0.92));
      expect(result.rates.length, equals(4));
    });

    test('toJson / fromJson round-trip', () {
      final original = ExchangeRatesResult(
        base: 'EUR',
        date: '2026-03-20',
        rates: {'USD': 1.09, 'GBP': 0.86},
      );

      final json = original.toJson();
      final restored = ExchangeRatesResult.fromJson(json);

      expect(restored.base, equals(original.base));
      expect(restored.date, equals(original.date));
      expect(restored.rates, equals(original.rates));
    });
  });
}
