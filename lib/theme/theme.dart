import 'package:flutter/material.dart';

import 'custom_themes/appBar_theme.dart';
import 'custom_themes/bottomNavigationBar_themes.dart';
import 'custom_themes/text_theme.dart';
import 'custom_themes/button_theme.dart';

class TAppTheme {
  TAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: TAppBarTheme.lightTheme,
    bottomNavigationBarTheme: TBottomNavigationBarTheme.lightTheme,
    textTheme: TTextTheme.lightTheme,
    elevatedButtonTheme: TElevatedButtonTheme.lightTheme,
    outlinedButtonTheme: TOutlinedButtonTheme.lightTheme,
    textButtonTheme:  TTextButtonTheme.lightTheme,
    iconButtonTheme: TIconButtonTheme.lightTheme,

  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    textTheme: TTextTheme.darkTheme,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: TAppBarTheme.darkTheme,
    bottomNavigationBarTheme: TBottomNavigationBarTheme.darkTheme,
    elevatedButtonTheme: TElevatedButtonTheme.darkTheme,
    outlinedButtonTheme: TOutlinedButtonTheme.darkTheme,
    textButtonTheme:  TTextButtonTheme.darkTheme,
    iconButtonTheme: TIconButtonTheme.darkTheme,
  );

}