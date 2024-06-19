import  'package:intl/intl.dart';

class ShowerCycle {
  int hotWaterMinutes;
  int coldWaterMinutes;
  int numberOfCycles;
  String startingPhase;
  String? date;
  bool includeAdditionalTemperatureChange;

  ShowerCycle({
    required this.hotWaterMinutes,
    required this.coldWaterMinutes,
    required this.numberOfCycles,
    required this.startingPhase,
    required this.includeAdditionalTemperatureChange,
    this.date,
  }) {
    if (date == null) {
      DateTime now = DateTime.now();
      date = DateFormat('HH:mm dd.MM').format(now);
    }
  }

  Map<String, dynamic> toJson() => {
    'hotWater' : hotWaterMinutes,
    'coldWater' : coldWaterMinutes,
    'cycles' : numberOfCycles,
    'startingPhase' : startingPhase,
    'date' : date,
    'plusHalfCycle' : includeAdditionalTemperatureChange,
  };

  factory ShowerCycle.fromJson(Map<String, dynamic> json) {
    return ShowerCycle(
      hotWaterMinutes: json['hotWater'] ?? 0,
      coldWaterMinutes: json['coldWater'] ?? 0,
      numberOfCycles: json['cycles'] ?? 0,
      startingPhase: json['startingPhase'] ?? '',
      date: json['date'] ?? '',
      includeAdditionalTemperatureChange: json['plusHalfCycle'] ?? false,
    );
  }
}