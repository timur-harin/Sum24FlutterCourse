import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const _waterIntakeKey = 'waterIntake';

  Future<void> saveWaterIntake(double intake) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setDouble(_waterIntakeKey, intake);
  }

  Future<double> getWaterIntake() async {
    final prefs = await SharedPreferences.getInstance();
    double? intake = prefs.getDouble(_waterIntakeKey);
    return intake??0.0;
  }
}
