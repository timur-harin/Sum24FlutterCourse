import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final phasesProvider = StateNotifierProvider<PhasesNotifier, List<Phase>>((ref) => PhasesNotifier());

class PhasesNotifier extends StateNotifier<List<Phase>> {
  PhasesNotifier() : super(_initialPhases());

  static List<Phase> _initialPhases() => [
    Phase(type: 'hot', duration: 0, controller: TextEditingController()),
    Phase(type: 'cold', duration: 0, controller: TextEditingController()),
  ];

  void addPhase() {
    state = [
      ...state,
      Phase(type: state.last.type == 'hot' ? 'cold' : 'hot', duration: 0, controller: TextEditingController()),
    ];
  }

  void updatePhaseDuration(int index, String value) {
    state[index].duration = value.isNotEmpty ? int.parse(value) : 0;
    state = [...state];
  }

  int getTotalDuration() {
    return state.fold(0, (int total, phase) => total + phase.duration);
  }

  void reset() {
    for (var phase in state) {
      phase.controller.clear();
    }
    state = _initialPhases();
  }
}

class Phase {
  final String type;
  int duration;
  final TextEditingController controller;

  Phase({required this.type, required this.duration, required this.controller});
}
