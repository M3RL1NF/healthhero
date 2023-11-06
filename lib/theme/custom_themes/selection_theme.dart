import 'package:flutter/material.dart';

class TCheckboxTheme {
  TCheckboxTheme._(); // Private constructor

  static final lightTheme = CheckboxThemeData(
    fillColor: _lightFillColor,
    checkColor: MaterialStateProperty.all(Colors.white),
    overlayColor: MaterialStateProperty.all(Colors.grey),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
    ),
  );

  static final darkTheme = CheckboxThemeData(
    fillColor: _darkFillColor,
    checkColor: MaterialStateProperty.all(Colors.white),
    overlayColor: MaterialStateProperty.all(Colors.grey),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
    ),
  );

  static MaterialStateProperty<Color> get _lightFillColor {
    return MaterialStateProperty.resolveWith((Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) {
        return Colors.grey.shade200; // Disabled color for light theme
      }
      return states.contains(MaterialState.selected)
          ? Colors.blue // Checked color for light theme
          : Colors.transparent; // Unchecked color for light theme
    });
  }

  static MaterialStateProperty<Color> get _darkFillColor {
    return MaterialStateProperty.resolveWith((Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) {
        return Colors.grey.shade800; // Disabled color for dark theme
      }
      return states.contains(MaterialState.selected)
          ? Colors.blue // Checked color for dark theme
          : Colors.black; // Unchecked color for dark theme
    });
  }
}