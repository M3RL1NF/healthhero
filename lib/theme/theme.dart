import 'package:flutter/material.dart';
import 'custom_themes/color_theme.dart';

import 'custom_themes/appBar_theme.dart';
import 'custom_themes/bottomNavigationBar_themes.dart';
import 'custom_themes/text_theme.dart';
import 'custom_themes/button_theme.dart';
import 'custom_themes/input_theme.dart';
import 'custom_themes/selection_theme.dart';
import 'custom_themes/card_theme.dart';

class TAppTheme {
  TAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: lightScaffoldColor,
    appBarTheme: TAppBarTheme.lightTheme,
    bottomNavigationBarTheme: TBottomNavigationBarTheme.lightTheme,
    textTheme: TTextTheme.lightTheme,
    elevatedButtonTheme: TElevatedButtonTheme.lightTheme,
    outlinedButtonTheme: TOutlinedButtonTheme.lightTheme,
    textButtonTheme:  TTextButtonTheme.lightTheme,
    iconButtonTheme: TIconButtonTheme.lightTheme,
    inputDecorationTheme: TInputDecorationTheme.lightTheme,
    textSelectionTheme: TTextSelectionTheme.lightTheme,
    checkboxTheme: TCheckboxTheme.lightTheme,
    cardTheme: TCardTheme.lightTheme,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    textTheme: TTextTheme.darkTheme,
    scaffoldBackgroundColor: Colors.black,
    primaryColor: Colors.blue,
    appBarTheme: TAppBarTheme.darkTheme,
    bottomNavigationBarTheme: TBottomNavigationBarTheme.darkTheme,
    elevatedButtonTheme: TElevatedButtonTheme.darkTheme,
    outlinedButtonTheme: TOutlinedButtonTheme.darkTheme,
    textButtonTheme:  TTextButtonTheme.darkTheme,
    iconButtonTheme: TIconButtonTheme.darkTheme,
    inputDecorationTheme: TInputDecorationTheme.darkTheme,
    textSelectionTheme: TTextSelectionTheme.darkTheme,
    checkboxTheme: TCheckboxTheme.darkTheme,
    cardTheme: TCardTheme.darkTheme,
  );

}