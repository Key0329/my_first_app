import 'package:flutter/material.dart';
import 'package:my_first_app/l10n/app_localizations.dart';
import 'package:my_first_app/theme/design_tokens.dart';
import 'package:my_first_app/widgets/animated_value_text.dart';
import 'package:my_first_app/widgets/bouncing_button.dart';
import 'package:my_first_app/widgets/immersive_tool_scaffold.dart';
import 'package:my_first_app/widgets/staggered_fade_in.dart';
import 'package:my_first_app/widgets/tool_section_card.dart';

import 'package:my_first_app/services/widget_service.dart';

import 'currency_api.dart';

/// Tool color for the currency converter (teal).
const _toolColor = Color(0xFF26A69A);

/// Full-screen page for the currency converter tool.
class CurrencyConverterPage extends StatefulWidget {
  const CurrencyConverterPage({super.key, this.api, this.cache});

  /// Optional API instance for dependency injection / testing.
  final CurrencyApi? api;

  /// Optional cache instance for dependency injection / testing.
  final CurrencyCache? cache;

  @override
  State<CurrencyConverterPage> createState() => _CurrencyConverterPageState();
}

class _CurrencyConverterPageState extends State<CurrencyConverterPage> {
  late final CurrencyApi _api;
  late final CurrencyCache _cache;

  final _amountController = TextEditingController();

  // State
  Map<String, double> _rates = {};
  Map<String, String> _currencyNames = {};
  String _ratesBase = 'USD';
  String _fromCurrency = 'USD';
  String _toCurrency = 'EUR';
  String _result = '';
  String _ratesDate = '';
  bool _isLoading = true;
  bool _isOffline = false;
  String? _errorMessage;
  DateTime? _cacheTimestamp;

  // Multi-currency mode
  bool _isMultiMode = false;
  final Set<String> _multiTargets = {'TWD', 'USD', 'JPY', 'EUR'};

  /// Favorite currencies pinned at top.
  static const _favoriteCurrencies = ['TWD', 'USD', 'JPY', 'EUR'];

  /// Sorted list of currency codes with favorites pinned at top.
  List<String> get _currencyCodes {
    final codes = <String>{_ratesBase, ..._rates.keys};
    final favorites = _favoriteCurrencies.where(codes.contains).toList();
    final rest = (codes.toList()..sort())
        .where((c) => !favorites.contains(c))
        .toList();
    return [...favorites, ...rest];
  }

  /// Index where the divider should appear (after favorites).
  int get _favoriteDividerIndex =>
      _favoriteCurrencies.where(_currencyCodes.contains).length;

  @override
  void initState() {
    super.initState();
    _api = widget.api ?? CurrencyApi();
    _cache = widget.cache ?? CurrencyCache();
    _amountController.addListener(_onAmountChanged);
    _loadRates();
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  // --------------------------------------------------------------------------
  // Data loading
  // --------------------------------------------------------------------------

  Future<void> _loadRates() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Try fetching live rates.
      final result = await _api.fetchRates('USD');
      final currencies = await _api.fetchCurrencies();

      // Cache for offline use.
      await _cache.saveRates(result);
      await _cache.saveCurrencies(currencies);

      if (!mounted) return;
      setState(() {
        _rates = result.rates;
        _ratesBase = result.base;
        _ratesDate = result.date;
        _currencyNames = currencies;
        _isOffline = false;
        _isLoading = false;
      });
      _updateResult();
    } on CurrencyApiException {
      // Network failed — try cache.
      await _loadFromCache();
    }
  }

  Future<void> _loadFromCache() async {
    final cachedRates = await _cache.loadRates();
    final cachedCurrencies = await _cache.loadCurrencies();
    final timestamp = await _cache.getCacheTimestamp();

    if (!mounted) return;

    if (cachedRates != null) {
      setState(() {
        _rates = cachedRates.rates;
        _ratesBase = cachedRates.base;
        _ratesDate = cachedRates.date;
        _currencyNames = cachedCurrencies ?? {};
        _isOffline = true;
        _isLoading = false;
        _cacheTimestamp = timestamp;
      });
      _updateResult();
    } else {
      // No cache and no network.
      setState(() {
        _isLoading = false;
        _errorMessage = 'network_required';
      });
    }
  }

  // --------------------------------------------------------------------------
  // Conversion logic
  // --------------------------------------------------------------------------

  void _onAmountChanged() {
    _updateResult();
  }

  void _updateResult() {
    final text = _amountController.text.trim();
    if (text.isEmpty || _rates.isEmpty) {
      setState(() => _result = '');
      return;
    }
    final amount = double.tryParse(text);
    if (amount == null) {
      setState(() => _result = '');
      return;
    }
    try {
      final converted = CurrencyApi.convert(
        amount,
        _fromCurrency,
        _toCurrency,
        _rates,
        _ratesBase,
      );
      final formattedResult = _formatNumber(converted);
      setState(() {
        _result = formattedResult;
        _errorMessage = null;
      });
      // 更新桌面匯率 Widget
      WidgetService.instance.updateCurrencyWidget(
        fromCurrency: _fromCurrency,
        toCurrency: _toCurrency,
        rate: formattedResult,
      );
    } on ArgumentError catch (e) {
      setState(() {
        _result = '';
        _errorMessage = e.message as String?;
      });
    }
  }

  String _formatNumber(double value) {
    // Show up to 2 decimal places for currency.
    if (value == value.roundToDouble() && value.abs() < 1e15) {
      return value.toStringAsFixed(0);
    }
    final s = value.toStringAsFixed(2);
    return s;
  }

  // --------------------------------------------------------------------------
  // Task 3.4 — Swap currencies
  // --------------------------------------------------------------------------

  void _swapCurrencies() {
    setState(() {
      final temp = _fromCurrency;
      _fromCurrency = _toCurrency;
      _toCurrency = temp;
    });
    _updateResult();
  }

  // --------------------------------------------------------------------------
  // Build
  // --------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return ImmersiveToolScaffold(
      toolId: 'currency_converter',
      toolColor: _toolColor,
      title: l10n.tool_currency_converter_title,
      heroTag: 'tool_hero_currency_converter',
      headerFlex: 2,
      bodyFlex: 3,
      headerChild: _buildHeader(context, l10n),
      bodyChild: _buildBody(context, l10n),
    );
  }

  /// Header: result display area.
  Widget _buildHeader(BuildContext context, AppLocalizations l10n) {
    final theme = Theme.of(context);

    return SafeArea(
      top: true,
      bottom: false,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Offline indicator
              if (_isOffline)
                Container(
                  key: const Key('offline_indicator'),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.orange.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.cloud_off,
                        size: 16,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        l10n.tool_currency_converter_offline,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              if (_isOffline) const SizedBox(height: 8),

              Text(
                l10n.tool_currency_converter_result,
                style: theme.textTheme.labelLarge?.copyWith(
                  color: Colors.white.withValues(alpha: 0.8),
                ),
              ),
              const SizedBox(height: 8),
              AnimatedValueText(
                key: const Key('conversion_result'),
                value: _isLoading
                    ? l10n.tool_currency_converter_loading
                    : (_result.isEmpty ? '-' : _result),
                style: theme.textTheme.displaySmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (_result.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    _toCurrency,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.white.withValues(alpha: 0.7),
                    ),
                  ),
                ),
              if (_ratesDate.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    _isOffline && _cacheTimestamp != null
                        ? l10n.tool_currency_converter_last_updated(
                            _formatTimestamp(_cacheTimestamp!),
                          )
                        : l10n.tool_currency_converter_last_updated(_ratesDate),
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: Colors.white.withValues(alpha: 0.6),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    return '${timestamp.year}-${timestamp.month.toString().padLeft(2, '0')}-${timestamp.day.toString().padLeft(2, '0')} '
        '${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}';
  }

  bool get _isCacheExpired =>
      _cacheTimestamp != null &&
      DateTime.now().difference(_cacheTimestamp!) > const Duration(hours: 24);

  /// Total body sections for stagger animation.
  static const _totalSections = 3;

  /// Body: input area with currency selectors.
  Widget _buildBody(BuildContext context, AppLocalizations l10n) {
    if (_errorMessage != null) {
      return _buildError(context, l10n);
    }

    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(DT.toolBodyPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ── Cache expiry warning ──
          if (_isCacheExpired)
            Padding(
              padding: const EdgeInsets.only(bottom: DT.toolSectionGap),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.amber.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.amber.withValues(alpha: 0.4)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.warning_amber, color: Colors.amber, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        l10n.tool_currency_converter_cache_expired,
                        style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: _loadRates,
                      child: Text(l10n.tool_currency_converter_refresh),
                    ),
                  ],
                ),
              ),
            ),

          // ── Section 0: Source currency + Amount ──
          StaggeredFadeIn(
            index: 0,
            totalItems: _totalSections,
            child: ToolSectionCard(
              label: l10n.tool_currency_converter_from,
              child: Column(
                children: [
                  _buildCurrencyDropdown(
                    key: const Key('from_currency_dropdown'),
                    value: _fromCurrency,
                    onChanged: (code) {
                      if (code == null) return;
                      setState(() => _fromCurrency = code);
                      _updateResult();
                    },
                  ),
                  const SizedBox(height: DT.toolSectionGap),
                  TextField(
                    key: const Key('amount_input'),
                    controller: _amountController,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: InputDecoration(
                      labelText: l10n.tool_currency_converter_amount,
                      border: const OutlineInputBorder(),
                      hintText: l10n.tool_currency_converter_amount_hint,
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: _toolColor,
                          width: 2,
                        ),
                      ),
                      floatingLabelStyle: const TextStyle(
                        color: _toolColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: DT.toolSectionGap),

          // ── Mode toggle ──
          Center(
            child: SegmentedButton<bool>(
              segments: [
                ButtonSegment(
                  value: false,
                  label: Text(l10n.tool_currency_converter_mode_single),
                  icon: const Icon(Icons.swap_vert, size: 18),
                ),
                ButtonSegment(
                  value: true,
                  label: Text(l10n.tool_currency_converter_mode_multi),
                  icon: const Icon(Icons.grid_view, size: 18),
                ),
              ],
              selected: {_isMultiMode},
              onSelectionChanged: (v) => setState(() => _isMultiMode = v.first),
            ),
          ),
          const SizedBox(height: DT.toolSectionGap),

          if (!_isMultiMode) ...[
            // ── Swap button ──
            Center(
              child: Semantics(
                button: true,
                label: l10n.tool_currency_converter_swap,
                child: BouncingButton(
                  key: const Key('swap_button'),
                  onTap: _swapCurrencies,
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: _toolColor.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.swap_vert,
                      color: _toolColor,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: DT.toolSectionGap),

            // ── Section 1: Target currency (single mode) ──
            StaggeredFadeIn(
              index: 1,
              totalItems: _totalSections,
              child: ToolSectionCard(
                label: l10n.tool_currency_converter_to,
                child: _buildCurrencyDropdown(
                  key: const Key('to_currency_dropdown'),
                  value: _toCurrency,
                  onChanged: (code) {
                    if (code == null) return;
                    setState(() => _toCurrency = code);
                    _updateResult();
                  },
                ),
              ),
            ),
          ] else ...[
            // ── Multi-currency results ──
            StaggeredFadeIn(
              index: 1,
              totalItems: _totalSections,
              child: ToolSectionCard(
                label: l10n.tool_currency_converter_multi_targets,
                child: _buildMultiCurrencyResults(l10n),
              ),
            ),
          ],
        ],
      ),
    );
  }

  /// Build a currency dropdown selector.
  Widget _buildCurrencyDropdown({
    Key? key,
    required String value,
    required ValueChanged<String?> onChanged,
  }) {
    final codes = _currencyCodes;
    // Ensure the selected value exists in the list
    final effectiveValue = codes.contains(value) ? value : codes.first;

    final dividerIdx = _favoriteDividerIndex;

    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        key: key,
        value: effectiveValue,
        isExpanded: true,
        items: [
          for (var i = 0; i < codes.length; i++) ...[
            if (i == dividerIdx && dividerIdx > 0)
              const DropdownMenuItem<String>(
                enabled: false,
                child: Divider(height: 1),
              ),
            DropdownMenuItem(
              value: codes[i],
              child: Text('${codes[i]} — ${_currencyNames[codes[i]] ?? codes[i]}'),
            ),
          ],
        ],
        onChanged: onChanged,
      ),
    );
  }

  /// Multi-currency result list.
  Widget _buildMultiCurrencyResults(AppLocalizations l10n) {
    final text = _amountController.text.trim();
    final amount = double.tryParse(text);
    final targets = _multiTargets
        .where((c) => c != _fromCurrency && _currencyCodes.contains(c))
        .toList()
      ..sort();

    // Target currency chips
    final allCodes = _currencyCodes
        .where((c) => c != _fromCurrency)
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Chip selector for targets
        Wrap(
          spacing: 6,
          runSpacing: 4,
          children: _favoriteCurrencies
              .where((c) => c != _fromCurrency && allCodes.contains(c))
              .followedBy(
                allCodes.where((c) =>
                    !_favoriteCurrencies.contains(c) &&
                    _multiTargets.contains(c)),
              )
              .toSet()
              .map((code) => FilterChip(
                    label: Text(code),
                    selected: _multiTargets.contains(code),
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          _multiTargets.add(code);
                        } else {
                          _multiTargets.remove(code);
                        }
                      });
                    },
                  ))
              .toList(),
        ),
        if (amount != null && targets.isNotEmpty) ...[
          const SizedBox(height: 12),
          ...targets.map((code) {
            try {
              final converted = CurrencyApi.convert(
                amount,
                _fromCurrency,
                code,
                _rates,
                _ratesBase,
              );
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '$code — ${_currencyNames[code] ?? code}',
                      style: const TextStyle(fontSize: 14),
                    ),
                    Text(
                      _formatNumber(converted),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              );
            } catch (_) {
              return const SizedBox.shrink();
            }
          }),
        ],
      ],
    );
  }

  /// Error state with retry button.
  Widget _buildError(BuildContext context, AppLocalizations l10n) {
    final message = _errorMessage == 'network_required'
        ? l10n.tool_currency_converter_network_required
        : l10n.tool_currency_converter_error;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(DT.toolBodyPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.cloud_off,
              size: 64,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            Text(
              message,
              key: const Key('error_message'),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              key: const Key('retry_button'),
              onPressed: _loadRates,
              icon: const Icon(Icons.refresh),
              label: Text(l10n.tool_currency_converter_retry),
            ),
          ],
        ),
      ),
    );
  }
}
