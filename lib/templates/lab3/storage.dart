import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const _waterIntakeKey = 'waterIntake';

  Future<void> saveWaterIntake(double intake) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_waterIntakeKey, intake);
  }

  Future<double> getWaterIntake() async {
    final prefs = await SharedPreferences.getInstance();
    double? water = await prefs.getDouble(_waterIntakeKey);
    return water ?? 0.0;
  }
}
