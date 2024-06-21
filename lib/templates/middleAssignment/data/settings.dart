import 'package:education/templates/middleAssignment/data/session.dart';

class Settings {
  Thermostat initialTemperature;
  int maxCycles;
  int hotCycle;
  int coldCycle;

  Settings(
      {required this.initialTemperature,
      required this.maxCycles,
      required this.hotCycle,
      required this.coldCycle});
  Settings.from(Settings another)
      : this(
          initialTemperature: another.initialTemperature,
          maxCycles: another.maxCycles,
          hotCycle: another.hotCycle,
          coldCycle: another.coldCycle,
        );
  factory Settings.fromJson(Map json) => Settings(
        initialTemperature:
            Thermostat.parse(json['initial_temperature'] ?? 'hot') ??
                Thermostat.hot,
        maxCycles: json['max_cycles'] ?? 0,
        hotCycle: json['hot_cycle'] ?? 0,
        coldCycle: json['cold_cycle'] ?? 0,
      );

  Map toJson() => {
        'initial_temperature': initialTemperature.toString(),
        'max_cycles': maxCycles,
        'hot_cycle': hotCycle,
        'cold_cycle': coldCycle,
      };
}
