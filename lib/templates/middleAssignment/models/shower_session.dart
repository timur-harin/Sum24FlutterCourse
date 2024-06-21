class ShowerSessionStep {
  final bool isHot;
  final Duration duration;

  ShowerSessionStep({
    required this.isHot,
    required this.duration,
  });

  Map<String, dynamic> toJson() => {
        'isHot': isHot,
        'duration': duration.inSeconds,
      };

  factory ShowerSessionStep.fromJson(Map<String, dynamic> json) {
    return ShowerSessionStep(
      isHot: json['isHot'],
      duration: Duration(seconds: json['duration']),
    );
  }
}

class ShowerSession {
  final Duration totalDuration;
  final List<ShowerSessionStep> steps;
  final String date;

  ShowerSession({
    required this.totalDuration,
    required this.steps,
    required this.date,
  });

  Map<String, dynamic> toJson() => {
        'totalDuration': totalDuration.inSeconds,
        'steps': steps.map((step) => step.toJson()).toList(),
        'date': date,
      };

  factory ShowerSession.fromJson(Map<String, dynamic> json) {
    final stepsJson = json['steps'] as List;
    return ShowerSession(
      totalDuration: Duration(seconds: json['totalDuration']),
      steps: stepsJson.map((stepJson) => ShowerSessionStep.fromJson(stepJson)).toList(),
      date: json['date'] ?? '',
    );
  }
}
