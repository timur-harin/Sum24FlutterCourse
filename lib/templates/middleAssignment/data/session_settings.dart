import 'package:education/templates/middleAssignment/data/session.dart';

class SessionSettings {
  Thermostat initialTemperature;
  int maxCycles;
  int hotCycle;
  int coldCycle;

  SessionSettings(
      {required this.initialTemperature,
      required this.maxCycles,
      required this.hotCycle,
      required this.coldCycle});
  SessionSettings.from(SessionSettings another)
      : this(
          initialTemperature: another.initialTemperature,
          maxCycles: another.maxCycles,
          hotCycle: another.hotCycle,
          coldCycle: another.coldCycle,
        );
  factory SessionSettings.fromJson(Map json) => SessionSettings(
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
