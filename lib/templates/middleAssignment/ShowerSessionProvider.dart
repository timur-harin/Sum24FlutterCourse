import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ShowerSession.dart';

class ShowerSessionProvider with ChangeNotifier {
  List<ShowerSession> _sessions = [];
  static const _key = 'shower_sessions';

  Future<void> loadSessions() async {
    final prefs = await SharedPreferences.getInstance();
    final sessionsData = prefs.getString(_key);
    if (sessionsData != null) {
      final List<dynamic> sessionsList = jsonDecode(sessionsData);
      _sessions =
          sessionsList.map((data) => ShowerSession.fromMap(data)).toList();
    }
    notifyListeners();
  }

  Future<void> saveSessions() async {
    final prefs = await SharedPreferences.getInstance();
    final List<Map<String, dynamic>> sessionsData =
        _sessions.map((session) => session.toMap()).toList();
    await prefs.setString(_key, jsonEncode(sessionsData));
  }

  void addSession(ShowerSession session) {
    _sessions.add(session);
    saveSessions();
    notifyListeners();
  }

  ShowerSession? get lastSession {
    if (_sessions.isNotEmpty) {
      return _sessions.last;
    }
    return null;
  }

  List<ShowerSession> get sessions => _sessions;
}
