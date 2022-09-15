import 'package:flutter/material.dart';

class Palette {
  static Color darkBlue = HexColor('355070');
  static Color deepPurple = HexColor('6D597A');
  static Color murkyPink = HexColor('B56576');
  static Color brightPink = HexColor('E56B6F');
  static Color lightOrange = HexColor('EAAC8B');
  static Color background = HexColor('F8F8F8');
  static Color white = HexColor('FFFFFF');
  static Color greyBlue = HexColor('AEB9C6');
  static Color greyBlueTone = Color(0x99AEB9C6);
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
