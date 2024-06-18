import 'package:education/templates/middleAssignment/data/workout.dart';
import 'package:flutter/material.dart';

class ShowerProvider extends ChangeNotifier {
  int _number = 0;
  int get number => _number;
  set number(int value) {
    _number = value;
    notifyListeners();
  }

  void increment() {
    number++;
    notifyListeners();
  }

  void decrement() {
    number--;
    notifyListeners();
  }

  void reset() {
    number = 0;
    notifyListeners();
  }
  List<Workout> workouts = [];

  void addWorkout(Workout workout) {
    workouts.add(workout);
    notifyListeners();
  }

  void removeWorkout(Workout workout) { 
    workouts.remove(workout);
    notifyListeners();
  }
}

