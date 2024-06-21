import 'package:flutter_riverpod/flutter_riverpod.dart';

int frontStep = 30;
int backStep = 5;

// Define the state notifier for the list of counters
class CountersNotifier extends StateNotifier<List<int>> {
  CountersNotifier() : super([0]);

  // Add a new counter
  void addCounter() {
    state = [...state, 0];
  }

  // Increment the counter at the given index
  void incrementCounter(int index) {
    state = [
      for (int i = 0; i < state.length; i++)
        if (i == index) state[i] + frontStep else state[i]
    ];
  }

  // Decrement the counter at the given index
  void decrementCounter(int index) {
    if (state[index] - backStep < 0) return;
    state = [
      for (int i = 0; i < state.length; i++)
        if (i == index) state[i] - backStep else state[i]
    ];
  }
}

// Create a provider for the CountersNotifier
final countersProvider = StateNotifierProvider<CountersNotifier, List<int>>((ref) {
  return CountersNotifier();
});
