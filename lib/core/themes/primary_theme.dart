import 'package:flutter/material.dart';

class PrimaryTheme {
  static ThemeData get theme {
    return ThemeData(
      canvasColor: Colors.white,
      backgroundColor: const Color.fromARGB(255, 229, 229, 229),
      primaryColor: const Color.fromARGB(255, 125, 189, 161),
      accentColor: const Color.fromARGB(255, 128, 128, 128),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: Colors.black,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        fillColor: Color.fromARGB(255, 244, 244, 244),
        hintStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color.fromARGB(255, 229, 229, 229),
          splashColor: Color.fromARGB(255, 128, 128, 128)),
      textTheme: const TextTheme(
        bodyText1: TextStyle(
          color: Color.fromARGB(255, 53, 80, 112),
        ),
        bodyText2: TextStyle(
          color: Color.fromARGB(255, 121, 128, 139),
        ),
        subtitle1: TextStyle(
          color: Color.fromARGB(100, 53, 80, 112),
          fontSize: 13,
        ),
        headline6: TextStyle(
          color: Color.fromARGB(255, 125, 189, 161),
          fontWeight: FontWeight.w700,
          fontSize: 15,
        ),
        headline5: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w800,
          fontSize: 18,
        ),
        button: TextStyle(
          color: Colors.white,
        ),
      ),
      colorScheme: ColorScheme.fromSeed(
        seedColor: Color.fromARGB(255, 125, 189, 161),
        primary: Color.fromARGB(255, 125, 189, 161),
        secondary: Color.fromARGB(255, 53, 80, 112),
        tertiary: Color.fromARGB(45, 53, 80, 112),
      ),
      fontFamily: 'Mulish',
    );
  }
}
