import 'package:education/templates/middleAssignment/data/boxes.dart';
import 'package:education/templates/middleAssignment/data/session.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';

class Settings {
  Thermostat initialTemperature;
  int maxCycles;

  Settings({required this.initialTemperature, required this.maxCycles});
  Settings.from(Settings another)
      : this(
          initialTemperature: another.initialTemperature,
          maxCycles: another.maxCycles,
        );
  factory Settings.fromJson(Map json) => Settings(
        initialTemperature:
            Thermostat.parse(json['initial_temperature'] ?? 'hot') ??
                Thermostat.hot,
        maxCycles: json['max_cycles'] ?? 0,
      );

  Map toJson() => {
        'initial_temperature': initialTemperature.toString(),
        'max_cycles': maxCycles,
      };
}
