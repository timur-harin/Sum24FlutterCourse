import 'package:flutter/material.dart';

class LocaleNotifier with ChangeNotifier {
  Locale _currentLocale = Locale('en');

  Locale get currentLocale => _currentLocale;

  void switchLocale() {
    if (_currentLocale == Locale('en')) {
      _currentLocale = Locale('ru');
    } else {
      _currentLocale = Locale('en');
    }
    notifyListeners();
  }
}
