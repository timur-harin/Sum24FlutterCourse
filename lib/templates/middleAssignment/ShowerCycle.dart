class ShowerCycle {
  int hotWaterMinutes;
  int coldWaterMinutes;
  int numberOfCycles;
  String startingPhase;
  bool includeAdditionalTemperatureChange;

  ShowerCycle({required this.hotWaterMinutes, required this.coldWaterMinutes,
  required this.numberOfCycles, required this.startingPhase,
    required this.includeAdditionalTemperatureChange});

  Map<String, dynamic> toJson() => {
    'hotWater' : hotWaterMinutes,
    'coldWater' : coldWaterMinutes,
    'cycles' : numberOfCycles,
    'startingPhase' : startingPhase,
    'plusHalfCycle' : includeAdditionalTemperatureChange,
  };

  factory ShowerCycle.fromJson(Map<String, dynamic> json) {
    return ShowerCycle(
      hotWaterMinutes: json['hotWater'] ?? 0,
      coldWaterMinutes: json['coldWater'] ?? 0,
      numberOfCycles: json['cycles'] ?? 0,
      startingPhase: json['startingPhase'] ?? '',
      includeAdditionalTemperatureChange: json['plusHalfCycle'] ?? false,
    );
  }
}