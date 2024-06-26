import 'package:flutter/material.dart';

class ThemeNotifier extends ChangeNotifier {
  ThemeData _currentTheme;

  ThemeNotifier(this._currentTheme);

  ThemeData get currentTheme => _currentTheme;

  void switchTheme() {
    _currentTheme == ThemeData.light()
        ? _currentTheme = ThemeData.dark()
        : _currentTheme = ThemeData.light();
    notifyListeners();
  }
}
