import 'package:flutter/material.dart';

class Palette {
  static Color hexToColor(String hexString, {String alphaChannel = 'FF'}) {
    return Color(int.parse(hexString.replaceFirst('#', '0x$alphaChannel')));
  }

  Palette._();

  static Map<int, Color> blue = <int, Color>{
    50: hexToColor('#006290'),
    100: hexToColor('#273746'),
    200: hexToColor('#00354F'),
    300: hexToColor('#17202A'),
  };

  static Map<int, Color> orange = <int, Color>{50: hexToColor('#D68910')};

  static Map<int, Color> grey = <int, Color>{50: hexToColor('#ABB2B9')};
}
