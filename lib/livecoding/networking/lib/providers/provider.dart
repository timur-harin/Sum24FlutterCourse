import 'package:flutter/material.dart';
import 'package:networking/data/workout.dart';

class WorkoutProvider extends ChangeNotifier {
  int _number = 0;
  int get number => _number;
  set number(int value) {
    _number = value;
    notifyListeners();
  }

  List<Workout> _workouts = [];
  List<Workout> get workouts => _workouts;
  void addWorkout(Workout workout) {
    _workouts.add(workout);
    notifyListeners();
  }

  
}