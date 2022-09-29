import 'package:flutter/material.dart';

class PrimaryTheme {
  static ThemeData get theme {
    return ThemeData(
      canvasColor: Colors.white,
      backgroundColor: Color.fromARGB(255, 229, 229, 229),
      primaryColor: Color.fromARGB(255, 125, 189, 161),
      accentColor: Color.fromARGB(255, 128, 128, 128),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: Colors.black,
      ),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: Color.fromARGB(255, 244, 244, 244),
        hintStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Color.fromARGB(255, 229, 229, 229),
          splashColor: Color.fromARGB(255, 128, 128, 128)),
      textTheme: TextTheme(
        bodyText1: const TextStyle(
          color: Color.fromARGB(255, 53, 80, 112),
        ),
        bodyText2: const TextStyle(
          color: Color.fromARGB(255, 121, 128, 139),
        ),
        button: TextStyle(
          color: Colors.white,
        ),
      ),
      colorScheme: ColorScheme.fromSeed(
        seedColor: Color.fromARGB(255, 125, 189, 161),
        primary: Color.fromARGB(255, 125, 189, 161),
      ),
      fontFamily: 'Mulish',
    );
  }
}
