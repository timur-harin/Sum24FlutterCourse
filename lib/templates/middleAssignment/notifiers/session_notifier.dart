import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../storages/session_storage.dart';

final sessionStorageServiceProvider = Provider<SessionStorageService>((ref) {
  return SessionStorageService();
});

final sessionsProvider =
    StateNotifierProvider<SessionNotifier, List<Session>>((ref) {
  final sessionStorageService = ref.watch(sessionStorageServiceProvider);
  return SessionNotifier(sessionStorageService);
});

class SessionNotifier extends StateNotifier<List<Session>> {
  final SessionStorageService _sessionStorageService;

  SessionNotifier(this._sessionStorageService) : super(<Session>[]) {
    _loadSessions();
  }

  void _loadSessions() async {
    state = await _sessionStorageService.getSessions();
  }

  void startSession(int totalDuration, List<int> hotPhaseDurations,
      List<int> coldPhaseDurations) async {
    Session session = Session(
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

  Session getCurrentSession() => state.last;
}
