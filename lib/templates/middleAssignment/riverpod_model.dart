import 'package:flutter/material.dart';

class RiverpodModel extends ChangeNotifier {
  int duration;
  int switches;
  RiverpodModel({required this.duration, required this.switches});

  void changeDuration(int newDuration) {
    duration = newDuration;
    notifyListeners();
  }
  void changeSwitches(int newSwitches) {
    switches = newSwitches;
    notifyListeners();
  }
}