class ShowerSession {
  final DateTime date;
  final int totalDuration; // в минутах
  final int hotDuration; // в секундах
  final int coldDuration; // в секундах
  final int hotTemperature; // температура горячей воды
  final int coldTemperature; // температура холодной воды
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

  ShowerCycle({required this.hotDuration, required this.coldDuration});
}
