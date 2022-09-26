import '../palettes/light_palette_interface_impl.dart';
import '../palettes/dark_palette_interface_impl.dart';
import '../interfaces/palette_interface.dart';

class AppTheme {
  static IPalette get theme {
    return LightPaletteImpl();
  }
}
