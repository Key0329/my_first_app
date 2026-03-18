/// Calculator expression parser with proper operator precedence.
///
/// Supports +, -, *, /, decimal numbers, and parentheses.
/// Uses recursive descent parsing:
///   expression = term (('+' | '-') term)*
///   term       = factor (('*' | '/') factor)*
///   factor     = ['-'] (NUMBER | '(' expression ')')
library;

class CalculatorLogic {
  /// Evaluates a mathematical expression string and returns the result.
  ///
  /// Throws [FormatException] for invalid expressions.
  /// Throws [ArgumentError] for division by zero.
  static double evaluate(String expression) {
    final parser = _Parser(expression);
    final result = parser.parseExpression();
    parser.skipWhitespace();
    if (!parser.isAtEnd) {
      throw FormatException(
        'Unexpected character: "${parser.currentChar}"',
        expression,
        parser.position,
      );
    }
    return result;
  }

  /// Formats a double result for display — removes trailing ".0" for integers.
  static String formatResult(double value) {
    if (value == value.roundToDouble() && !value.isInfinite && !value.isNaN) {
      return value.toInt().toString();
    }
    // Show up to 10 significant decimal digits, trim trailing zeros
    var s = value.toStringAsFixed(10);
    if (s.contains('.')) {
      s = s.replaceAll(RegExp(r'0+$'), '');
      s = s.replaceAll(RegExp(r'\.$'), '');
    }
    return s;
  }
}

class _Parser {
  final String _source;
  int _position = 0;

  _Parser(this._source);

  int get position => _position;
  bool get isAtEnd => _position >= _source.length;
  String get currentChar => _source[_position];

  void skipWhitespace() {
    while (!isAtEnd && _source[_position] == ' ') {
      _position++;
    }
  }

  /// expression = term (('+' | '-') term)*
  double parseExpression() {
    skipWhitespace();
    var result = _parseTerm();
    skipWhitespace();
    while (!isAtEnd && (currentChar == '+' || currentChar == '-')) {
      final op = currentChar;
      _position++;
      final right = _parseTerm();
      if (op == '+') {
        result += right;
      } else {
        result -= right;
      }
      skipWhitespace();
    }
    return result;
  }

  /// term = factor (('*' | '/') factor)*
  double _parseTerm() {
    skipWhitespace();
    var result = _parseFactor();
    skipWhitespace();
    while (!isAtEnd && (currentChar == '*' || currentChar == '/')) {
      final op = currentChar;
      _position++;
      final right = _parseFactor();
      if (op == '*') {
        result *= right;
      } else {
        if (right == 0) {
          throw ArgumentError('Division by zero');
        }
        result /= right;
      }
      skipWhitespace();
    }
    return result;
  }

  /// factor = ['-'] (NUMBER | '(' expression ')')
  double _parseFactor() {
    skipWhitespace();
    if (isAtEnd) {
      throw FormatException('Unexpected end of expression', _source, _position);
    }

    // Handle unary minus
    if (currentChar == '-') {
      _position++;
      return -_parseFactor();
    }

    // Handle unary plus
    if (currentChar == '+') {
      _position++;
      return _parseFactor();
    }

    // Parenthesised sub-expression
    if (currentChar == '(') {
      _position++;
      final result = parseExpression();
      skipWhitespace();
      if (isAtEnd || currentChar != ')') {
        throw FormatException(
          'Missing closing parenthesis',
          _source,
          _position,
        );
      }
      _position++; // consume ')'
      return result;
    }

    // Number (integer or decimal)
    return _parseNumber();
  }

  double _parseNumber() {
    skipWhitespace();
    final start = _position;
    while (!isAtEnd && (_isDigit(currentChar) || currentChar == '.')) {
      _position++;
    }
    if (_position == start) {
      throw FormatException(
        'Expected a number',
        _source,
        _position,
      );
    }
    final numberStr = _source.substring(start, _position);
    final value = double.tryParse(numberStr);
    if (value == null) {
      throw FormatException('Invalid number: "$numberStr"', _source, start);
    }
    return value;
  }

  bool _isDigit(String ch) => ch.codeUnitAt(0) >= 48 && ch.codeUnitAt(0) <= 57;
}

/// Represents a single calculation history entry.
class CalculationEntry {
  final String expression;
  final String result;
  final DateTime timestamp;

  const CalculationEntry({
    required this.expression,
    required this.result,
    required this.timestamp,
  });
}
