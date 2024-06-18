import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ShowerSession {
  late final DateTime date;
  late final List<ShowerPhase> phases;
  String? feedback;

  ShowerSession({required this.date, required this.phases, this.feedback = ''});

   Map<String, dynamic> toJson() => {
        'date': date.toIso8601String(),
        'phases': phases.map((phase) => phase.toJson()).toList(),
        'feedback': feedback,
      };

  factory ShowerSession.fromJson(Map<String, dynamic> json) {
    return ShowerSession(
      date: DateTime.parse(json['date']),
      phases: (json['phases'] as List).map((phaseJson) => ShowerPhase.fromJson(phaseJson)).toList(),
      feedback: json['feedback'],
    );
  }
}

class ShowerPhase {
  late final String name;
  late final Duration duration;

  ShowerPhase({required this.name, required this.duration});

  Map<String, dynamic> toJson() => {
        'name': name,
        'duration': duration.inMinutes,
      };

  factory ShowerPhase.fromJson(Map<String, dynamic> json) {
    return ShowerPhase(
      name: json['name'],
      duration: Duration(minutes: json['duration']),
    );
  }
}

class LocalStorageService {
  static const _sessionKey = 'showerSessions';

  Future<void> saveSessions(List<ShowerSession> sessions) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final sessionData = json.encode(sessions.map((session) => session.toJson()).toList());
      await prefs.setString(_sessionKey, sessionData);
    } catch (e) {
      print('Error saving sessions: $e');
    }
  }

  Future<List<ShowerSession>> getSessions() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final sessionString = prefs.getString(_sessionKey);
      if (sessionString != null) {
        final List<dynamic> sessionData = json.decode(sessionString);
        return sessionData.map((data) => ShowerSession.fromJson(data)).toList();
      }
      return [];
    } catch (e) {
      print('Error getting sessions: $e');
      return [];
    }
  }
}