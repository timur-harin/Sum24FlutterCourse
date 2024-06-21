class ShowerSessionForHistory {
  final int sessionDuration;
  final int hotWaterDuration;
  final int coldWaterDuration;
  final bool startWithHotWater;
  final int phasesCompleted;
  double rating; 

  ShowerSessionForHistory({
    required this.sessionDuration,
    required this.hotWaterDuration,
    required this.coldWaterDuration,
    required this.startWithHotWater,
    required this.phasesCompleted,
    this.rating = 5.0, 
  });

  Map<String, dynamic> toJson() {
    return {
      'sessionDuration': sessionDuration,
      'hotWaterDuration': hotWaterDuration,
      'coldWaterDuration': coldWaterDuration,
      'startWithHotWater': startWithHotWater,
      'phasesCompleted': phasesCompleted,
      'rating': rating, 
    };
  }

  factory ShowerSessionForHistory.fromJson(Map<String, dynamic> json) {
    return ShowerSessionForHistory(
      sessionDuration: json['sessionDuration'],
      hotWaterDuration: json['hotWaterDuration'],
      coldWaterDuration: json['coldWaterDuration'],
      startWithHotWater: json['startWithHotWater'],
      phasesCompleted: json['phasesCompleted'],
      rating: json['rating'] ?? 5.0, 
    );
  }
}
