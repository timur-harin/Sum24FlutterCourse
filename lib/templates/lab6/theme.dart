import 'package:flutter/material.dart';

class ThemeNotifier extends ChangeNotifier {
  bool _isDarkTheme = ThemeData().brightness == Brightness.light;

  bool get isDarkTheme => _isDarkTheme;

  ThemeNotifier(this._isDarkTheme);

  // Assuming switchTheme toggles the theme
  void switchTheme() {
    _isDarkTheme =!_isDarkTheme;
    notifyListeners();
  }

  ThemeData get currentTheme {
    return _isDarkTheme? ThemeData.dark() : ThemeData.light();
  }
}