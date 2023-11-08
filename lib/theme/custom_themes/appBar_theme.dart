import 'package:flutter/material.dart';
import 'color_theme.dart';

class TAppBarTheme {

  static const lightTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: lightAppBarColor,
    surfaceTintColor: lightPrimaryColor500,
    iconTheme: IconThemeData(color: lightAppBarTextColor, size: 24),
    actionsIconTheme: IconThemeData(color: lightAppBarTextColor, size: 24),
    titleTextStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: lightAppBarTextColor),
  );

  static const darkTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.black,
    surfaceTintColor: Colors.black,
    iconTheme: IconThemeData(color: Colors.white, size: 24),
    actionsIconTheme: IconThemeData(color: Colors.white, size: 24),
    titleTextStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.white),
  );

}