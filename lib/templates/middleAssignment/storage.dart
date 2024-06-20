import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  int duration = 0;
  int switches = 0;
  String startWater = " ";
  String key = 'session';

  Future<void> saveSession(int duration, int switches, String startWater) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(key, [duration.toString(), switches.toString(), startWater]);
  }

  Future <List<String>> getSession() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(key) ?? ['0', '0', 'Unknown water'];
  }
}