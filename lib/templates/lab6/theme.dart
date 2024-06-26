import 'package:flutter/material.dart';

class ThemeNotifier extends ChangeNotifier {
  ThemeData _currentTheme;

  ThemeNotifier(this._currentTheme);

  ThemeData get currentTheme => _currentTheme;

  void switchTheme() {
    if (currentTheme.brightness == Brightness.dark) {
      _currentTheme = ThemeData.light();
      notifyListeners();
    } else {
      _currentTheme = ThemeData.dark();
      notifyListeners();
    }
  }
}