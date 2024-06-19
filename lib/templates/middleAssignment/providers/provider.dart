import 'package:flutter/material.dart';
import '../data/session.dart';

class SessionProvider extends ChangeNotifier {
  int _number = 0;
  int get number => _number;
  set number(int value) {
    _number = value;
    notifyListeners();
  }

  List<Session> _sessions = [];
  List<Session> get sessions => _sessions;
  void addSession(Session session) {
    _sessions.add(session);
    notifyListeners();
  }

  
}