import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProviderSession extends ChangeNotifier {
  ChangeNotifier changeNotifier = ChangeNotifier();

  int _duration = 0;
  int _minTemp = 0;
  int _maxTemp = 0;
  List<int> _showerSession = [];

  int get duration => _duration;
  int get minTemp => _minTemp;
  int get maxTemp => _maxTemp;
  List<int> get showerSession => _showerSession;

  void showerSessionAdd(int duration, int minTemp, int maxTemp) {
    _showerSession.add(duration);
    _showerSession.add(minTemp);
    _showerSession.add(maxTemp);
    notifyListeners();
  }

  set duration(int durationNew) {
    _duration = durationNew;
    notifyListeners();
  }

  set minTemp(int minTempNew) {
    _minTemp = minTempNew;
    notifyListeners();
  }

  set maxTemp(int maxTempNew) {
    _maxTemp = maxTempNew;
    notifyListeners();
  }
}