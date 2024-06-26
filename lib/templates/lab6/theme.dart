import 'package:flutter/material.dart';

class ThemeNotifier extends ChangeNotifier {
  ThemeData _currentTheme;
  ThemeData light = ThemeData.light();
  ThemeData dark = ThemeData.dark();


  ThemeNotifier(this._currentTheme);

  ThemeData get currentTheme => _currentTheme;

  void switchTheme() {
    if(_currentTheme == light) {
      _currentTheme = dark;
    } else {
      _currentTheme = light;
    }
    notifyListeners();
  }
}
