import 'temperature_phase.dart';

class ShowerSession {
  final DateTime date;
  final double rate;
  final int totalDuration;
  final TemperaturePhase firstPhase;
  final int numberOfPhases;
  final int durationOfPhase;

  ShowerSession({
    required this.date,
    required this.rate,
    required this.totalDuration,
    required this.firstPhase,
    required this.numberOfPhases,
    required this.durationOfPhase,
  });
}
