import 'package:education/templates/middleAssignment/Widgets/Shower.dart';
import 'package:flutter/material.dart';


class ShowerProvider extends ChangeNotifier {
  
  int _time = 0;
  int get time => _time;
  set time(int value) {
    _time = value;
    notifyListeners();
  }

  List<Shower> _showers = [];
  List<Shower> get showers => _showers;

  void addShower(Shower showers) {
    _showers.add(showers);
    notifyListeners();
  }


}