class ShowerSession {
  final DateTime date;
  final Duration duration;
  final List<TemperaturePhase> phases;

  ShowerSession({required this.date, required this.duration, required this.phases});
}

class TemperaturePhase {
  final Duration duration;
  final String temperature; // 'hot' or 'cold'

  TemperaturePhase({required this.duration, required this.temperature});
}

class UserPreferences {
  final Duration defaultHotDuration;
  final Duration defaultColdDuration;

  UserPreferences({required this.defaultHotDuration, required this.defaultColdDuration});
}