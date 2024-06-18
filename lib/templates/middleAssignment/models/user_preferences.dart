import 'temperature_phase.dart';

class UserPreferences {
  TemperaturePhase firstPhase;
  int durationOfPhase;
  int numberOfPhases;
  int get totalDuration => durationOfPhase * numberOfPhases;

  UserPreferences({
    required this.firstPhase,
    required this.durationOfPhase,
    required this.numberOfPhases,
  });
}
