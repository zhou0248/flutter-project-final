import 'package:flutter/material.dart';

class AppTheme {
  final appTheme = ThemeData(
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF1F2232),
      onPrimary: Colors.white,
      secondary: Color(0xFFFDE8E9),
      onSecondary: Colors.black,
      error: Colors.red,
      onError: Colors.white,
      surface: Color(0xBC9EC1),
      onSurface: Colors.blueGrey,
    ),
    textTheme: TextTheme(
      titleMedium: TextStyle(
          fontFamily: 'Catamaran',
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
          color: Colors.grey[850]),
      bodyMedium: TextStyle(
          fontFamily: 'Catamaran',
          fontSize: 24.0,
          fontWeight: FontWeight.w500,
          color: Colors.grey[800]),
      bodySmall: TextStyle(
          fontFamily: 'Catamaran',
          fontSize: 18.0,
          fontWeight: FontWeight.w400,
          color: Colors.grey[800]),
    ),
  );

  ThemeData getTheme() {
    return appTheme;
  }
}

// https://stackoverflow.com/questions/61961988/how-do-i-store-my-default-padding-in-theme-of-in-flutter
const defaultPadding = EdgeInsets.all(20.0);
const largePadding = EdgeInsets.all(30.0);
const smallPadding = EdgeInsets.all(10.0);
