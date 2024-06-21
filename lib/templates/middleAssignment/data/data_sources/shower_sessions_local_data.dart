import 'dart:convert';

import 'package:education/templates/middleAssignment/data/models/shower_history.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ShowerSessionsLocalDataSource {
  Future<List<ShowerSession>> getShowerSessions();

  Future<void> saveShowerSessions(List<ShowerSession> sessions);
}

class ShowerSessionStorage implements ShowerSessionsLocalDataSource {
  static const String _sessionsKey = 'shower_sessions';
  static const String _id_counter = 'id_counter';

  @override
  Future<List<ShowerSession>> getShowerSessions() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final sessionsStringList = sharedPreferences.getStringList(_sessionsKey);
    //If we don't have any sessions, return an empty list
    if (sessionsStringList == null) {
      return [];
    }

    final sessionsJson =
        sessionsStringList.map((sessionString) => jsonDecode(sessionString)).toList();
    final sessions =
        sessionsJson.map((sessionJson) => ShowerSession.fromJson(sessionJson)).toList();

    return sessions;
  }

  @override
  Future<void> saveShowerSessions(List<ShowerSession> sessions) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final sessionsJson = sessions
        .map((session) => session.toJson())
        .toList()
        .map((sessionJson) => jsonEncode(sessionJson))
        .toList();

    await sharedPreferences.setStringList(_sessionsKey, sessionsJson);
  }

  Future<int> getIdCounter() async {
    final prefs = await SharedPreferences.getInstance();
    final int idCounter = prefs.getInt(_id_counter) ?? 0; //  Read 0
    await prefs.setInt(_id_counter, idCounter + 1); // Write 1
    return idCounter; // Return 0
  }
}
