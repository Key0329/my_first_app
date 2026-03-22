import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// ---------------------------------------------------------------------------
// Data model
// ---------------------------------------------------------------------------

/// Parsed result from the frankfurter.app exchange rates API.
class ExchangeRatesResult {
  ExchangeRatesResult({
    required this.base,
    required this.date,
    required this.rates,
  });

  /// Base currency code (e.g. "USD").
  final String base;

  /// Date string from the API (e.g. "2026-03-21").
  final String date;

  /// Exchange rates keyed by currency code.
  final Map<String, double> rates;

  factory ExchangeRatesResult.fromJson(Map<String, dynamic> json) {
    final rawRates = json['rates'] as Map<String, dynamic>;
    final rates = rawRates.map<String, double>(
      (key, value) => MapEntry(key, (value as num).toDouble()),
    );
    return ExchangeRatesResult(
      base: json['base'] as String,
      date: json['date'] as String,
      rates: rates,
    );
  }

  Map<String, dynamic> toJson() => {
    'base': base,
    'date': date,
    'rates': rates,
  };
}

// ---------------------------------------------------------------------------
// Exception
// ---------------------------------------------------------------------------

/// Thrown when the currency API call fails.
class CurrencyApiException implements Exception {
  CurrencyApiException(this.message);
  final String message;

  @override
  String toString() => 'CurrencyApiException: $message';
}

// ---------------------------------------------------------------------------
// API client
// ---------------------------------------------------------------------------

/// Fetches live exchange rates from frankfurter.app.
///
/// Accepts an optional [http.Client] for dependency injection / testing.
class CurrencyApi {
  CurrencyApi({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  static const _baseUrl = 'https://api.frankfurter.app';

  /// Fetch latest exchange rates with [baseCurrency] as the base.
  ///
  /// Throws [CurrencyApiException] on network or server errors.
  Future<ExchangeRatesResult> fetchRates(String baseCurrency) async {
    try {
      final uri = Uri.parse('$_baseUrl/latest?from=$baseCurrency');
      final response = await _client.get(uri);

      if (response.statusCode != 200) {
        throw CurrencyApiException(
          'HTTP ${response.statusCode}: ${response.body}',
        );
      }

      final json = jsonDecode(response.body) as Map<String, dynamic>;
      return ExchangeRatesResult.fromJson(json);
    } on CurrencyApiException {
      rethrow;
    } catch (e) {
      throw CurrencyApiException(e.toString());
    }
  }

  /// Fetch the list of supported currencies.
  ///
  /// Returns a map of currency code -> full name.
  /// Throws [CurrencyApiException] on failure.
  Future<Map<String, String>> fetchCurrencies() async {
    try {
      final uri = Uri.parse('$_baseUrl/currencies');
      final response = await _client.get(uri);

      if (response.statusCode != 200) {
        throw CurrencyApiException(
          'HTTP ${response.statusCode}: ${response.body}',
        );
      }

      final json = jsonDecode(response.body) as Map<String, dynamic>;
      return json.map<String, String>(
        (key, value) => MapEntry(key, value as String),
      );
    } on CurrencyApiException {
      rethrow;
    } catch (e) {
      throw CurrencyApiException(e.toString());
    }
  }

  /// Convert [amount] from [fromCurrency] to [toCurrency] using [rates].
  ///
  /// [rates] must be relative to [ratesBase] (the base currency of the rates
  /// map). Both source and target currencies must exist in rates or be the
  /// base currency itself.
  static double convert(
    double amount,
    String fromCurrency,
    String toCurrency,
    Map<String, double> rates,
    String ratesBase,
  ) {
    if (fromCurrency == toCurrency) return amount;

    // Convert fromCurrency -> base -> toCurrency
    final fromRate = fromCurrency == ratesBase
        ? 1.0
        : rates[fromCurrency] ?? 1.0;
    final toRate = toCurrency == ratesBase
        ? 1.0
        : rates[toCurrency] ?? 1.0;

    return amount / fromRate * toRate;
  }
}

// ---------------------------------------------------------------------------
// Offline cache
// ---------------------------------------------------------------------------

/// Caches exchange rates and currencies in [SharedPreferences].
class CurrencyCache {
  static const _keyRates = 'currency_cache_rates';
  static const _keyCurrencies = 'currency_cache_currencies';
  static const _keyTimestamp = 'currency_cache_timestamp';

  /// Save exchange rates result to cache.
  Future<void> saveRates(ExchangeRatesResult result) async {
    final prefs = await SharedPreferences.getInstance();
    final json = jsonEncode(result.toJson());
    await prefs.setString(_keyRates, json);
    await prefs.setString(
      _keyTimestamp,
      DateTime.now().toIso8601String(),
    );
  }

  /// Load cached exchange rates. Returns `null` if no cache exists.
  Future<ExchangeRatesResult?> loadRates() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString(_keyRates);
    if (json == null) return null;

    try {
      final map = jsonDecode(json) as Map<String, dynamic>;
      return ExchangeRatesResult.fromJson(map);
    } catch (_) {
      return null;
    }
  }

  /// Save currency name map to cache.
  Future<void> saveCurrencies(Map<String, String> currencies) async {
    final prefs = await SharedPreferences.getInstance();
    final json = jsonEncode(currencies);
    await prefs.setString(_keyCurrencies, json);
  }

  /// Load cached currency names. Returns `null` if no cache exists.
  Future<Map<String, String>?> loadCurrencies() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString(_keyCurrencies);
    if (json == null) return null;

    try {
      final map = jsonDecode(json) as Map<String, dynamic>;
      return map.map<String, String>(
        (key, value) => MapEntry(key, value as String),
      );
    } catch (_) {
      return null;
    }
  }

  /// Get the timestamp of when rates were last cached.
  Future<DateTime?> getCacheTimestamp() async {
    final prefs = await SharedPreferences.getInstance();
    final str = prefs.getString(_keyTimestamp);
    if (str == null) return null;
    return DateTime.tryParse(str);
  }
}
