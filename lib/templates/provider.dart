import 'package:education/templates/middleAssignment/providers/workout.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WorkoutState {
  final int number;
  final List<Workout> workouts;

  WorkoutState({
    required this.number,
    required this.workouts,
  });
  WorkoutState copyWith({
    int? number,
    List<Workout>? workouts,
  }) {
    return WorkoutState(
      number: number ?? this.number,
      workouts: workouts ?? this.workouts,
    );
  }
}

class WorkoutNotifier extends StateNotifier<WorkoutState> {
  WorkoutNotifier() : super(WorkoutState(number: 0, workouts: []));

  int get number => state.number;

  List<Workout> get workouts => state.workouts;

  set number(int value) {
    state = state.copyWith(number: value);
  }

  void addWorkout(Workout workout) {
    final updatedWorkouts = [...state.workouts, workout];
    state = state.copyWith(workouts: updatedWorkouts);
  }
}

final workoutProvider =
    StateNotifierProvider<WorkoutNotifier, WorkoutState>((ref) {
  return WorkoutNotifier();
});
