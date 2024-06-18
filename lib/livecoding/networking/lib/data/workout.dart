class Workout {
  final String name;
  final WorkoutType type;
  final DateTime startTime;
  final DateTime? endTime;

  Workout(this.name, this.type, this.startTime, {this.endTime});
}

enum WorkoutType {
  WarmUp,
  Exercise,
  CoolDown
}