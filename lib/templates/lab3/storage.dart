import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const _waterIntakeKey = 'waterIntake';

  Future<void> saveWaterIntake(double intake) async {
    final prefs = await SharedPreferences.getInstance();
    // TODO - Save the water intake into prefs
    await prefs.setString(_waterIntakeKey, intake.toString());
  }

  Future<double> getWaterIntake() async {
    final prefs = await SharedPreferences.getInstance();
    // TODO - Get the water intake from prefs, remove 'return 0.0'

    // Retrieve the string representation of the water intake
    String? intakeStr = prefs.getString(_waterIntakeKey);
    // Check if the value exists and convert it back to a double
    if (intakeStr!= null) {
      return double.parse(intakeStr);
    } else {
      // Return a default value or throw an exception if the value doesn't exist
      return 0.0; // Consider returning a more meaningful default value or handling differently
    }
  
  }
}
