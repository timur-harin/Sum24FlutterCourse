import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/temperature_phase.dart';
import '../models/user_preferences.dart';

class PreferencesNotifier extends StateNotifier<UserPreferences> {
  PreferencesNotifier()
      : super(UserPreferences(
          firstPhase: TemperaturePhase.hot,
          durationOfPhase: 1,
          numberOfPhases: 1,
        ));

  void updateFirstPhase(TemperaturePhase phase) {
    state = UserPreferences(
      firstPhase: phase,
      durationOfPhase: state.durationOfPhase,
      numberOfPhases: state.numberOfPhases,
    );
  }

  void updateDurationOfPhase(int duration) {
    state = UserPreferences(
      firstPhase: state.firstPhase,
      durationOfPhase: duration,
      numberOfPhases: state.numberOfPhases,
    );
  }

  void updateNumberOfPhases(int number) {
    state = UserPreferences(
      firstPhase: state.firstPhase,
      durationOfPhase: state.durationOfPhase,
      numberOfPhases: number,
    );
  }
}

final preferencesProvider =
    StateNotifierProvider<PreferencesNotifier, UserPreferences>(
  (ref) => PreferencesNotifier(),
);
