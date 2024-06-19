import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  int duration = 0;
  int minTemp = 0;
  int maxTemp = 0;
  String key = 'session';

  Future<void> saveSession(int duration, int minTemp, int maxTemp) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(key, [duration.toString(), minTemp.toString(), maxTemp.toString()]);
  }

  Future <List<String>> getSession() async {
    final prefs = await SharedPreferences.getInstance();
    print("_____");
    print(prefs.getStringList(key));
    return prefs.getStringList(key) ?? ['1', '1', '1'];
  }
}