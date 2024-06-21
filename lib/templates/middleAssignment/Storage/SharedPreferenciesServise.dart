import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:education/templates/middleAssignment/Shower/SessionInfo.dart';
import 'package:education/templates/middleAssignment/Storage/ShowerHistory.dart';

class SharedPreferencesService {
  static const String _key = 'showerHistory';

  Future<List<ShowerHistory>> getShowerHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? sessions = prefs.getStringList(_key);
    if (sessions == null) {
      return [];
    }
    return sessions.map((session) => ShowerHistory.fromJson(jsonDecode(session))).toList();
  }

  Future<void> saveShowerSession(ShowerHistory session) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> sessions = prefs.getStringList(_key) ?? [];
    sessions.add(jsonEncode(session.toJson()));
    await prefs.setStringList(_key, sessions);
  }
}
