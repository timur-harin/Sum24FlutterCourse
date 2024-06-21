import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:riverpod/riverpod.dart';
import 'dart:convert';

class Session{
  late int time;
  late int intervals;
  late int temperature;


  Session({required this.time, required this.intervals, required this.temperature});

  Map<String, dynamic> toJson() => {
    'time': time,
    'intervals': intervals,
    'temperature': temperature,
  };

  Session.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    intervals = json['intervals'];
    temperature = json['temperature'];
  }
}

final sessionListProvider = StateNotifierProvider<SessionList, List<Session>>((ref) {
  return SessionList(ref);
});

class SessionList extends StateNotifier<List<Session>> {
  final Ref ref;


  void _loadSessions() async {
    await fetchSessions();
  }

  SessionList(this.ref, [List<Session>? state]) : super(state ?? []){
    _loadSessions();
  }

  Future<void> addSession(Session session) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<Session> sessions = [...state, session];
    state = sessions;
    await prefs.setString('sessions', jsonEncode(sessions.map((e) => e.toJson()).toList()));
  }

  Future<void> fetchSessions() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? sessionsData = prefs.getString('sessions');
    if (sessionsData != null) {
      final List<dynamic> sessionJson = jsonDecode(sessionsData);
      state = sessionJson.map((e) => Session.fromJson(e as Map<String, dynamic>)).toList();
    }
  }
}





