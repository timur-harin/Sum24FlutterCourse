import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  String key = 'Last shower session';

  Future<void> saveShowerSession(String duration, String minTemp, String maxTemp) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(key, [duration, minTemp, maxTemp]);
  }

  Future<List<String>> getShowerSession() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(key) ?? ['Unknown', 'Unknown', 'Unknown'];
  }
}