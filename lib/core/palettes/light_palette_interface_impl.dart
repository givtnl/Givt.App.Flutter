import '../interfaces/palette_interface.dart';
import 'package:flutter/material.dart';

class LightPaletteImpl implements IPalette {
  @override
  Color background = Color(0xFFFFFFFF);
  @override
  double logoSize = 25;
  @override
  Color btnText = Color(0xFFFFFFFF);
  @override
  Color btnActive = Color(0xFF7DBDA1);
  @override
  Color btnInactive = Color(0xFF808080);
}
