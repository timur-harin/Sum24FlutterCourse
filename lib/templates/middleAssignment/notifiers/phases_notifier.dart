import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final phasesProvider = StateNotifierProvider<PhasesNotifier, List<TemperaturePhase>>(
    (ref) => PhasesNotifier());

class PhasesNotifier extends StateNotifier<List<TemperaturePhase>> {
  PhasesNotifier() : super(_initialPhases());

  static List<TemperaturePhase> _initialPhases() => [
        TemperaturePhase(
            type: 'hot',
            minutes: 0,
            seconds: 0,
            minutesController: TextEditingController(),
            secondsController: TextEditingController()),
        TemperaturePhase(
            type: 'cold',
            minutes: 0,
            seconds: 0,
            minutesController: TextEditingController(),
            secondsController: TextEditingController()),
      ];

  void addPhase() {
    state = [
      ...state,
      TemperaturePhase(
          type: state.last.type == 'hot' ? 'cold' : 'hot',
          minutes: 0,
          seconds: 0,
          minutesController: TextEditingController(),
          secondsController: TextEditingController()),
    ];
  }

  void removeLastPhase() {
    if (state.length > 2) {
      state.removeLast();
      state = [...state];
    }
  }

  void updatePhaseDurationMinutes(int index, String value) {
    state[index].minutes = value.isNotEmpty ? int.parse(value) : 0;
    state = [...state];
  }

  void updatePhaseDurationSeconds(int index, String value) {
    state[index].seconds = value.isNotEmpty ? int.parse(value) : 0;
    state = [...state];
  }

  int getTotalDuration() {
    return state.fold(
        0, (int total, phase) => total + phase.minutes * 60 + phase.seconds);
  }

  void reset() {
    for (var phase in state) {
      phase.minutesController.clear();
      phase.secondsController.clear();
    }
    state = _initialPhases();
  }
}

class TemperaturePhase with TemperaturePhaseLog {
  final String type;
  int minutes;
  int seconds;
  final TextEditingController minutesController;
  final TextEditingController secondsController;
  TemperaturePhase(
      {required this.type,
      required this.minutes,
      required this.seconds,
      required this.minutesController,
      required this.secondsController}) {
        logTemperaturePhase(this);
      }
}

mixin TemperaturePhaseLog {
  void logTemperaturePhase(TemperaturePhase phase) {
    print('Phase with type ${phase.type} is created at ${DateTime.now()}');
  }
}

