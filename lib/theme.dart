import 'package:flutter/material.dart';

var appTheme = ThemeData(
    colorScheme: const ColorScheme(
        brightness: Brightness.light,
        background: Color(0xFF00B3EF),
        surface: Color(0x0000B3EF),
        onSurface: Colors.white,
        onBackground: Colors.white,
        error: Colors.red,
        onError: Colors.white,
        primary: Color(0xFF00B3EF),
        onPrimary: Colors.white,
        secondary: Color(0xFF054F85),
        onSecondary: Colors.white),
    textTheme: const TextTheme(
        displayLarge: TextStyle(
            fontSize: 23, color: Colors.black, fontWeight: FontWeight.bold),
        bodyLarge: TextStyle(
          fontSize: 22,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        bodyMedium: TextStyle(
          fontSize: 20,
          color: Colors.white,
        ),
        bodySmall: TextStyle(fontSize: 16, color: Colors.white)));
