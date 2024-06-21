import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  static const String _timerKey = 'timer';

  static Future<void> saveTimerData(
      String timerName, Duration remainingTime) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_timerKey, remainingTime.inSeconds);
  }

  static Future<Duration> loadTimerData(String timerName) async {
    final prefs = await SharedPreferences.getInstance();
    final savedSeconds = prefs.getInt(_timerKey);
    return Duration(seconds: savedSeconds ?? 0); // Return 0 seconds if null
  }
}

class SessionStorage {
  static const String _baseKey = 'session';

  static Future<void> saveData(int id, String temperature, Duration duration) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('${temperature}_${_baseKey}_$id', duration.inSeconds);
  }

  static Future<Duration> loadData(int id, String temperature) async {
    final prefs = await SharedPreferences.getInstance();
    final savedSeconds = prefs.getInt('${temperature}_${_baseKey}_$id');
    return Duration(seconds: savedSeconds ?? 0); // Return 0 seconds if null
  }
}
