// shower_history.dart
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final showerHistoryProvider = StateNotifierProvider<ShowerHistory, List<ShowerSession>>((ref) => ShowerHistory());

class ShowerHistory extends StateNotifier<List<ShowerSession>> {
  ShowerHistory() : super([]);

  void add(ShowerSession session) async {
    state = [...state, session];
    await save();
  }

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final showerHistoryJson = prefs.getString('showerHistory');
    if (showerHistoryJson != null) {
      final List showerHistoryList = jsonDecode(showerHistoryJson);
      state = showerHistoryList.map((e) => ShowerSession.fromJson(e)).toList();
    }
  }
  Future<void> save() async {
    final prefs = await SharedPreferences.getInstance();
    final showerHistoryJson = jsonEncode(state.map((e) => e.toJson()).toList());
    await prefs.setString('showerHistory', showerHistoryJson);
  }
}

class ShowerSession {
  final Duration duration;
  final Duration temperatureInterval;
  final List<Duration> intervals;
  final Duration totalDuration;

  ShowerSession({
    required this.duration,
    required this.temperatureInterval,
    this.intervals = const [],
    required this.totalDuration,
  });

  Map<String, dynamic> toJson() => {
    'duration': duration.inSeconds,
    'temperatureInterval': temperatureInterval.inSeconds,
    'intervals': intervals.map((e) => e.inSeconds).toList(),
    'totalDuration': totalDuration.inSeconds,
  };

  factory ShowerSession.fromJson(Map<String, dynamic> json) {
    return ShowerSession(
      duration: Duration(seconds: json['duration']),
      temperatureInterval: Duration(seconds: json['temperatureInterval']),
      intervals: (json['intervals'] as List).map((e) => Duration(seconds: e)).toList(),
      totalDuration: Duration(seconds: json['totalDuration']),
    );
  }
}