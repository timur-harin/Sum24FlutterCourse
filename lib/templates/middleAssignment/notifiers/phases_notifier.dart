import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final phasesProvider = StateNotifierProvider<PhasesNotifier, List<Phase>>(
    (ref) => PhasesNotifier());

class PhasesNotifier extends StateNotifier<List<Phase>> {
  PhasesNotifier() : super(_initialPhases());

  static List<Phase> _initialPhases() => [
        Phase(
            type: 'hot',
            minutes: 0,
            seconds: 0,
            minutesController: TextEditingController(),
            secondsController: TextEditingController()),
        Phase(
            type: 'cold',
            minutes: 0,
            seconds: 0,
            minutesController: TextEditingController(),
            secondsController: TextEditingController()),
      ];

  void addPhase() {
    state = [
      ...state,
      Phase(
          type: state.last.type == 'hot' ? 'cold' : 'hot',
          minutes: 0,
          seconds: 0,
          minutesController: TextEditingController(),
          secondsController: TextEditingController()),
    ];
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

class Phase {
  final String type;
  int minutes;
  int seconds;
  final TextEditingController minutesController;
  final TextEditingController secondsController;
  Phase(
      {required this.type,
      required this.minutes,
      required this.seconds,
      required this.minutesController,
      required this.secondsController});
}
