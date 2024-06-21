import 'dart:convert';
import 'package:education/templates/middleAssignment/models/shower_session.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageManager {
  static const String _sessionsKey = 'shower_sessions';

  Future<List<ShowerSession>> getSessions() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String sessionsJson = prefs.getString(_sessionsKey) ?? '[]';
    final List<dynamic> sessionsList = json.decode(sessionsJson) as List;


    final List<ShowerSession> sessions = sessionsList
        .map((sessionData) => ShowerSession.fromJson(sessionData))
        .toList();

    return sessions;
  }

  Future<void> saveSessionsData(List<ShowerSession> newSessions) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? existingSessionsJson = prefs.getStringList('sessions');
    List<ShowerSession> existingSessions = [];
    if (existingSessionsJson != null) {
      existingSessions = existingSessionsJson
          .map((session) => ShowerSession.fromJson(jsonDecode(session)))
          .toList();
    }
    existingSessions.addAll(newSessions);
    List<String> allSessionsJson = existingSessions
        .map((session) => jsonEncode(session.toJson()))
        .toList();
    await prefs.setStringList('sessions', allSessionsJson);
  }
}
