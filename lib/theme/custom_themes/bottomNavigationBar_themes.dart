import 'package:flutter/material.dart';
import 'package:healthhero/theme/custom_themes/color_theme.dart';

class TBottomNavigationBarTheme {
  TBottomNavigationBarTheme._();

  static const lightTheme = BottomNavigationBarThemeData(
    elevation: 0,
    backgroundColor: Colors.white,
    type: BottomNavigationBarType.fixed,
    selectedItemColor: lightPrimaryColor800,
    unselectedItemColor: Colors.grey,
    selectedIconTheme: IconThemeData(),
    unselectedIconTheme: IconThemeData(),
    selectedLabelStyle: TextStyle(fontSize: 10),
    unselectedLabelStyle: TextStyle(fontSize: 10),

  );

  static const darkTheme = BottomNavigationBarThemeData(
    elevation: 0,
    backgroundColor: Colors.black,
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.white,
    unselectedItemColor: Colors.grey,
    selectedIconTheme: IconThemeData(),
    unselectedIconTheme: IconThemeData(),
    selectedLabelStyle: TextStyle(fontSize: 10),
    unselectedLabelStyle: TextStyle(fontSize: 10),

  );

}