import 'package:flutter/material.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: const Color(0xFFE5F3FD),
    textTheme: const TextTheme(
      headlineSmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Color(0xFF213F6D),
      ),
      displayMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Color(0xFF213F6D),
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        color: Color(0xFF213F6D),
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        color: Color(0xFF213F6D),
      ),
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: const Color(0xFFF6993F),
    ),
  );
}


