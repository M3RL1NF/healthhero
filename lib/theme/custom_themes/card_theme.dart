import 'package:flutter/material.dart';
import 'package:healthhero/theme/custom_themes/color_theme.dart';

const EdgeInsets buttonPadding =
    EdgeInsets.symmetric(vertical: 10, horizontal: 18);

class TCardTheme {
  TCardTheme._();

  static const lightTheme = CardTheme(
    elevation: 0,
    margin: EdgeInsets.all(10),
    color: Colors.white,
  );

  static const darkTheme = CardTheme(
    elevation: 0,
    margin: EdgeInsets.all(10),
    color: Colors.black,
  );
}
