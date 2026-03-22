import 'package:flutter/material.dart';
import 'package:my_first_app/l10n/app_localizations.dart';
import 'package:my_first_app/theme/design_tokens.dart';
import 'package:my_first_app/widgets/animated_value_text.dart';
import 'package:my_first_app/widgets/bouncing_button.dart';
import 'package:my_first_app/widgets/immersive_tool_scaffold.dart';
import 'package:my_first_app/widgets/staggered_fade_in.dart';
import 'package:my_first_app/widgets/tool_section_card.dart';
import 'units_data.dart';

final Color _toolColor =
    toolGradients['unit_converter']?.first ?? const Color(0xFF2196F3);

/// Full-screen page for the unit converter tool.
class UnitConverterPage extends StatefulWidget {
  const UnitConverterPage({super.key});

  @override
  State<UnitConverterPage> createState() => _UnitConverterPageState();
}

class _UnitConverterPageState extends State<UnitConverterPage> {
  late UnitCategory _selectedCategory;
  late UnitDefinition _sourceUnit;
  late UnitDefinition _targetUnit;

  final _inputController = TextEditingController();
  String _result = '';

  @override
  void initState() {
    super.initState();
    _selectedCategory = allCategories.first;
    _sourceUnit = _selectedCategory.units[0];
    _targetUnit = _selectedCategory.units[1];
    _inputController.addListener(_onInputChanged);
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  void _onInputChanged() {
    _updateResult();
  }

  void _updateResult() {
    final text = _inputController.text.trim();
    if (text.isEmpty) {
      setState(() => _result = '');
      return;
    }
    final value = double.tryParse(text);
    if (value == null) {
      final l10n = AppLocalizations.of(context)!;
      setState(() => _result = l10n.unitConverterInvalidNumber);
      return;
    }
    final converted = convert(_sourceUnit, _targetUnit, value);
    setState(() {
      _result = _formatNumber(converted);
    });
  }

  String _formatNumber(double value) {
    if (value == value.roundToDouble() && value.abs() < 1e15) {
      return value.toStringAsFixed(0);
    }
    var s = value.toStringAsFixed(10);
    if (s.contains('.')) {
      s = s.replaceAll(RegExp(r'0+$'), '');
      s = s.replaceAll(RegExp(r'\.$'), '');
    }
    return s;
  }

  void _selectCategory(UnitCategory category) {
    setState(() {
      _selectedCategory = category;
      _sourceUnit = category.units[0];
      _targetUnit =
          category.units.length > 1 ? category.units[1] : category.units[0];
    });
    _updateResult();
  }

  void _swapUnits() {
    setState(() {
      final temp = _sourceUnit;
      _sourceUnit = _targetUnit;
      _targetUnit = temp;
    });
    _updateResult();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return ImmersiveToolScaffold(
      toolId: 'unit_converter',
      toolColor: _toolColor,
      title: l10n.toolUnitConverter,
      heroTag: 'tool_hero_unit_converter',
      headerFlex: 2,
      bodyFlex: 3,
      headerChild: _buildResultDisplay(context),
      bodyChild: _buildInputArea(context),
    );
  }

  /// 結果顯示區（上方漸層 header）
  Widget _buildResultDisplay(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return SafeArea(
      top: true,
      bottom: false,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                l10n.unitConverterResult,
                style: theme.textTheme.labelLarge?.copyWith(
                  color: Colors.white.withValues(alpha: 0.8),
                ),
              ),
              const SizedBox(height: 8),
              AnimatedValueText(
                value: _result.isEmpty ? '-' : _result,
                style: theme.textTheme.displaySmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (_result.isNotEmpty && _result != l10n.unitConverterInvalidNumber)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    _targetUnit.name,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.white.withValues(alpha: 0.7),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  /// Body 區塊總數（類別 + 來源 + 目標）
  static const _totalSections = 3;

  /// 輸入欄位與選擇器（下方操作區）
  Widget _buildInputArea(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(DT.toolBodyPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ── Section 0：類別選擇 ──
          StaggeredFadeIn(
            index: 0,
            totalItems: _totalSections,
            child: ToolSectionCard(
              label: l10n.unitConverterCategory,
              child: _buildDropdown<String>(
                value: _selectedCategory.id,
                items: allCategories
                    .map(
                      (c) =>
                          DropdownMenuItem(value: c.id, child: Text(c.name)),
                    )
                    .toList(),
                onChanged: (id) {
                  if (id == null) return;
                  final cat = allCategories.firstWhere((c) => c.id == id);
                  _selectCategory(cat);
                },
              ),
            ),
          ),
          const SizedBox(height: DT.toolSectionGap),

          // ── Section 1：來源單位 + 輸入數值 ──
          StaggeredFadeIn(
            index: 1,
            totalItems: _totalSections,
            child: ToolSectionCard(
              label: l10n.unitConverterSource,
              child: Column(
                children: [
                  _buildDropdown<String>(
                    value: _sourceUnit.id,
                    items: _selectedCategory.units
                        .map(
                          (u) => DropdownMenuItem(
                            value: u.id,
                            child: Text(u.name),
                          ),
                        )
                        .toList(),
                    onChanged: (id) {
                      if (id == null) return;
                      setState(() {
                        _sourceUnit = _selectedCategory.units.firstWhere(
                          (u) => u.id == id,
                        );
                      });
                      _updateResult();
                    },
                  ),
                  const SizedBox(height: DT.toolSectionGap),
                  TextField(
                    controller: _inputController,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                      signed: true,
                    ),
                    decoration: InputDecoration(
                      labelText: l10n.unitConverterInputValue,
                      border: const OutlineInputBorder(),
                      hintText: l10n.unitConverterInputHint,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: DT.brandPrimary,
                          width: 2,
                        ),
                      ),
                      floatingLabelStyle: TextStyle(
                        color: DT.brandPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: DT.toolSectionGap),

          // ── 交換按鈕 ──
          Center(
            child: BouncingButton(
              onTap: _swapUnits,
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: DT.brandPrimary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.swap_vert,
                  color: DT.brandPrimary,
                ),
              ),
            ),
          ),
          const SizedBox(height: DT.toolSectionGap),

          // ── Section 2：目標單位 ──
          StaggeredFadeIn(
            index: 2,
            totalItems: _totalSections,
            child: ToolSectionCard(
              label: l10n.unitConverterTarget,
              child: _buildDropdown<String>(
                value: _targetUnit.id,
                items: _selectedCategory.units
                    .map(
                      (u) => DropdownMenuItem(
                        value: u.id,
                        child: Text(u.name),
                      ),
                    )
                    .toList(),
                onChanged: (id) {
                  if (id == null) return;
                  setState(() {
                    _targetUnit = _selectedCategory.units.firstWhere(
                      (u) => u.id == id,
                    );
                  });
                  _updateResult();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds a dropdown with [InputDecorator] wrapping a [DropdownButton].
  Widget _buildDropdown<T>({
    required T value,
    required List<DropdownMenuItem<T>> items,
    required ValueChanged<T?> onChanged,
  }) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<T>(
        value: value,
        isExpanded: true,
        items: items,
        onChanged: onChanged,
      ),
    );
  }
}
