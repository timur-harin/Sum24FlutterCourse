class SessionForHistory {
  final int sessionDuration;
  final int hotWaterDuration;
  final int coldWaterDuration;
  final bool startWithHotWater;
  final int phasesCompleted;
  final int taskCompleted;
  double rating;

  SessionForHistory({
    required this.sessionDuration,
    required this.hotWaterDuration,
    required this.coldWaterDuration,
    required this.startWithHotWater,
    required this.phasesCompleted,
    required this.taskCompleted,
    this.rating = 5.0,
  });

  Map<String, dynamic> toJson() {
    return {
      'sessionDuration': sessionDuration,
      'hotWaterDuration': hotWaterDuration,
      'coldWaterDuration': coldWaterDuration,
      'startWithHotWater': startWithHotWater,
      'phasesCompleted': phasesCompleted,
      'taskCompleted': taskCompleted,
      'rating': rating,
    };
  }

  factory SessionForHistory.fromJson(Map<String, dynamic> json) {
    return SessionForHistory(
      sessionDuration: json['sessionDuration'],
      hotWaterDuration: json['hotWaterDuration'],
      coldWaterDuration: json['coldWaterDuration'],
      startWithHotWater: json['startWithHotWater'],
      phasesCompleted: json['phasesCompleted'],
      taskCompleted: json['taskCompleted'],
      rating: json['rating'] ?? 5.0,
    );
  }
}