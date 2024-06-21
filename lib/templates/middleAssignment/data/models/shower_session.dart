import 'dart:convert';

class ShowerSession {
  final String level;
  final String totalTime;
  final int numbOfCycles;
  String rate;
  final String startTime;

  ShowerSession({
    required this.level,
    required this.totalTime,
    required this.numbOfCycles,
    required this.startTime,
    required this.rate,
  });

  factory ShowerSession.fromJson(String jsonString) {
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    return ShowerSession(
      level: jsonMap['level'] as String,
      totalTime: jsonMap['totalTime'] as String,
      numbOfCycles: jsonMap['numbOfCycles'] as int,
      startTime: jsonMap['startTime'] as String,
      rate: jsonMap['rate'] as String,
    );
  }

  String toJson() => json.encode({
        'startTime': startTime,
        'level': level,
        'totalTime': totalTime,
        'numbOfCycles': numbOfCycles,
        'rate': rate,
      });
}
