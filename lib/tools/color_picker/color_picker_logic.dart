import 'dart:math';

import 'package:flutter/painting.dart';

/// Converts a 0.0–1.0 channel value to an 8-bit integer (0–255).
int to8bit(double v) => (v * 255.0).round().clamp(0, 255);

/// Formats a [Color] as an uppercase HEX string: '#RRGGBB'.
String colorToHex(Color color) {
  final r = to8bit(color.r);
  final g = to8bit(color.g);
  final b = to8bit(color.b);
  return '#${r.toRadixString(16).padLeft(2, '0')}'
      '${g.toRadixString(16).padLeft(2, '0')}'
      '${b.toRadixString(16).padLeft(2, '0')}'
      .toUpperCase();
}

/// Formats a [Color] as an RGB string: 'R, G, B'.
String colorToRgbString(Color color) {
  final r = to8bit(color.r);
  final g = to8bit(color.g);
  final b = to8bit(color.b);
  return '$r, $g, $b';
}

/// Parses a HEX color string (with or without leading '#') to a [Color].
///
/// Accepts 6-character hex strings like 'FF5733' or '#FF5733'.
/// Returns `null` for invalid input.
Color? hexToColor(String hex) {
  String cleaned = hex.trim();
  if (cleaned.startsWith('#')) {
    cleaned = cleaned.substring(1);
  }
  if (cleaned.length != 6) return null;

  final value = int.tryParse(cleaned, radix: 16);
  if (value == null) return null;

  final r = (value >> 16) & 0xFF;
  final g = (value >> 8) & 0xFF;
  final b = value & 0xFF;
  return Color.fromARGB(255, r, g, b);
}

/// Converts RGB (each 0–255) to HSL.
///
/// Returns a map with:
/// - 'h': hue in degrees (0–360)
/// - 's': saturation (0.0–1.0)
/// - 'l': lightness (0.0–1.0)
Map<String, double> rgbToHsl(int r, int g, int b) {
  final rn = r / 255.0;
  final gn = g / 255.0;
  final bn = b / 255.0;

  final cMax = [rn, gn, bn].reduce(max);
  final cMin = [rn, gn, bn].reduce(min);
  final delta = cMax - cMin;

  // Lightness
  final l = (cMax + cMin) / 2.0;

  // Saturation
  double s;
  if (delta == 0) {
    s = 0.0;
  } else {
    s = delta / (1.0 - (2.0 * l - 1.0).abs());
  }

  // Hue
  double h;
  if (delta == 0) {
    h = 0.0;
  } else if (cMax == rn) {
    h = 60.0 * (((gn - bn) / delta) % 6);
  } else if (cMax == gn) {
    h = 60.0 * (((bn - rn) / delta) + 2);
  } else {
    h = 60.0 * (((rn - gn) / delta) + 4);
  }

  if (h < 0) h += 360.0;

  return {'h': h, 's': s, 'l': l};
}

/// Converts HSL values back to a [Color].
///
/// - [h]: hue in degrees (0–360)
/// - [s]: saturation (0.0–1.0)
/// - [l]: lightness (0.0–1.0)
Color hslToColor(double h, double s, double l) {
  final c = (1.0 - (2.0 * l - 1.0).abs()) * s;
  final x = c * (1.0 - ((h / 60.0) % 2 - 1.0).abs());
  final m = l - c / 2.0;

  double r1, g1, b1;

  if (h < 60) {
    r1 = c;
    g1 = x;
    b1 = 0;
  } else if (h < 120) {
    r1 = x;
    g1 = c;
    b1 = 0;
  } else if (h < 180) {
    r1 = 0;
    g1 = c;
    b1 = x;
  } else if (h < 240) {
    r1 = 0;
    g1 = x;
    b1 = c;
  } else if (h < 300) {
    r1 = x;
    g1 = 0;
    b1 = c;
  } else {
    r1 = c;
    g1 = 0;
    b1 = x;
  }

  final r = ((r1 + m) * 255.0).round().clamp(0, 255);
  final g = ((g1 + m) * 255.0).round().clamp(0, 255);
  final b = ((b1 + m) * 255.0).round().clamp(0, 255);

  return Color.fromARGB(255, r, g, b);
}
