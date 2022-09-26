import 'package:flutter/material.dart';

class Palette {
  static Color darkBlue = HexColor('355070');
  static Color deepPurple = HexColor('6D597A');
  static Color murkyPink = HexColor('B56576');
  static Color brightPink = HexColor('E56B6F');
  static Color lightOrange = HexColor('EAAC8B');
  static Color background = HexColor('E5E5E5');
  static Color white = HexColor('FFFFFF');
  static Color greyBlue = HexColor('AEB9C6');
  static Color mintGreen = HexColor('7DBDA1');
  static Color lightGrey = HexColor('F4F4F4');
  static Color darkGrey = HexColor('79808B');
  static Color error = Colors.red;
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
