import 'package:flutter/material.dart';

class AppTheme {
  static const appBarTheme = AppBarTheme(
    backgroundColor: Color(0xFF1F2232),
    foregroundColor: Color(0xFFFDE8E9),
  );
  static const colorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF1F2232),
    onPrimary: Colors.white,
    secondary: Color(0xFFFDE8E9),
    onSecondary: Colors.black,
    error: Colors.red,
    onError: Colors.white,
    surface: Color(0xBC9EC1),
    onSurface: Colors.blueGrey,
  );
  static var textTheme = TextTheme(
    titleMedium: TextStyle(
      fontFamily: 'Catamaran',
      fontSize: 30.0,
      fontWeight: FontWeight.bold,
      color: colorScheme.secondary,
    ),
    bodyMedium: TextStyle(
        fontFamily: 'Catamaran',
        fontSize: 24.0,
        fontWeight: FontWeight.w500,
        color: colorScheme.primary),
    bodySmall: TextStyle(
        fontFamily: 'Catamaran',
        fontSize: 18.0,
        fontWeight: FontWeight.w400,
        color: colorScheme.primary),
  );
  static const defaultPadding = EdgeInsets.all(20.0);
  static const largePadding = EdgeInsets.all(30.0);
  static const smallPadding = EdgeInsets.all(10.0);
  static const buttonPadding =
      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0);

  static var elevatedButtonStyle = ElevatedButton.styleFrom(
    foregroundColor: AppTheme.colorScheme.primary,
    backgroundColor: AppTheme.colorScheme.onPrimary,
    textStyle: AppTheme.textTheme.bodyMedium,
    padding: AppTheme.buttonPadding,
  );
}
// https://stackoverflow.com/questions/61961988/how-do-i-store-my-default-padding-in-theme-of-in-flutter
