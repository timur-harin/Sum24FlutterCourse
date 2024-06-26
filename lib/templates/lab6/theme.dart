import 'package:flutter/material.dart';

class ThemeNotifier extends ChangeNotifier {
  ThemeData _currentTheme;
  bool flag = true;

  ThemeNotifier(this._currentTheme);

  ThemeData get currentTheme => _currentTheme;

  void switchTheme() {
    // TODO add switch theme
    if(flag){
      _currentTheme = ThemeData.dark();
    }
    else{
      _currentTheme = ThemeData.light();
    }
    flag = !flag;
    notifyListeners();
  }
}
