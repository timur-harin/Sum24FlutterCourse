

import 'package:education/templates/middleAssignment/models/preferences.dart';
import 'package:education/templates/middleAssignment/models/temperature_phase.dart';
import 'package:education/templates/middleAssignment/providers/session_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final preferencesProvider = StateNotifierProvider<PreferencesNotifier, Preferences>((ref) => PreferencesNotifier());


class PreferencesNotifier extends StateNotifier<Preferences> {
  
  PreferencesNotifier() : super(Preferences(0, TemperaturePhase.hot, 0));

  Preferences _preferences = Preferences(0, TemperaturePhase.hot, 0);

  // void setPhaseDuration(int duration){
  //   _preferences.phaseDuration = duration;
  // }

  // void setFirstPhase(TemperaturePhase phase){
  //   _preferences.firstPhase = phase;
  // }

  // void setNumberOfPhases(int number){
  //   _preferences.numberOfPhases = number;
  // }

  // Preferences get preferences => _preferences;


  void setPhaseDuration(int duration){
    state = Preferences(duration, state.firstPhase, state.numberOfPhases);
  }

  void setFirstPhase(TemperaturePhase phase){
    state = Preferences(state.phaseDuration, phase, state.numberOfPhases);
  }

  void setNumberOfPhases(int number){
    state = Preferences(state.phaseDuration, state.firstPhase, number);
  }
}