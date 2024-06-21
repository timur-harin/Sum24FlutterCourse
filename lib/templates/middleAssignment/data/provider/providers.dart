import 'package:education/templates/middleAssignment/data/shower_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final sessionProvider =
    ChangeNotifierProvider<SessionNotifier>((ref) => SessionNotifier());
final stateProvider =
    ChangeNotifierProvider<StateNotifier>((ref) => StateNotifier());

final valueProvider =  ChangeNotifierProvider<ValueNotifier>((ref) => ValueNotifier());

final cyclesNumberProvider =  ChangeNotifierProvider<CyclesNotifier>((ref) => CyclesNotifier());
class SessionNotifier extends ChangeNotifier {
  List<ShowerSession> sessions = [];

  void addSession(ShowerSession session) {
    sessions.add(session);
    notifyListeners();
  }
}

class StateNotifier extends ChangeNotifier {
  String state = "Initial";
  bool isHot = true;
  Color color = Colors.white;

  void change() {
    if (state == "Hot") {
      state = "Cold";
      isHot = false;
      color = Colors.blue;
    } else if (state == "Cold") {
      state = "Hot";
      isHot = true;
      color = Colors.red;
    }
    notifyListeners();
  }
  void start(){
    state = "Hot";
    isHot = true;
    color = Colors.red;
    notifyListeners();
  }
}

class ValueNotifier extends ChangeNotifier {
  String level = "Easy";
  int cycles = 4;
  int timeInCycle = 10;
  int number_cycles = 4;

  void setEasy() {
      level = "Easy";
     cycles = 4;
    timeInCycle = 10;
    notifyListeners();
  }
    void setMedium() {
        level = "Medium";

                 cycles = 6;
    timeInCycle = 40;
    notifyListeners();
  }
    void setHard() {
        level = "Hard";

           cycles = 8;
    timeInCycle = 60;
    notifyListeners();
  }


 
}

class CyclesNotifier extends ChangeNotifier {
  int cyclesNumber = 0;
  void set(int numb) {
   cyclesNumber = numb;
    notifyListeners();
  }
  void decrease() {
    cyclesNumber--;
    notifyListeners();
  }
}