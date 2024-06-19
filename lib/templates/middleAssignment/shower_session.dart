import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ShowerSession {
  final DateTime date;
  final int hotDuration;
  final int coldDuration;
  final int totalDuration;

  ShowerSession({
    required this.date,
    required this.hotDuration,
    required this.coldDuration,
    required this.totalDuration,
  });

  Map<String, dynamic> toJson() => {
    'date': date.toIso8601String(),
    'hotDuration': hotDuration,
    'coldDuration': coldDuration,
    'totalDuration': totalDuration,
  };

  factory ShowerSession.fromJson(Map<String, dynamic> json) {
    return ShowerSession(
      date: DateTime.parse(json['date']),
      hotDuration: json['hotDuration'],
      coldDuration: json['coldDuration'],
      totalDuration: json['totalDuration'],
    );
  }
}

final showerSessionsProvider = FutureProvider<List<ShowerSession>>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  final String? sessionsString = prefs.getString('sessions');
  if (sessionsString != null) {
    List<dynamic> jsonList = jsonDecode(sessionsString);
    return jsonList.map((json) => ShowerSession.fromJson(json)).toList();
  } else {
    return [];
  }
});

final addSessionProvider = Provider<void Function(ShowerSession)>((ref) {
  return (session) async {
    final prefs = await SharedPreferences.getInstance();
    final List<ShowerSession> currentSessions = ref.read(showerSessionsProvider).value ?? [];
    final updatedSessions = [...currentSessions, session];
    await prefs.setString('sessions', jsonEncode(updatedSessions.map((s) => s.toJson()).toList()));
    ref.refresh(showerSessionsProvider);
  };
});
