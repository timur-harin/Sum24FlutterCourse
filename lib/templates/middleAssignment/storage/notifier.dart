import 'storage.dart';
import 'package:flutter/material.dart';

class TimerNotifier extends ChangeNotifier {
  void saveData(int number) async {
    // Save timer data using Storage
    await Storage.saveTimerData('Timer', _timerRemainingTime);
  }

  Duration loadData(String timerName, Duration defaultDuration) {
    // Load data for the specific timer using Storage
    return Storage.loadTimerData(timerName) as Duration;
  }

  Duration _timerRemainingTime = Duration.zero;

  // Add methods to update timer values in the notifier
  void updateTimer(Duration newTime) {
    _timerRemainingTime = newTime;
    notifyListeners();
  }
}

class SessionNotifier extends ChangeNotifier {
  void saveData(int id, String temperature, Duration duration) async {
    // Save session data using Storage
    await SessionStorage.saveData(id, temperature, duration);
  }

  Duration loadData(int id, String temperature) {
    // Load data for the specific session using Storage
    return SessionStorage.loadData(id, temperature) as Duration;
  }

  Duration _sessionRemainingTime = Duration.zero;
}
