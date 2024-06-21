import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xFFA37BDC);
  static const accent = Color(0xFF03DAC5);
  static const background = Color(0xFF121212);
  static const cardBackground = Color(0xFF1E1E1E);
  static const cardAlternative = Color(0xFF2C2C2C);
  static const hot = Color(0xFFFF7043);
  static const cold = Color(0xFF42A5F5);
  static const textDark = Colors.white;
  static const textLight = Colors.black;
}

final ThemeData appTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: AppColors.primary,
  colorScheme: ColorScheme.dark(
    primary: AppColors.primary,
    secondary: AppColors.accent,
    background: AppColors.background,
  ),
  cardColor: AppColors.cardBackground,
  textTheme: TextTheme(
    headlineLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.textDark),
    bodyLarge: TextStyle(fontSize: 18, color: AppColors.textDark),
    bodyMedium: TextStyle(fontSize: 16, color: Colors.white70),
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: AppColors.accent,
    textTheme: ButtonTextTheme.primary,
  ),
);
