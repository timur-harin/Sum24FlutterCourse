import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/shower_session.dart';
import '../models/temperature_phase.dart';
import '../models/user_preferences.dart';

class SessionNotifier extends StateNotifier<SessionState> {
  SessionNotifier() : super(SessionState());

  void startSession(UserPreferences preferences) {
    state = state.copyWith(
      currentPhase: preferences.firstPhase,
      remainingTime: preferences.totalDuration * 60,
      isActive: true,
    );
  }

  void pauseSession() {
    state = state.copyWith(isActive: false);
  }

  void endSession() {
    state = SessionState();
  }
}

final sessionProvider = StateNotifierProvider<SessionNotifier, SessionState>(
  (ref) => SessionNotifier(),
);

class SessionState {
  final TemperaturePhase? currentPhase;
  final int remainingTime;
  final bool isActive;
  final List<ShowerSession> sessionHistory;

  SessionState({
    this.currentPhase,
    this.remainingTime = 0,
    this.isActive = false,
    this.sessionHistory = const [],
  });

  SessionState copyWith({
    TemperaturePhase? currentPhase,
    int? remainingTime,
    bool? isActive,
    List<ShowerSession>? sessionHistory,
  }) {
    return SessionState(
      currentPhase: currentPhase ?? this.currentPhase,
      remainingTime: remainingTime ?? this.remainingTime,
      isActive: isActive ?? this.isActive,
      sessionHistory: sessionHistory ?? this.sessionHistory,
    );
  }
}
