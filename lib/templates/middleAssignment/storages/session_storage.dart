import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SessionStorageService {
  static const _sessionsKey = 'sessions';

  Future<void> saveSessions(List<Session> sessions) async {
    final prefs = await SharedPreferences.getInstance();
    String jsonString =
        jsonEncode(sessions.map((session) => session.toJson()).toList());
    prefs.setString(_sessionsKey, jsonString);
  }

  Future<List<Session>> getSessions() async {
    final prefs = await SharedPreferences.getInstance();
    String jsonString = prefs.getString(_sessionsKey) ?? '[]';
    List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((item) => Session.fromJson(item)).toList();
  }

  Future<void> addSession(Session session) async {
    List<Session> sessions = await getSessions();
    sessions.add(session);
    await saveSessions(sessions);
  }
}

class Session {
  int totalDuration;
  final List<int> hotPhaseDurations;
  final List<int> coldPhaseDurations;
  final DateTime creationTime;
  double rating;

  Session({
    required this.totalDuration,
    required this.hotPhaseDurations,
    required this.coldPhaseDurations,
    this.rating = 0.0,
    required this.creationTime,
  });

  Map<String, dynamic> toJson() => {
        'totalDuration': totalDuration,
        'hotPhaseDurations': hotPhaseDurations,
        'coldPhaseDurations': coldPhaseDurations,
        'rating': rating,
        'creationTime': creationTime.toIso8601String()
      };

  factory Session.fromJson(Map<String, dynamic> json) => Session(
        totalDuration: json['totalDuration'],
        hotPhaseDurations: List<int>.from(json['hotPhaseDurations']),
        coldPhaseDurations: List<int>.from(json['coldPhaseDurations']),
        rating: json['rating'],
        creationTime: DateTime.parse(json['creationTime']),
      );
}
