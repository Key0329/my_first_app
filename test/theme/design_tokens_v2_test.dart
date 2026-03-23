import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_first_app/theme/design_tokens.dart';

void main() {
  group('Typography Scale', () {
    test('displayLarge returns correct size and weight', () {
      final style = DT.displayLarge(Brightness.light);
      expect(style.fontSize, 36);
      expect(style.fontWeight, FontWeight.w700);
      expect(style.color, DT.lightTitle);
    });

    test('titleMedium returns correct size and weight', () {
      final style = DT.titleMedium(Brightness.light);
      expect(style.fontSize, 16);
      expect(style.fontWeight, FontWeight.w500);
      expect(style.color, DT.lightTitle);
    });

    test('bodyMedium adapts to dark mode', () {
      final style = DT.bodyMedium(Brightness.dark);
      expect(style.fontSize, 14);
      expect(style.fontWeight, FontWeight.w400);
      expect(style.color, DT.darkTitle);
    });

    test('bodySmall uses subtitle color', () {
      expect(DT.bodySmall(Brightness.light).color, DT.lightSubtitle);
      expect(DT.bodySmall(Brightness.dark).color, DT.darkSubtitle);
    });

    test('labelSmall uses subtitle color', () {
      expect(DT.labelSmall(Brightness.light).color, DT.lightSubtitle);
      expect(DT.labelSmall(Brightness.dark).color, DT.darkSubtitle);
    });

    test('all 12 levels exist', () {
      for (final b in Brightness.values) {
        expect(DT.displayLarge(b).fontSize, 36);
        expect(DT.displayMedium(b).fontSize, 26);
        expect(DT.headlineLarge(b).fontSize, 24);
        expect(DT.headlineMedium(b).fontSize, 20);
        expect(DT.titleLarge(b).fontSize, 18);
        expect(DT.titleMedium(b).fontSize, 16);
        expect(DT.bodyLarge(b).fontSize, 16);
        expect(DT.bodyMedium(b).fontSize, 14);
        expect(DT.bodySmall(b).fontSize, 12);
        expect(DT.labelLarge(b).fontSize, 14);
        expect(DT.labelMedium(b).fontSize, 12);
        expect(DT.labelSmall(b).fontSize, 10);
      }
    });
  });

  group('Shadow / Elevation Token', () {
    test('shadowNone returns empty list', () {
      expect(DT.shadowNone(Brightness.light), isEmpty);
      expect(DT.shadowNone(Brightness.dark), isEmpty);
    });

    test('shadowSm returns shadow in light mode', () {
      final shadows = DT.shadowSm(Brightness.light);
      expect(shadows, hasLength(1));
      expect(shadows[0].blurRadius, 4);
      expect(shadows[0].offset, const Offset(0, 1));
    });

    test('shadowMd returns shadow in light mode', () {
      final shadows = DT.shadowMd(Brightness.light);
      expect(shadows, hasLength(1));
      expect(shadows[0].blurRadius, 8);
      expect(shadows[0].offset, const Offset(0, 2));
    });

    test('shadowLg returns shadow in light mode', () {
      final shadows = DT.shadowLg(Brightness.light);
      expect(shadows, hasLength(1));
      expect(shadows[0].blurRadius, 16);
      expect(shadows[0].offset, const Offset(0, 4));
    });

    test('all shadows return empty in dark mode', () {
      expect(DT.shadowSm(Brightness.dark), isEmpty);
      expect(DT.shadowMd(Brightness.dark), isEmpty);
      expect(DT.shadowLg(Brightness.dark), isEmpty);
    });
  });

  group('Semantic Color Token', () {
    test('success color in light mode', () {
      expect(DT.success(Brightness.light), const Color(0xFF0D8F63));
    });

    test('error color in dark mode', () {
      expect(DT.error(Brightness.dark), const Color(0xFFF87171));
    });

    test('warning adapts to brightness', () {
      expect(DT.warning(Brightness.light), const Color(0xFFF59E0B));
      expect(DT.warning(Brightness.dark), const Color(0xFFFBBF24));
    });

    test('info adapts to brightness', () {
      expect(DT.info(Brightness.light), const Color(0xFF3B82F6));
      expect(DT.info(Brightness.dark), const Color(0xFF60A5FA));
    });
  });

  group('Animation Curve Token', () {
    test('curveStandard is easeInOut', () {
      expect(DT.curveStandard, Curves.easeInOut);
    });

    test('curveDecelerate is easeOut', () {
      expect(DT.curveDecelerate, Curves.easeOut);
    });

    test('curveAccelerate is easeIn', () {
      expect(DT.curveAccelerate, Curves.easeIn);
    });

    test('curveSpring is elasticOut', () {
      expect(DT.curveSpring, Curves.elasticOut);
    });
  });

  group('Iconography size tokens', () {
    test('icon sizes are correct', () {
      expect(DT.iconXs, 16.0);
      expect(DT.iconSm, 20.0);
      expect(DT.iconMd, 24.0);
      expect(DT.iconLg, 32.0);
      expect(DT.iconXl, 48.0);
    });

    test('iconSize alias matches iconMd', () {
      expect(DT.iconSize, DT.iconMd);
    });

    test('searchIconSize alias matches iconSm', () {
      expect(DT.searchIconSize, DT.iconSm);
    });
  });
}
