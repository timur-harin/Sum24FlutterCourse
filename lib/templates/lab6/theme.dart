import 'package:flutter/material.dart';

class ThemeNotifier extends ChangeNotifier {
  ThemeData _currentTheme;
  bool isLight = true;

  ThemeNotifier(this._currentTheme);

  ThemeData get currentTheme => _currentTheme;

  void switchTheme() {
    if (isLight)
      _currentTheme = ThemeData.dark();
    else
      _currentTheme = ThemeData.light();

    isLight = !isLight;
    notifyListeners();
  }
}
