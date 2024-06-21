import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/shower_session.dart';

final showerSessionProvider = StateNotifierProvider<ShowerSessionNotifier, List<ShowerSession>>((ref) {
  return ShowerSessionNotifier();
});

class ShowerSessionNotifier extends StateNotifier<List<ShowerSession>> {
  ShowerSessionNotifier() : super([]) {
    _loadSessions();
  }

  void addSession(ShowerSession session) {
    state = [...state, session];
    _saveSessions();
  }

  void _loadSessions() async {
    final prefs = await SharedPreferences.getInstance();
    final sessionsString = prefs.getString('shower_sessions');
    if (sessionsString != null) {
      final sessionsJson = jsonDecode(sessionsString) as List;
      state = sessionsJson.map((sessionJson) => ShowerSession.fromJson(sessionJson)).toList();
    }
  }

  void _saveSessions() async {
    final prefs = await SharedPreferences.getInstance();
    final sessionsJson = state.map((session) => session.toJson()).toList();
    prefs.setString('shower_sessions', jsonEncode(sessionsJson));
  }
}
