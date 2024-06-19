import 'package:shared_preferences/shared_preferences.dart';
import 'shower_procedure.dart';

class LocalStorageService {
  static const _currentKey = 'day'; 

  Future<void> saveHistory(ShowerProcedure procedure, int number) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_currentKey + number.toString(), procedure.toJson() as String);
  }

  Future<ShowerProcedure> getDayFromHistory(int number) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_currentKey + number.toString()); // Get JSON string from shared_preferences
    return ShowerProcedure.fromJson(jsonString as Map<String, dynamic>);
  }
}
