import 'package:flutter/material.dart';

class ThemeNotifier extends ChangeNotifier {
  ThemeData _currentTheme;
  bool _isDarkTheme;

  ThemeNotifier(this._currentTheme)
      : _isDarkTheme = _currentTheme.brightness == Brightness.dark;


  ThemeData get currentTheme => _currentTheme;

  void switchTheme() {
    if (_isDarkTheme) {
      _currentTheme = ThemeData.light();
    } else {
      _currentTheme = ThemeData.dark();
    }
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }
}
