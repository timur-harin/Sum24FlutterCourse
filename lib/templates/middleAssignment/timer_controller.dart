import 'dart:async';
import 'package:flutter/material.dart';
import 'main.dart';

enum TimerState { paused, running }

class TimerController extends ChangeNotifier {
  Timer? _timer;
  int _remainingTime;
  final String _currentPhase;
  final List<TemperaturePhase> _phases;
  int _currentPhaseIndex;
  late TimerState _state = TimerState.running;
  ValueNotifier<String> currentPhaseNotifier = ValueNotifier<String>('Hot');

  TimerController({required List<TemperaturePhase> phases})
      : _remainingTime = phases.first.duration,
        _currentPhase = phases.first.temperature,
        _phases = phases,
        _currentPhaseIndex = 0 {
    _startTimer();
  }

  int get remainingTime => _remainingTime;

  String get currentPhase => _currentPhase;

  TimerState get state => _state;

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _remainingTime--;
      if (_remainingTime == 0) {
        _currentPhaseIndex++;
        if (_currentPhaseIndex < _phases.length) {
          currentPhaseNotifier.value = _phases[_currentPhaseIndex].temperature;
          _remainingTime = _phases[_currentPhaseIndex].duration;
        } else {
          currentPhaseNotifier.value = 'End';
          _timer?.cancel();
        }
      }
      notifyListeners();
    });
  }

  void pauseTimer() {
    if (remainingTime > 0) {
      _state = TimerState.paused;
      _timer?.cancel();
      _timer = null;
      notifyListeners();
    }
  }

  void unpauseTimer() {
    if (_timer == null && remainingTime > 0) {
      _state = TimerState.running;
      _startTimer();
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
