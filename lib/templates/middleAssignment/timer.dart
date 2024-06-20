
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'models.dart';
import 'dart:async';


class SessionTimer extends StateNotifier<SessionTimerState> {
  final ShowerSession session;
  int currentPhaseIndex = 0;
  int timeRemaining;
  bool isPaused = false;
  Timer? _timer;

  SessionTimer(this.session)
      : timeRemaining = session.phases[0].duration,
        super(SessionTimerState(
          currentPhase: session.phases[0],
          timeRemaining: session.phases[0].duration,
        )) {
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      tick();
    });
  }

  void tick() {
    if (isPaused) return;

    if (timeRemaining > 0) {
      timeRemaining--;
      state = state.copyWith(timeRemaining: timeRemaining);
    } else {
      currentPhaseIndex++;
      if (currentPhaseIndex < session.phases.length) {
        timeRemaining = session.phases[currentPhaseIndex].duration;
        state = state.copyWith(
          currentPhase: session.phases[currentPhaseIndex],
          timeRemaining: timeRemaining,
        );
      } else {
        // Session complete
        state = state.copyWith(isComplete: true);
        _timer?.cancel();
      }
    }
  }

  void pause() {
    isPaused = true;
    state = state.copyWith(isPaused: true);
  }

  void resume() {
    isPaused = false;
    state = state.copyWith(isPaused: false);
  }

  void end() {
    state = state.copyWith(isComplete: true);
    _timer?.cancel();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
final sessionTimerProvider =
    StateNotifierProvider.family<SessionTimer, SessionTimerState, ShowerSession>(
  (ref, session) => SessionTimer(session),
);

class SessionTimerState {
  final TemperaturePhase currentPhase;
  final int timeRemaining;
  final bool isComplete;
  final bool isPaused;

  SessionTimerState({
    required this.currentPhase,
    required this.timeRemaining,
    this.isComplete = false,
    this.isPaused = false,
  });

  SessionTimerState copyWith({
    TemperaturePhase? currentPhase,
    int? timeRemaining,
    bool? isComplete,
    bool? isPaused,
  }) {
    return SessionTimerState(
      currentPhase: currentPhase ?? this.currentPhase,
      timeRemaining: timeRemaining ?? this.timeRemaining,
      isComplete: isComplete ?? this.isComplete,
      isPaused: isPaused ?? this.isPaused,
    );
  }
}
