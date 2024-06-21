import 'package:education/templates/middleAssignment/models/shower_session.dart';
import 'package:education/templates/middleAssignment/screens/session_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final valueProvider = ChangeNotifierProvider<ValueNotifier>((ref) {
  return ValueNotifier();
});



class ValueNotifier extends ChangeNotifier {
  List<ShowerSession> sessions = [];
  int cycles = 0;
  int timeInCycle = 0;
  int cycles_left = 0;
  
    bool isHot = true;
  Color color = Colors.white;

  void addSession(ShowerSession session) {
    sessions.add(session);
    notifyListeners();
  }

  void editSession(ShowerSession session, String rate) {
session.rate = rate;
    notifyListeners();
  }


  void setValues(int cycles, int timeInCycle) {
    this.cycles = cycles;
    this.timeInCycle = timeInCycle;
    this.cycles_left = cycles-1;
    notifyListeners();

  }

  

  void decreaseCycles() {
    cycles_left--;
    notifyListeners();
  }


  void change() {
    if (isHot) {
      isHot = false;
      color = Colors.blue;
    } else {
      isHot = true;
      color = Colors.red;
    }
    notifyListeners();
  }

  void start() {
    isHot = true;
    color = Colors.red;
    notifyListeners();
  }

  void reset() {
    isHot = true;
    color = Colors.white;

    notifyListeners();
  }
}