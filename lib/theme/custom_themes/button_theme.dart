import 'package:flutter/material.dart';

const EdgeInsets buttonPadding = EdgeInsets.symmetric(vertical: 10, horizontal: 18);

class TElevatedButtonTheme {
  TElevatedButtonTheme._();

  static final lightTheme =  ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      padding: buttonPadding,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      foregroundColor: Colors.white,
      backgroundColor: Colors.blue,
      disabledForegroundColor: Colors.white,
      disabledBackgroundColor: Colors.grey,
    )
  );

    static final darkTheme =  ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        padding: buttonPadding,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        disabledForegroundColor: Colors.black,
        disabledBackgroundColor: Colors.grey,
      )
    );

}

class TOutlinedButtonTheme {
  TOutlinedButtonTheme._();

  static final lightTheme =  OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,

      padding: buttonPadding,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),

      foregroundColor: Colors.black,
      backgroundColor: Colors.transparent,

      disabledForegroundColor: Colors.grey,
      disabledBackgroundColor: Colors.white,

    )
  );

  static final darkTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,

      padding: buttonPadding,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),

      foregroundColor: Colors.grey,
      backgroundColor: Colors.transparent,
      disabledForegroundColor: const Color.fromARGB(141, 158, 158, 158),
      disabledBackgroundColor: Colors.transparent,
    )
  );

}

class TTextButtonTheme {
  TTextButtonTheme._();

  static final lightTheme = TextButtonThemeData(
    style: TextButton.styleFrom(
      elevation: 0,
      padding: buttonPadding,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      foregroundColor: Colors.blue,
      backgroundColor: Colors.transparent,
      disabledForegroundColor: Colors.grey,
      disabledBackgroundColor: Colors.transparent,
    )
  );

  static final darkTheme = TextButtonThemeData(
    style: TextButton.styleFrom(
      elevation: 0,
      padding: buttonPadding,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      foregroundColor: Colors.blue,
      backgroundColor: Colors.transparent,
      disabledForegroundColor: Colors.grey,
      disabledBackgroundColor: Colors.transparent,
    )
  );

}

class TIconButtonTheme {
  TIconButtonTheme._();

  static final lightTheme = IconButtonThemeData(
    style: IconButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.blue,
      backgroundColor: Colors.transparent,

      disabledForegroundColor: Colors.grey,
      disabledBackgroundColor: Colors.transparent,
    )
  );

  static final darkTheme = IconButtonThemeData(
      style: IconButton.styleFrom(
        elevation: 0,
        foregroundColor: Colors.blue,
        backgroundColor: Colors.transparent,
        disabledForegroundColor: Colors.grey,
        disabledBackgroundColor: Colors.transparent,
    )
  );

}