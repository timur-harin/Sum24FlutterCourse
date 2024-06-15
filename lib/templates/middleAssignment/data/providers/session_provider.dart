import 'package:flutter/material.dart';

import '../models/shower_session.dart';

class SessionProvider with ChangeNotifier {
  late ShowerSession? _currentSession;

  ShowerSession? get currentSession => _currentSession;

  void startNewSession(ShowerSession session) {
    _currentSession = session;
    session.remainingTime = session.duration;
    notifyListeners();
  }

  void updateSession(ShowerSession session) {
    _currentSession = session;
    notifyListeners();
  }

  void endSession() {
    _currentSession = null;
    notifyListeners();
  }

  void updateRemainingTime() {
    if (_currentSession == null) return;

    final now = DateTime.now();
    final elapsedTime = now.difference(_currentSession!.startTime);
    final remainingTime = _currentSession!.duration - elapsedTime.inMinutes;

    if (remainingTime < 0) {
      endSession();
    } else {
      _currentSession!.remainingTime = remainingTime;
      updateSession(_currentSession!);
    }
  }
}