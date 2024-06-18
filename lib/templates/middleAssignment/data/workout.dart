import 'package:flutter/material.dart';

class Workout {
  final String name;
  final double duration;
  final WorkoutType type;
  final DateTime startTime;
  final DateTime? endTime;
  Workout({required this.name, required this.duration, required this.type, required this.startTime, this.endTime});
}

enum WorkoutType { Hot, Cold, Warm }

Icon getIcon(WorkoutType type) {
  switch (type) {
    case WorkoutType.Hot:
      return Icon(Icons.thermostat_outlined);
    case WorkoutType.Warm:
      return Icon(Icons.directions_run_outlined);
    case WorkoutType.Cold:
      return Icon(Icons.pool_outlined);
  }
}