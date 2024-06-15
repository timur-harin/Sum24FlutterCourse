import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ShowerSession {
  late final DateTime date;
  late final List<ShowerPhase> phases;

  ShowerSession({required this.date, required this.phases});

   Map<String, dynamic> toJson() => {
        'date': date.toIso8601String(),
        'phases': phases.map((phase) => phase.toJson()).toList(),
      };

  factory ShowerSession.fromJson(Map<String, dynamic> json) {
    return ShowerSession(
      date: DateTime.parse(json['date']),
      phases: (json['phases'] as List).map((phaseJson) => ShowerPhase.fromJson(phaseJson)).toList(),
    );
  }
}

class ShowerPhase {
  late final String name;
  late final Duration duration;

  ShowerPhase({required this.name, required this.duration});

  Map<String, dynamic> toJson() => {
        'name': name,
        'duration': duration.inSeconds,
      };

  factory ShowerPhase.fromJson(Map<String, dynamic> json) {
    return ShowerPhase(
      name: json['name'],
      duration: Duration(seconds: json['duration']),
    );
  }
}

class LocalStorageService {
  static const _sessionKey = 'showerSessions';

  Future<void> saveSessions(List<ShowerSession> sessions) async {
    final prefs = await SharedPreferences.getInstance();
    final sessionData = sessions.map((session) => session.toJson()).toList();
    prefs.setString(_sessionKey, sessionData.toString());
  }

    Future<List<ShowerSession>> getSessions() async {
    final prefs = await SharedPreferences.getInstance();
    final sessionString = prefs.getString(_sessionKey);
    if (sessionString != null) {
      final sessionData = List<Map<String, dynamic>>.from(json.decode(sessionString));
      return sessionData.map((data) => ShowerSession.fromJson(data)).toList();
    }
    return [];
  }
}
