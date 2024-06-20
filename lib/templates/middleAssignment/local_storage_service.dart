import 'package:shared_preferences/shared_preferences.dart';

/// Service class for handling local storage operations using SharedPreferences.
class LocalStorageService {
  static const _sessionKey = 'sessionsKey';

  /// Saves the history to local storage.
  ///
  /// @param history The list of session history to save.
  Future<void> saveHistory(List<String> history) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_sessionKey, history);
  }

  /// Retrieves the history from local storage.
  ///
  /// @return The list of session history retrieved from local storage.
  Future<List<String>> getHistory() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_sessionKey) ?? [];
  }
}
