import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const _waterIntakeKey = 'waterIntake';

  Future<void> saveWaterIntake(double intake) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble("WaterLevel", intake);
  }

  Future<double> getWaterIntake() async {
    final prefs = await SharedPreferences.getInstance();
    // TODO - Get the water intake from prefs, remove 'return 0.0'
    final double? waterIntake = prefs.getDouble("WaterLevel");
    if (waterIntake != null) {
      return waterIntake;
    } else {
      return 0.0;
    }
  }
}
