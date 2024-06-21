import 'package:education/templates/middleAssignment/data/session.dart';

class SessionSettings {
  Thermostat initialTemperature;
  int maxCycles;
  Map<Thermostat, int> cycleLength;

  SessionSettings(
      {required this.initialTemperature,
      required this.maxCycles,
      required this.cycleLength});
  SessionSettings.from(SessionSettings another)
      : this(
          initialTemperature: another.initialTemperature,
          maxCycles: another.maxCycles,
          cycleLength: another.cycleLength,
        );
  factory SessionSettings.fromJson(Map json) {
    Map<Thermostat, int> cycleLength = {};
    for (Thermostat thermostat in Thermostat.values) {
      cycleLength[thermostat] =
          (json['cycle_length'] ?? {})[thermostat.name] ?? 10;
    }
    return SessionSettings(
      initialTemperature:
          Thermostat.parse(json['initial_temperature'] ?? 'hot') ??
              Thermostat.hot,
      maxCycles: json['max_cycles'] ?? 0,
      cycleLength: cycleLength,
    );
  }

  Map toJson() => {
        'initial_temperature': initialTemperature.toString(),
        'max_cycles': maxCycles,
        'cycle_length': cycleLength.map((Thermostat key, int value) =>
            MapEntry<String, int>(key.name, value)),
      };
}
