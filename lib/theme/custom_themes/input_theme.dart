import 'package:flutter/material.dart';

class TInputDecorationTheme{
  TInputDecorationTheme._();

  static const lightTheme = InputDecorationTheme(
    border: OutlineInputBorder(),
    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
    focusColor: Colors.black,
    floatingLabelStyle: TextStyle(color: Colors.black),
    errorStyle: TextStyle(),
    errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
  );

  static const darkTheme = InputDecorationTheme(
    border: OutlineInputBorder(),
    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
    focusColor: Colors.white,
    floatingLabelStyle: TextStyle(color: Colors.white),
    errorStyle: TextStyle(),
    errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
  );

}