import 'package:flutter/material.dart';

class ThemeNotifier extends ChangeNotifier {
  ThemeData _currentTheme;

  ThemeNotifier(this._currentTheme);

  ThemeData get currentTheme => _currentTheme;

  void switchTheme() {
    if (_currentTheme.brightness == Brightness.dark){
      _currentTheme = ThemeData.light();
    }else{
      _currentTheme = ThemeData.dark();
    }
    notifyListeners();
  }
}
