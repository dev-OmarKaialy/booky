import 'package:flutter/material.dart';

class ThemeManager {
  ThemeManager._();
  static var darkTheme = ThemeData(
    primaryColor: const Color(0xff1b4332), // Primary color
    colorScheme: const ColorScheme.dark(
      primary: Color(0xff1b4332), // Primary color
      onPrimary: Colors.white, // Color for text/icons on primary color
      surface: Color(0xff2d6a4f), // Surface color
      onSurface: Colors.white, // Color for text/icons on surface
    ),
    switchTheme: SwitchThemeData(
        thumbColor: WidgetStatePropertyAll(Colors.white.withOpacity(.2)),
        overlayColor: WidgetStatePropertyAll(Colors.white.withOpacity(.3))),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xff1b4332), // AppBar background color
      iconTheme: IconThemeData(color: Colors.white), // AppBar icon color
      titleTextStyle: TextStyle(color: Colors.white), // AppBar title text color
    ),
    scaffoldBackgroundColor:
        const Color(0xff2d6a4f), // Scaffold background color
    fontFamily: 'Roboto', // Default font family
  );
  static var lightTheme = ThemeData(
    primaryColor: const Color(0xff5ABD8C),
    colorScheme: const ColorScheme.light(
      primary: Color(0xff5ABD8C),
      onPrimary: Colors.white,
      surface: Colors.white,
      onSurface: Colors.black,
    ),
    switchTheme: SwitchThemeData(
        thumbColor:
            WidgetStatePropertyAll(const Color(0xff5abd8c).withOpacity(.2)),
        overlayColor:
            WidgetStatePropertyAll(const Color(0xff5abd8c).withOpacity(.3))),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xff5ABD8C),
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(color: Colors.white),
    ),
    scaffoldBackgroundColor: Colors.white,
    fontFamily: 'Roboto',
  );
}
