import 'package:flutter/material.dart';
import 'colors.dart';

class LightAppTheme {
  static final ThemeData themeData = ThemeData(
      brightness: Brightness.light,
  fontFamily: 'Cairo',
  scaffoldBackgroundColor: const Color(0xFFF8F9FA),
  primaryColor: ColorsApp.primary,
  
  appBarTheme: AppBarTheme(
    backgroundColor: ColorsApp.background,
    foregroundColor: Color.fromARGB(0, 0, 0, 0),
  ),


  textTheme: TextTheme(
    displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
    headlineLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    headlineMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
    headlineSmall: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
    bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
    bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
    labelSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
    labelLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
  ),
);
}