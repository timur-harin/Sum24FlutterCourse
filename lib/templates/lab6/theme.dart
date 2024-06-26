import 'package:flutter/material.dart';

class ThemeNotifier extends ChangeNotifier {
  ThemeData _currentTheme;
  bool isDark = false;

  ThemeNotifier(this._currentTheme);

  ThemeData get currentTheme => _currentTheme;

  void switchTheme() {
    if (!isDark) {
      _currentTheme = ThemeData.dark();
    } else {
      _currentTheme = ThemeData.light();
    }

    isDark = !isDark;
    notifyListeners();
  }
}