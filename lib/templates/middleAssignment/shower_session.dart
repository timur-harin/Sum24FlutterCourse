class ShowerSession {
  final DateTime date;
  final int totalDuration;
  final int hotDuration;
  final int coldDuration;
  final int hotTemperature;
  final int coldTemperature;
  final List<ShowerCycle> cycles;

  ShowerSession({
    required this.date,
    required this.totalDuration,
    required this.hotDuration,
    required this.coldDuration,
    required this.hotTemperature,
    required this.coldTemperature,
    required this.cycles,
  });
}

class ShowerCycle {
  final int hotDuration;
  final int coldDuration;

  ShowerCycle({
    required this.hotDuration,
    required this.coldDuration,
  });
}
