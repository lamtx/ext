import 'dart:ui';

extension BrightnessExt on Brightness {
  Brightness get reversed =>
      this == Brightness.light ? Brightness.dark : Brightness.light;
}
