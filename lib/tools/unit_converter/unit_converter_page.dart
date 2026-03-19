import 'package:flutter/material.dart';
import 'package:my_first_app/widgets/immersive_tool_scaffold.dart';
import 'units_data.dart';

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
      setState(() => _result = '請輸入有效數字');
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
    return ImmersiveToolScaffold(
      toolColor: const Color(0xFF2196F3),
      title: '單位換算',
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
                '結果',
                style: theme.textTheme.labelLarge?.copyWith(
                  color: Colors.white.withValues(alpha: 0.8),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                _result.isEmpty ? '-' : _result,
                style: theme.textTheme.displaySmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              if (_result.isNotEmpty && _result != '請輸入有效數字')
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

  /// 輸入欄位與選擇器（下方操作區）
  Widget _buildInputArea(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Category selector
          _buildDropdown<String>(
            label: '類別',
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
          const SizedBox(height: 24),

          // Source unit dropdown
          _buildDropdown<String>(
            label: '來源單位',
            value: _sourceUnit.id,
            items: _selectedCategory.units
                .map(
                  (u) =>
                      DropdownMenuItem(value: u.id, child: Text(u.name)),
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
          const SizedBox(height: 16),

          // Input field
          TextField(
            controller: _inputController,
            keyboardType: const TextInputType.numberWithOptions(
              decimal: true,
              signed: true,
            ),
            decoration: const InputDecoration(
              labelText: '輸入數值',
              border: OutlineInputBorder(),
              hintText: '請輸入數字',
            ),
          ),
          const SizedBox(height: 16),

          // Swap button
          Center(
            child: IconButton.filled(
              onPressed: _swapUnits,
              icon: const Icon(Icons.swap_vert),
              tooltip: '交換單位',
            ),
          ),
          const SizedBox(height: 16),

          // Target unit dropdown
          _buildDropdown<String>(
            label: '目標單位',
            value: _targetUnit.id,
            items: _selectedCategory.units
                .map(
                  (u) =>
                      DropdownMenuItem(value: u.id, child: Text(u.name)),
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
        ],
      ),
    );
  }

  /// Builds a dropdown with [InputDecorator] wrapping a [DropdownButton]
  /// to avoid the deprecated `DropdownButtonFormField.value` parameter.
  Widget _buildDropdown<T>({
    required String label,
    required T value,
    required List<DropdownMenuItem<T>> items,
    required ValueChanged<T?> onChanged,
  }) {
    return InputDecorator(
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 4,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: value,
          isExpanded: true,
          items: items,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
