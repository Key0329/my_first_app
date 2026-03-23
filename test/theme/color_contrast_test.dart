import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_first_app/theme/design_tokens.dart';

/// Calculate relative luminance per WCAG 2.1
double _relativeLuminance(Color color) {
  double linearize(double c) {
    return c <= 0.03928
        ? c / 12.92
        : math.pow((c + 0.055) / 1.055, 2.4).toDouble();
  }

  final r = linearize(color.r);
  final g = linearize(color.g);
  final b = linearize(color.b);
  return 0.2126 * r + 0.7152 * g + 0.0722 * b;
}

/// Contrast ratio per WCAG 2.1
double _contrastRatio(Color foreground, Color background) {
  final l1 = _relativeLuminance(foreground);
  final l2 = _relativeLuminance(background);
  final lighter = l1 > l2 ? l1 : l2;
  final darker = l1 > l2 ? l2 : l1;
  return (lighter + 0.05) / (darker + 0.05);
}

void _expectContrast(
  String name,
  Color foreground,
  Color background, {
  double minRatio = 4.5,
}) {
  final ratio = _contrastRatio(foreground, background);
  expect(
    ratio,
    greaterThanOrEqualTo(minRatio),
    reason:
        '$name: contrast ratio $ratio < $minRatio '
        '(fg: #${foreground.value.toRadixString(16)}, '
        'bg: #${background.value.toRadixString(16)})',
  );
}

void main() {
  group('WCAG 2.1 AA Color Contrast — Light Mode', () {
    const bg = DT.lightPageBg;
    const cardBg = DT.lightCardBg;

    test('title on page background >= 4.5:1', () {
      _expectContrast('lightTitle on lightPageBg', DT.lightTitle, bg);
    });

    test('subtitle on page background >= 4.5:1', () {
      _expectContrast('lightSubtitle on lightPageBg', DT.lightSubtitle, bg);
    });

    test('title on card background >= 4.5:1', () {
      _expectContrast('lightTitle on lightCardBg', DT.lightTitle, cardBg);
    });

    test('subtitle on card background >= 4.5:1', () {
      _expectContrast('lightSubtitle on lightCardBg', DT.lightSubtitle, cardBg);
    });

    test('nav inactive on nav background >= 4.5:1', () {
      _expectContrast(
        'lightNavInactive on lightNavBg',
        DT.lightNavInactive,
        DT.lightNavBg,
      );
    });

    test('tag active text on tag active bg >= 4.5:1', () {
      _expectContrast(
        'lightTagActiveText on lightTagActiveBg',
        DT.lightTagActiveText,
        DT.lightTagActiveBg,
      );
    });

    test('tag inactive text on tag inactive bg >= 3:1 (large text)', () {
      _expectContrast(
        'lightTagInactiveText on lightTagInactiveBg',
        DT.lightTagInactiveText,
        DT.lightTagInactiveBg,
        minRatio: 3.0,
      );
    });

    test('semantic success on card bg >= 3:1', () {
      _expectContrast(
        'lightSuccess on lightCardBg',
        DT.lightSuccess,
        cardBg,
        minRatio: 3.0,
      );
    });

    test('semantic error on card bg >= 3:1', () {
      _expectContrast(
        'lightError on lightCardBg',
        DT.lightError,
        cardBg,
        minRatio: 3.0,
      );
    });
  });

  group('WCAG 2.1 AA Color Contrast — Dark Mode', () {
    const bg = DT.darkPageBg;
    const cardBg = DT.darkCardBg;

    test('title on page background >= 4.5:1', () {
      _expectContrast('darkTitle on darkPageBg', DT.darkTitle, bg);
    });

    test('subtitle on page background >= 4.5:1', () {
      _expectContrast('darkSubtitle on darkPageBg', DT.darkSubtitle, bg);
    });

    test('title on card background >= 4.5:1', () {
      _expectContrast('darkTitle on darkCardBg', DT.darkTitle, cardBg);
    });

    test('subtitle on card background >= 4.5:1', () {
      _expectContrast('darkSubtitle on darkCardBg', DT.darkSubtitle, cardBg);
    });

    test('nav inactive on nav background >= 4.5:1', () {
      _expectContrast(
        'darkNavInactive on darkNavBg',
        DT.darkNavInactive,
        DT.darkNavBg,
      );
    });

    test('tag active text on tag active bg >= 4.5:1', () {
      _expectContrast(
        'darkTagActiveText on darkTagActiveBg',
        DT.darkTagActiveText,
        DT.darkTagActiveBg,
      );
    });

    test('tag inactive text on tag inactive bg >= 3:1 (large text)', () {
      _expectContrast(
        'darkTagInactiveText on darkTagInactiveBg',
        DT.darkTagInactiveText,
        DT.darkTagInactiveBg,
        minRatio: 3.0,
      );
    });

    test('semantic success on card bg >= 3:1', () {
      _expectContrast(
        'darkSuccess on darkCardBg',
        DT.darkSuccess,
        cardBg,
        minRatio: 3.0,
      );
    });

    test('semantic error on card bg >= 3:1', () {
      _expectContrast(
        'darkError on darkCardBg',
        DT.darkError,
        cardBg,
        minRatio: 3.0,
      );
    });
  });
}
