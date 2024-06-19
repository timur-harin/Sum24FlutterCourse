import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'main.dart';

class SharedPreferencesService {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> saveShowerSession(String key, ShowerSession session) async {
    final prefs = await _prefs;
    String sessionJson = jsonEncode(session.toMap());
    prefs.setString(key, sessionJson);
  }

  Future<ShowerSession?> readShowerSession(String key) async {
    final prefs = await _prefs;
    String? sessionJson = prefs.getString(key);
    if (sessionJson != null) {
      return ShowerSession.fromMap(jsonDecode(sessionJson));
    } else {
      return null;
    }
  }

  Future<List<String>?> getStringList(String key) async {
    final prefs = await _prefs;
    return prefs.getStringList(key);
  }

  Future<void> setStringList(String key, List<String> value) async {
    final prefs = await _prefs;
    prefs.setStringList(key, value);
  }

  Future<void> deleteShowerSession(String key) async {
    final prefs = await _prefs;
    prefs.remove(key);
  }
}
