import 'dart:convert';

import 'package:education/templates/middleAssignment/Shower/SessionInfo.dart';

class ShowerHistory {
  final String name;
  final DateTime date;
  final int duration;
  final List<SessionInfo> sessions;
  final String notes;
  final double temperature;

  ShowerHistory({
    required this.name,
    required this.date,
    required this.duration,
    required this.sessions,
    required this.notes,
    required this.temperature,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'date': date.toString(),
    'duration': duration,
    'sessions': sessions.map((session) => session.toJson()).toList(),
    'notes': notes,
    'temperature': temperature,
  };

  factory ShowerHistory.fromJson(Map<String, dynamic> json) => ShowerHistory(
    name: json['name'],
    date: DateTime.parse(json['date']),
    duration: json['duration'],
    sessions: SessionInfo.fromJsonList(json['sessions']),
    notes: json['notes'],
    temperature: json['temperature'],
  );
}
