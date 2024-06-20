import 'package:education/templates/middleAssignment/models/shower_session.dart';
import 'package:education/templates/middleAssignment/models/temperature_phase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final sessionRiverpod = StateNotifierProvider<sessionNotifier, ShowerSession>((ref) => sessionNotifier());


class sessionNotifier extends StateNotifier<ShowerSession> {

  sessionNotifier() : super(ShowerSession(0, [], DateTime.now())); 

  ShowerSession _session = ShowerSession(0, [], DateTime.now()); 

  void updatePhases(TemperaturePhase phase){  
    state = ShowerSession(state.totalDuration, state.phases + [phase], state.date);
  }

  void setDate(DateTime date){
    state = ShowerSession(state.totalDuration, state.phases, date);
  }

  void setTotalDuration(int duration){
    state = ShowerSession(duration, state.phases, state.date);
  }

  void updateTotalDuration(int duration){
    state = ShowerSession(state.totalDuration + duration, state.phases, state.date);
  }

  void setRate(int rate){
    state = ShowerSession(state.totalDuration, state.phases, state.date, rate: rate);
  }

  TemperaturePhase get lastPhase => state.phases.last;


}