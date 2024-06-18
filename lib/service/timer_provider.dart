import 'dart:async';
import 'package:flutter/material.dart';

class TimerAndTempModel extends ChangeNotifier {
  int _selectedHour = 0;
  int _selectedMinute = 0;
  int _selectedSecond = 0;
  int _warmtemp = 20;
  int _coldtemp = 15;

  Timer? _timer; 
  Timer? _seance; 
  bool _isTimerRunning = false;
  bool _isWarmMode = true; 

  int get selectedHour => _selectedHour;
  int get selectedMinute => _selectedMinute;
  int get selectedSecond => _selectedSecond;
  int get warmtemp => _warmtemp;
  int get coldtemp => _coldtemp;
  bool get isTimerRunning => _isTimerRunning;
  bool get isWarmMode => _isWarmMode;

  void setTime(int hour, int minute, int second) {
    _selectedHour = hour;
    _selectedMinute = minute;
    _selectedSecond = second;
    notifyListeners();
  }

  void incrementTime() {
    if (_selectedSecond < 59) {
      _selectedSecond++;
    } else {
      _selectedSecond = 0;
      if (_selectedMinute < 59) {
        _selectedMinute++;
      } else {
        _selectedMinute = 0;
        if (_selectedHour < 23) {
          _selectedHour++;
        }
      }
    }
    notifyListeners();
  }

  void decrementTime() {
    if (_selectedSecond > 0) {
      _selectedSecond--;
    } else if (_selectedMinute > 0) {
      _selectedMinute--;
      _selectedSecond = 59;
    } else if (_selectedHour > 0) {
      _selectedHour--;
      _selectedMinute = 59;
      _selectedSecond = 59;
    }
    notifyListeners();
  }

  void setWarmTemp(int temp) {
    _warmtemp = temp;
    notifyListeners();
  }

  void incrementWarmTemp() {
    _warmtemp++;
    notifyListeners();
  }

  void decrementWarmTemp() {
    _warmtemp--;
    notifyListeners();
  }

  void setColdTemp(int temp) {
    _coldtemp = temp;
    notifyListeners();
  }

  void incrementColdTemp() {
    _coldtemp++;
    notifyListeners();
  }

  void decrementColdTemp() {
    _coldtemp--;
    notifyListeners();
  }

  void startTimer() {
    _isTimerRunning = true;
    startSeance();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      decrementTime();
      if (_selectedHour == 0 && _selectedMinute == 0 && _selectedSecond == 0) {
        pauseTimer();
      }
    });
    notifyListeners();
  }

  void pauseTimer() {
    _timer?.cancel();
    _seance?.cancel();
    _isTimerRunning = false;
    notifyListeners();
  }

  void changeSeance() {
    _isWarmMode = !_isWarmMode;
    notifyListeners();
  }

  void startSeance() {
    _seance = Timer.periodic(const Duration(seconds: 2), (_) {
      changeSeance();
    });
  }
}
