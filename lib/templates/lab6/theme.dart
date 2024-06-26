import 'package:flutter/material.dart';

class ThemeNotifier extends ChangeNotifier {
  ThemeData _currentTheme;
  bool _isDark;

  ThemeNotifier(this._currentTheme)
      : _isDark = _currentTheme.brightness == Brightness.dark;

  ThemeData get currentTheme => _currentTheme;

  void switchTheme() {
    if (_isDark) {
      _currentTheme = ThemeData.light();
      _isDark = false;
    } else {
      _currentTheme = ThemeData.dark();
      _isDark = true;
    }
  }
}
