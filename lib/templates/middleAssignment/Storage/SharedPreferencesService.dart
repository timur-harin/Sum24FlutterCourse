import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:education/templates/middleAssignment/Storage/ShowerHistory.dart';

class SharedPreferencesService {
  static const String _keyShowerHistory = 'shower_history';

  
  Future<bool> saveShowerSession(ShowerHistory session) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> sessions = prefs.getStringList(_keyShowerHistory) ?? [];

    sessions.add(jsonEncode(session.toJson()));
    
    return await prefs.setStringList(_keyShowerHistory, sessions);
  }

  // Retrieve list of ShowerHistory objects from SharedPreferences
  Future<List<ShowerHistory>> getShowerSessions() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> sessionStrings = prefs.getStringList(_keyShowerHistory) ?? [];
    
    return sessionStrings.map((e) => ShowerHistory.fromJson(jsonDecode(e))).toList();
  }

  // Example method to retrieve all session names
  Future<List<String>> getShowerSessionNames() async {
    final List<ShowerHistory> sessions = await getShowerSessions();
    return sessions.map((e) => e.name).toList();
  }

  // Example method to retrieve all session times
  Future<List<int>> getShowerSessionTimes() async {
    final List<ShowerHistory> sessions = await getShowerSessions();
    return sessions.map((e) => e.duration).toList();
  }

  // Example method to retrieve all session data
  Future<List<Map<String, dynamic>>> getShowerSessionData() async {
    final List<ShowerHistory> sessions = await getShowerSessions();
    return sessions.map((e) => {
      'name': e.name,
      'time': e.duration,
      'data': e.date.toString(),
      // Add more fields as needed
    }).toList();
  }
}
