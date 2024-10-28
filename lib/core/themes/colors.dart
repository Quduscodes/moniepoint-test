import 'package:flutter/material.dart';

class ColorConst {
  // This class is not meant to be instantiated or extended; this constructor
  // prevents instantiation and extension.
  ColorConst._();

  static const Color white = Color(0xffFFFFFF);
  static const Color primary = Color.fromRGBO(249, 140, 18, 1.0);
  static const Color black = Color(0xFF000000);
  static const Color black1 = Color(0xFF232220);
  static Color grey = const Color.fromRGBO(147, 132, 107, 1.0);
  static Color black2 = const Color.fromRGBO(97, 97, 97, 1.0);
  static Color black3 = const Color.fromRGBO(191, 191, 191, 1.0);

  static Color getShade(Color color, {bool darker = false, double value = .1}) {
    assert(value >= 0 && value <= 1);

    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness(
        (darker ? (hsl.lightness - value) : (hsl.lightness + value))
            .clamp(0.0, 1.0));

    return hslDark.toColor();
  }
}
