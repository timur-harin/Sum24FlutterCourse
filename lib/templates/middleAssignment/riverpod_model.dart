import 'package:flutter/material.dart';

class RiverpodModel extends ChangeNotifier {
  int duration;
  int minTemp;
  int maxTemp;
  RiverpodModel({required this.duration, required this.minTemp, required this.maxTemp});

  void changeDuration(int newDuration) {
    duration = newDuration;
    notifyListeners();
  }
  void changeMinTemp(int newMinTemp) {
    minTemp = newMinTemp;
    notifyListeners();
  }
  void changeMaxTemp(int newMaxTemp) {
    maxTemp = newMaxTemp;
    notifyListeners();
  }
}