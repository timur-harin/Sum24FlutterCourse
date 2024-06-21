import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ShowerHistorySession {
  final DateTime date;
  final Duration duration;

  ShowerHistorySession({required this.date, required this.duration});

  // Converts the ShowerHistorySession object to a JSON string
  String toJson() => json.encode({
    'date': date.toIso8601String(),
    'duration': duration.inSeconds,
  });

  // Creates a ShowerHistorySession object from a JSON string
  static ShowerHistorySession fromJson(String jsonString) {
    final data = json.decode(jsonString);
    return ShowerHistorySession(
      date: DateTime.parse(data['date']),
      duration: Duration(seconds: data['duration']),
    );
  }
}