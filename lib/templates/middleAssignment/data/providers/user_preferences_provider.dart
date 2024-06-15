import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/shower_session.dart';

class UserPreferencesProvider with ChangeNotifier {
  late SharedPreferences _prefs;

  Future<void> initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    notifyListeners(); // notify listeners that prefs have been initialized
  }

  void saveSessionHistory(List<ShowerSession> sessions) async {
    await initPrefs(); // ensure prefs are initialized
    _prefs.setStringList('session_history', sessions.map((session) => jsonEncode(session.toJson())).toList());
    notifyListeners();
  }

  Future<List<ShowerSession>> getSessionHistory() async {
    await initPrefs(); // ensure prefs are initialized
    final sessionsJson = _prefs.getStringList('session_history')?? [];
    try {
      return sessionsJson.map((json) => ShowerSession.fromJson(jsonDecode(json))).toList();
    } catch (_) {
      // Handle exceptions, such as malformed JSON, gracefully here
      return []; // Return an empty list if an exception occurs
    }
  }

}