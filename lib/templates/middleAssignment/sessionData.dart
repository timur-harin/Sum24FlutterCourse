import 'package:flutter/material.dart';

class SessionData with ChangeNotifier {
  String? _data;

  String? get data => _data;

  void setData(String newData) {
    _data = newData;
    notifyListeners();
  }
}