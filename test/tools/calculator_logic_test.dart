import 'package:flutter_test/flutter_test.dart';
import 'package:my_first_app/tools/calculator/calculator_logic.dart';

void main() {
  group('CalculatorLogic.evaluate', () {
    group('basic arithmetic', () {
      test('addition', () {
        expect(CalculatorLogic.evaluate('2+3'), equals(5.0));
      });

      test('subtraction', () {
        expect(CalculatorLogic.evaluate('10-4'), equals(6.0));
      });

      test('multiplication', () {
        expect(CalculatorLogic.evaluate('3*5'), equals(15.0));
      });

      test('division', () {
        expect(CalculatorLogic.evaluate('15/3'), equals(5.0));
      });
    });

    group('operator precedence', () {
      test('multiplication before addition: 2+3*4=14', () {
        expect(CalculatorLogic.evaluate('2+3*4'), equals(14.0));
      });

      test('multiplication before subtraction: 10-2*3=4', () {
        expect(CalculatorLogic.evaluate('10-2*3'), equals(4.0));
      });

      test('division before addition: 6/2+1=4', () {
        expect(CalculatorLogic.evaluate('6/2+1'), equals(4.0));
      });

      test('mixed operators: 2+3*4-6/2=11', () {
        expect(CalculatorLogic.evaluate('2+3*4-6/2'), equals(11.0));
      });
    });

    group('parentheses', () {
      test('parentheses override precedence: (2+3)*4=20', () {
        expect(CalculatorLogic.evaluate('(2+3)*4'), equals(20.0));
      });

      test('nested parentheses: ((2+3))*4=20', () {
        expect(CalculatorLogic.evaluate('((2+3))*4'), equals(20.0));
      });

      test('complex nested: (2+(3*4))-1=13', () {
        expect(CalculatorLogic.evaluate('(2+(3*4))-1'), equals(13.0));
      });

      test('parentheses in denominator: 10/(2+3)=2', () {
        expect(CalculatorLogic.evaluate('10/(2+3)'), equals(2.0));
      });
    });

    group('decimal numbers', () {
      test('decimal addition: 1.5+2.5=4', () {
        expect(CalculatorLogic.evaluate('1.5+2.5'), equals(4.0));
      });

      test('decimal multiplication: 0.1*0.2', () {
        expect(
          CalculatorLogic.evaluate('0.1*0.2'),
          closeTo(0.02, 1e-10),
        );
      });

      test('mixed integer and decimal: 3+0.14=3.14', () {
        expect(CalculatorLogic.evaluate('3+0.14'), equals(3.14));
      });
    });

    group('unary minus', () {
      test('negative number: -5', () {
        expect(CalculatorLogic.evaluate('-5'), equals(-5.0));
      });

      test('negative in expression: -5+3=-2', () {
        expect(CalculatorLogic.evaluate('-5+3'), equals(-2.0));
      });

      test('double negative: --5=5', () {
        expect(CalculatorLogic.evaluate('--5'), equals(5.0));
      });

      test('negative in parentheses: (-3)*2=-6', () {
        expect(CalculatorLogic.evaluate('(-3)*2'), equals(-6.0));
      });
    });

    group('whitespace handling', () {
      test('spaces between operators', () {
        expect(CalculatorLogic.evaluate('2 + 3'), equals(5.0));
      });

      test('spaces around parentheses', () {
        expect(CalculatorLogic.evaluate('( 2 + 3 ) * 4'), equals(20.0));
      });
    });

    group('single numbers', () {
      test('single integer', () {
        expect(CalculatorLogic.evaluate('42'), equals(42.0));
      });

      test('single decimal', () {
        expect(CalculatorLogic.evaluate('3.14'), equals(3.14));
      });
    });

    group('error cases', () {
      test('division by zero throws ArgumentError', () {
        expect(
          () => CalculatorLogic.evaluate('5/0'),
          throwsArgumentError,
        );
      });

      test('empty expression throws FormatException', () {
        expect(
          () => CalculatorLogic.evaluate(''),
          throwsFormatException,
        );
      });

      test('missing closing parenthesis throws FormatException', () {
        expect(
          () => CalculatorLogic.evaluate('(2+3'),
          throwsFormatException,
        );
      });

      test('invalid characters throw FormatException', () {
        expect(
          () => CalculatorLogic.evaluate('2+abc'),
          throwsFormatException,
        );
      });

      test('trailing operator throws FormatException', () {
        expect(
          () => CalculatorLogic.evaluate('2+'),
          throwsFormatException,
        );
      });
    });
  });

  group('CalculatorLogic.formatResult', () {
    test('integer result removes decimal point', () {
      expect(CalculatorLogic.formatResult(14.0), equals('14'));
    });

    test('decimal result preserves fraction', () {
      expect(CalculatorLogic.formatResult(3.14), equals('3.14'));
    });

    test('negative integer formats correctly', () {
      expect(CalculatorLogic.formatResult(-6.0), equals('-6'));
    });

    test('zero formats as "0"', () {
      expect(CalculatorLogic.formatResult(0.0), equals('0'));
    });

    test('trailing zeros are trimmed', () {
      expect(CalculatorLogic.formatResult(2.5), equals('2.5'));
    });
  });

  group('CalculationEntry', () {
    test('stores expression, result, and timestamp', () {
      final now = DateTime.now();
      final entry = CalculationEntry(
        expression: '2+3',
        result: '5',
        timestamp: now,
      );
      expect(entry.expression, equals('2+3'));
      expect(entry.result, equals('5'));
      expect(entry.timestamp, equals(now));
    });
  });
}
