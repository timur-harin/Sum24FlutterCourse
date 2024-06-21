import 'package:flutter/material.dart';
import '../data/session.dart';

class SessionProvider extends ChangeNotifier {
  int _number = 0;
  int get number => _number;
  set number(int value) {
    _number = value;
    notifyListeners();
  }
  int _numberCycles = 0;
  int get numberCycles => _numberCycles;
  set numberCycles(int value) {
    _numberCycles = value;
    notifyListeners();
  }

  String _color = 'Hot';
  String get color => _color;
  set color(String value) {
    _color = value;
    notifyListeners();
  }


  Color _colorColor = Color.fromARGB(255, 232, 145, 139);
  Color get colorColor => _colorColor;
  set colorColor(Color value) {
    _colorColor = value;
    notifyListeners();
  }

  int _duration = 0;
  int get duration => _duration;
  set duration(int value) {
    _duration = value;
    notifyListeners();
  }

  SessionType _feedback = SessionType.Excellent;
  SessionType get feedback => _feedback;
  set feedback(SessionType value) {
    _feedback = value;
    notifyListeners();
  }

  List<Session> _sessions = [];
  List<Session> get sessions => _sessions;
  set sessions(List<Session> value) {
    _sessions = value;
    notifyListeners();
  }
  void addSession(Session session) {
    _sessions.add(session);
    notifyListeners();
  }

  
}