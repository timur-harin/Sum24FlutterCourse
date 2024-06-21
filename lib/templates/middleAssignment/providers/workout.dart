class Workout {
  final String name;
  final WorkoutType type;
  final DateTime startTime;
  final DateTime? endTime;
  final int actualTime; // New field for actual time withstood
  final int actualCycles; // New field for actual cycles completed
  final int hotCycles;
  final int coldCycles;
  final DateTime date;

  Workout(this.name, this.type, this.startTime,
      {required this.endTime,
      this.actualTime = 0,
      this.actualCycles = 0,
      required this.hotCycles,
      required this.coldCycles,
      required this.date});

  int get totalCycles => hotCycles + coldCycles;
}

enum WorkoutType { WarmUp, Exercise, CoolDown }
