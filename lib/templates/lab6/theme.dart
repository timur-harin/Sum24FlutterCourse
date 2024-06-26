import 'package:flutter/material.dart';

class ThemeNotifier extends ChangeNotifier {
  ThemeData _currentTheme;

  ThemeNotifier(this._currentTheme);

  ThemeData get currentTheme => _currentTheme;

  void switchTheme() {
    _currentTheme = _currentTheme == ThemeData.dark() ? ThemeData.light() : ThemeData.dark();
    notifyListeners();
  }
}