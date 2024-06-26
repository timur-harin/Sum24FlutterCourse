import 'package:flutter/material.dart';

class LocaleNotifier with ChangeNotifier{
  Locale _currentLocale = Locale('ru');

  Locale get currentLocale => _currentLocale;

  void switchLocale(String languageCode){
    _currentLocale = Locale(languageCode);
    notifyListeners();
  }




}