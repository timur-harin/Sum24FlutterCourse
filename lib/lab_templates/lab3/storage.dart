import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const _waterIntakeKey = 'waterIntake';

  Future<void> saveWaterIntake(double intake) async {
    final preferences = await SharedPreferences.getInstance();
    // // TODO - Save the water intake into preferences
    await preferences.setDouble(_waterIntakeKey, intake);
  }

  Future<double> getWaterIntake() async {
    final preferences = await SharedPreferences.getInstance();
    // // TODO - Get the water intake from preferences, remove 'return 0.0'
    return preferences.getDouble(_waterIntakeKey) ?? 0.0;
  }
}
