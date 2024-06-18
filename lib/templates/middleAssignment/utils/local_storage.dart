import 'package:shared_preferences/shared_preferences.dart';
import '../models/shower_session.dart';
import '../models/temperature_phase.dart';

class LocalStorage {
  static Future<void> saveSessionHistory(List<ShowerSession> sessions) async {
    final prefs = await SharedPreferences.getInstance();
    final sessionStrings = sessions.map((session) => sessionToJson(session)).toList();
    await prefs.setStringList('sessionHistory', sessionStrings);
  }

  static Future<List<ShowerSession>> loadSessionHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final sessionStrings = prefs.getStringList('sessionHistory') ?? [];
    return sessionStrings.map((sessionString) => sessionFromJson(sessionString)).toList();
  }

  static String sessionToJson(ShowerSession session) {
    return '${session.date.toIso8601String()},${session.rate},${session.totalDuration},${session.firstPhase.index},${session.numberOfPhases},${session.durationOfPhase}';
  }

  static ShowerSession sessionFromJson(String sessionString) {
    final parts = sessionString.split(',');
    return ShowerSession(
      date: DateTime.parse(parts[0]),
      rate: double.parse(parts[1]),
      totalDuration: int.parse(parts[2]),
      firstPhase: TemperaturePhase.values[int.parse(parts[3])],
      numberOfPhases: int.parse(parts[4]),
      durationOfPhase: int.parse(parts[5]),
    );
  }
}
