import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const _waterIntakeKey = 'waterIntake';

  Future<void> saveWaterIntake(double intake) async {
    final prefs = await SharedPreferences.getInstance();
    // Save the water intake into prefs  
    await prefs.setDouble(_waterIntakeKey, intake);
  }

  Future<double> getWaterIntake() async {
    // Get the water intake from prefs, remove 'return 0.0'
    return 0.0;
  }
}
