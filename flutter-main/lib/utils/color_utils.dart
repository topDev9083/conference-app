import 'package:flutter/material.dart';

class ColorUtils {
  ColorUtils._();

  static int getIntFromHex(final String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) {
      buffer.write('ff');
    }
    buffer.write(hexString.replaceFirst('#', ''));
    return int.parse(buffer.toString(), radix: 16);
  }

  static Color fromHex(final String hex) {
    return Color(getIntFromHex(hex));
  }

  static String toHex(final Color color) {
    return '#${color.value.toRadixString(16)}';
  }

  static Color darken(final Color color, [final double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

    return hslDark.toColor();
  }

  static Color lighten(final Color color, [final double amount = .1]) {
    assert(amount >= 0 && amount <= 1);
    return Color.alphaBlend(color.withOpacity(1- amount),Colors.white);
  }
}
