import 'package:education/templates/middleAssignment/data/models/temperature_phase.dart';

class ShowerSession {
  final int id;
  final DateTime startTime;
  final int duration;
  final List<TemperaturePhase> phases;
  int? remainingTime;


  ShowerSession(
      {required this.id, required this.startTime, required this.duration, required this.phases});

  factory ShowerSession.fromJson(Map<String, dynamic> json) {
    return ShowerSession(
      id: json['id'],
      startTime: DateTime.parse(json['start_time']),
      duration: json['duration'],
      phases: (json['phases'] as List)
          .map((phase) => TemperaturePhase.fromJson(phase))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'start_time': startTime.toIso8601String(),
      'duration': duration,
      'phases': phases.map((phase) => phase.toJson()).toList(),
    };
  }




}
