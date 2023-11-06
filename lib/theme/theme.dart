import 'package:flutter/material.dart';

const Color lightThemeTextColor = Colors.black;

const Color darkThemeTextColor = Colors.white;

class TAppTheme {
  TAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,

    textTheme: TTextTheme.lightTheme,

    scaffoldBackgroundColor: Colors.white,
    appBarTheme: TAppBarTheme.lightTheme,
    bottomNavigationBarTheme: TBottomNavigationBarTheme.lightTheme,

    elevatedButtonTheme: TElevatedButtonTheme.lightTheme,

  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,

    textTheme: TTextTheme.darkTheme,

    scaffoldBackgroundColor: Colors.black,
    appBarTheme: TAppBarTheme.darkTheme,
    bottomNavigationBarTheme: TBottomNavigationBarTheme.darkTheme,

    elevatedButtonTheme: TElevatedButtonTheme.darkTheme,
  );

}

class TTextTheme {
  TTextTheme._();

  static TextTheme lightTheme = const TextTheme(

    headlineLarge: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.black),
    headlineMedium: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600, color: Colors.black),
    headlineSmall: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.black),

    titleLarge: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.black),
    titleMedium: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500, color: Colors.black),
    titleSmall: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400, color: Colors.black),

    bodyLarge: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500, color: Colors.black),
    bodyMedium: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal, color: Colors.black),
    bodySmall: TextStyle(fontSize:  14.0, fontWeight: FontWeight.w500, color: Colors.black),

    labelLarge: TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal, color: Colors.black),
    labelMedium: TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal, color: Colors.black),
    labelSmall: TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal, color: Colors.black),

    displayLarge: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold, color: Colors.black),
    displayMedium: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold, color: Colors.black),
    displaySmall: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold, color: Colors.black),

  );

  static TextTheme darkTheme = const TextTheme(

    headlineLarge: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.white),
    headlineMedium: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600, color: Colors.white),
    headlineSmall: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.white),

    titleLarge: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.white),
    titleMedium: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500, color: Colors.white),
    titleSmall: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400, color: Colors.white),

    bodyLarge: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500, color: Colors.white),
    bodyMedium: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal, color: Colors.white),
    bodySmall: TextStyle(fontSize:  14.0, fontWeight: FontWeight.w500, color: Colors.white),

    labelLarge: TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal, color: Colors.white),
    labelMedium: TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal, color: Colors.white),
    labelSmall: TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal, color: Colors.white),

    displayLarge: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold, color: Colors.white),
    displayMedium: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold, color: Colors.white),
    displaySmall: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold, color: Colors.white),
  );

}

class TAppBarTheme {

  static const lightTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.white,
    surfaceTintColor: Colors.white,
    iconTheme: IconThemeData(color: Colors.black, size: 24),
    actionsIconTheme: IconThemeData(color: Colors.black, size: 24),
    titleTextStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.black),
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

class TBottomNavigationBarTheme {

  static const lightTheme = BottomNavigationBarThemeData(
    elevation: 0,
    backgroundColor: Colors.white,
    type: BottomNavigationBarType.fixed,

    selectedItemColor: Colors.black,
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

    selectedLabelStyle: TextStyle(),
    unselectedLabelStyle: TextStyle(),

  );

}

class TElevatedButtonTheme {
  TElevatedButtonTheme._();

  static final lightTheme =  ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.white,
      backgroundColor: Colors.white,
      disabledForegroundColor: Colors.white,
      disabledBackgroundColor: Colors.white,
      side: const BorderSide(color: Colors.blue),
      padding: const EdgeInsets.symmetric(vertical: 18),
      textStyle: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    )
  );

    static final darkTheme =  ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
            elevation: 0,
      foregroundColor: Colors.black,
      backgroundColor: Colors.black,
      disabledForegroundColor: Colors.black,
      disabledBackgroundColor: Colors.white,
      side: const BorderSide(color: Colors.blue),
      padding: const EdgeInsets.symmetric(vertical: 18),
      textStyle: const TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    )
  );

}