import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../storages/session_storage.dart';

final sessionStorageServiceProvider = Provider<SessionStorageService>((ref) {
  return SessionStorageService();
});

final sessionsProvider =
    StateNotifierProvider<SessionNotifier, List<ShowerSession>>((ref) {
  final sessionStorageService = ref.watch(sessionStorageServiceProvider);
  return SessionNotifier(sessionStorageService);
});

class SessionNotifier extends StateNotifier<List<ShowerSession>> {
  final SessionStorageService _sessionStorageService;

  SessionNotifier(this._sessionStorageService) : super(<ShowerSession>[]) {
    _loadSessions();
  }

  void _loadSessions() async {
    state = await _sessionStorageService.getSessions();
  }

  void startSession(int totalDuration, List<int> hotPhaseDurations,
      List<int> coldPhaseDurations) async {
    ShowerSession session = ShowerSession(
      totalDuration: totalDuration,
      hotPhaseDurations: hotPhaseDurations,
      coldPhaseDurations: coldPhaseDurations,
      creationTime: DateTime.now()
    );
    await _sessionStorageService.addSession(session);
    _loadSessions();
  }

  void updateRating(double rating) async {
    getCurrentSession().rating = rating;
    await _sessionStorageService.saveSessions(state);
    state = state;
  }

  void updateDuration(int duration) async {
    getCurrentSession().totalDuration = duration;
    await _sessionStorageService.saveSessions(state);
    state = state;
  }

  void updateHotPhasesCompleted(int hotPhasesCompleted) async {
    getCurrentSession().hotPhasesCompleted = hotPhasesCompleted;
    await _sessionStorageService.saveSessions(state);
    state = state;
  }

  void updateColdPhasesCompleted(int coldPhasesCompleted) async {
    getCurrentSession().coldPhasesCompleted = coldPhasesCompleted;
    await _sessionStorageService.saveSessions(state);
    state = state;
  }

  ShowerSession getCurrentSession() => state.last;
}
