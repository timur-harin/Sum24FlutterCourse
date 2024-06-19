import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  int duration = 0;
  int switches = 0;
  String key = 'session';

  Future<void> saveSession(int duration, int switches) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(key, [duration.toString(), switches.toString()]);
  }

  Future <List<String>> getSession() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(key) ?? ['', ''];
  }
}