import 'package:flutter/material.dart';
import 'color_theme.dart';

class TTextTheme {
  TTextTheme._();

  static TextTheme lightTheme = const TextTheme(

    headlineLarge: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold, color: lightPrimaryTextColor),
    headlineMedium: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600, color: lightPrimaryTextColor),
    headlineSmall: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600, color: lightSecondaryTextColor),

    titleLarge: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600, color: Colors.black),
    titleMedium: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500, color: Colors.black),
    titleSmall: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400, color: Colors.black),

    bodyLarge: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500, color: lightPrimaryTextColor),
    bodyMedium: TextStyle(fontSize: 15.0, fontWeight: FontWeight.normal, color: lightPrimaryTextColor),
    bodySmall: TextStyle(fontSize:  15.0, fontWeight: FontWeight.normal, color: lightSecondaryTextColor),

    labelLarge: TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal, color: Colors.black),
    labelMedium: TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal, color: Colors.black),
    labelSmall: TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal, color: Colors.black),

    displayLarge: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold, color: Colors.black),
    displayMedium: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold, color: Colors.black),
    displaySmall: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold, color: Colors.black),

  );

  static TextTheme darkTheme = const TextTheme(

    headlineLarge: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold, color: darkPrimaryTextColor),
    headlineMedium: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600, color: darkPrimaryTextColor),
    headlineSmall: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600, color: darkSecondaryTextColor),

    titleLarge: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600, color: Colors.white),
    titleMedium: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500, color: Colors.white),
    titleSmall: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400, color: Colors.white),

    bodyLarge: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500, color: darkPrimaryTextColor),
    bodyMedium: TextStyle(fontSize: 15.0, fontWeight: FontWeight.normal, color: darkPrimaryTextColor),
    bodySmall: TextStyle(fontSize:  15.0, fontWeight: FontWeight.normal, color: darkSecondaryTextColor),

    labelLarge: TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal, color: Colors.white),
    labelMedium: TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal, color: Colors.white),
    labelSmall: TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal, color: Colors.white),

    displayLarge: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold, color: Colors.white),
    displayMedium: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold, color: Colors.white),
    displaySmall: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold, color: Colors.white),
  );

}

class TTextSelectionTheme {
  TTextSelectionTheme._();

  static TextSelectionThemeData lightTheme = const TextSelectionThemeData(
    cursorColor: Colors.black,
    selectionColor: Colors.blue,
    selectionHandleColor: Colors.black,
  );


  static TextSelectionThemeData darkTheme = const TextSelectionThemeData(
    cursorColor: Colors.white,
    selectionColor: Colors.blue,
    selectionHandleColor: Colors.white,
  );

}


