import 'package:education/templates/middleAssignment/models/temperature_phase.dart';

// class ShowerSession{
//   int totalDuration;
//   List<TemperaturePhase> phases;
//   DateTime date;
//   int rate = 0;

//   ShowerSession(this.totalDuration, this.phases, this.date);

//   void addPhase(TemperaturePhase phase){
//     phases.add(phase);
//   }
// }

class ShowerSession {
  final int totalDuration;
  final List<TemperaturePhase> phases;
  final DateTime date;
  int rate;

  ShowerSession(this.totalDuration, this.phases, this.date, {this.rate = 0});
}
