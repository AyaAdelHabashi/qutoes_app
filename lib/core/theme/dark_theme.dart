import 'package:flutter/material.dart';
import 'colors.dart';

class DarkAppTheme {
  static final ThemeData themeData = ThemeData( 
     brightness: Brightness.dark,
  // i dont change this file *****
  scaffoldBackgroundColor: ColorsApp.background,
  primaryColor: ColorsApp.primary,
  appBarTheme: AppBarTheme(
    backgroundColor: ColorsApp.background,
    foregroundColor: Color.fromARGB(0, 0, 0, 0),
  ),
  textTheme: TextTheme(
   
  ),
);
}