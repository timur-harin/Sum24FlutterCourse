import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ShowerSession {
  final DateTime date;
  final Duration duration;

  ShowerSession({required this.date, required this.duration});

  // Конвертирует объект ShowerSession в JSON строку
  String toJson() => json.encode({
    'date': date.toIso8601String(),
    'duration': duration.inSeconds,
  });

  // Создает объект ShowerSession из JSON строки
  static ShowerSession fromJson(String jsonString) {
    final data = json.decode(jsonString);
    return ShowerSession(
      date: DateTime.parse(data['date']),
      duration: Duration(seconds: data['duration']),
    );
  }
}

class ShowerHistoryRepository {
  static const _historyKey = 'shower_history';

  // Сохраняет историю сеансов в SharedPreferences
  Future<void> saveHistory(List<ShowerSession> history) async {
    final prefs = await SharedPreferences.getInstance();
    final historyJson = history.map((session) => session.toJson()).toList();
    await prefs.setStringList(_historyKey, historyJson);
  }

  // Загружает историю сеансов из SharedPreferences
  Future<List<ShowerSession>> loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final historyJson = prefs.getStringList(_historyKey) ?? [];
    return historyJson.map(ShowerSession.fromJson).toList();
  }
}