import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SessionStorageService {
  static const _sessionsKey = 'sessions';

  Future<void> saveSessions(List<ShowerSession> sessions) async {
    final prefs = await SharedPreferences.getInstance();
    String jsonString =
        jsonEncode(sessions.map((session) => session.toJson()).toList());
    prefs.setString(_sessionsKey, jsonString);
  }

  Future<List<ShowerSession>> getSessions() async {
    final prefs = await SharedPreferences.getInstance();
    String jsonString = prefs.getString(_sessionsKey) ?? '[]';
    List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((item) => ShowerSession.fromJson(item)).toList();
  }

  Future<void> addSession(ShowerSession session) async {
    List<ShowerSession> sessions = await getSessions();
    sessions.add(session);
    await saveSessions(sessions);
  }
}

class ShowerSession {
  int totalDuration;
  final List<int> hotPhaseDurations;
  final List<int> coldPhaseDurations;
  final DateTime creationTime;
  double rating;
  int hotPhasesCompleted;
  int coldPhasesCompleted;

  ShowerSession({
    required this.totalDuration,
    required this.hotPhaseDurations,
    required this.coldPhaseDurations,
    this.rating = 0.0,
    required this.creationTime,
    this.hotPhasesCompleted = 0,
    this.coldPhasesCompleted = 0,
  });

  Map<String, dynamic> toJson() => {
        'totalDuration': totalDuration,
        'hotPhaseDurations': hotPhaseDurations,
        'coldPhaseDurations': coldPhaseDurations,
        'rating': rating,
        'creationTime': creationTime.toIso8601String(),
        'hotPhasesCompleted': hotPhasesCompleted,
        'coldPhasesCompleted': coldPhasesCompleted,
      };

  factory ShowerSession.fromJson(Map<String, dynamic> json) => ShowerSession(
        totalDuration: json['totalDuration'],
        hotPhaseDurations: List<int>.from(json['hotPhaseDurations']),
        coldPhaseDurations: List<int>.from(json['coldPhaseDurations']),
        rating: json['rating'],
        creationTime: DateTime.parse(json['creationTime']),
        hotPhasesCompleted: json['hotPhasesCompleted'],
        coldPhasesCompleted: json['coldPhasesCompleted'],
      );
}
