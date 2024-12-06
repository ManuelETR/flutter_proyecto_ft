import 'package:flutter/material.dart';

const Color customColor = Color(0xFFb40506);
const colorList = <Color>[
  customColor,
  Color(0xFF969594),
  Color(0xFF2e2423),
  Color(0xFF957c73),
  Color(0xFFcb9f9c),
  Color(0xFF636c66)
];

class AppTheme {
  final int selectedColor;

  AppTheme({this.selectedColor = 0})
      : assert(selectedColor >= 0 && selectedColor <= colorList.length - 1,
            'Colors must be between 0 and ${colorList.length - 1}');

  ThemeData getTheme() {
    final Color selected = colorList[selectedColor];

    return ThemeData(
      primaryColor: selected,
      colorScheme: ColorScheme.fromSeed(
        seedColor: selected,
        primary: selected,
        secondary: colorList[1], // Puedes elegir otro color o usar un patrón.
        tertiary: colorList[2], // Personaliza esto según necesites.
      ),
    );
  }
}