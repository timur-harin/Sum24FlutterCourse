import 'dart:convert';
import 'package:education/templates/middleAssignment/models/shower_session.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageManager {
  static const String _sessionsKey = 'shower_sessions';

  Future<List<ShowerSession>> getSessions() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String sessionsJson = prefs.getString(_sessionsKey) ?? '[]';
    final List<dynamic> sessionsList = json.decode(sessionsJson) as List;

    // Преобразование списка Map в список ShowerSession
    final List<ShowerSession> sessions = sessionsList
        .map((sessionData) => ShowerSession.fromJson(sessionData))
        .toList();

    return sessions;
  }

  Future<void> saveSessions(List<ShowerSession> sessions) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String sessionsJson = json.encode(
      sessions.map((session) => session.toJson()).toList(),
    );
    await prefs.setString(_sessionsKey, sessionsJson);
  }
}