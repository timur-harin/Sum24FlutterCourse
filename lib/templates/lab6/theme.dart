import 'package:flutter/material.dart';

class ThemeNotifier extends ChangeNotifier {
  ThemeData _currentTheme;

  ThemeNotifier(this._currentTheme);

  ThemeData get currentTheme => _currentTheme;


  void switchTheme() {
  if(currentTheme == ThemeData.light()) {
    _currentTheme = ThemeData.dark();
  } else {
    _currentTheme = ThemeData.light();
  }
    notifyListeners();
    // TODO add switch theme
  }
}
