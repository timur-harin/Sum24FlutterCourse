import "../data/models/shower_history.dart";
import "package:education/templates/middleAssignment/data/data_sources/shower_sessions_local_data.dart";
import "package:riverpod/riverpod.dart";

final localStorageServiceProvider = Provider<ShowerSessionStorage>((ref) {
  return ShowerSessionStorage();
});

final showerSessionsProvider =
    StateNotifierProvider<ShowerSessionsNotifier, List<ShowerSession>>((ref) {
  final localStorageService = ref.watch(localStorageServiceProvider);
  return ShowerSessionsNotifier(localStorageService);
});

class ShowerSessionsNotifier extends StateNotifier<List<ShowerSession>> {
  final ShowerSessionStorage _localStorageService;

  ShowerSessionsNotifier(this._localStorageService) : super([]) {
    getSessions();
  }

  void addSession(ShowerSession session) async {
    state.add(session);
    await _localStorageService.saveShowerSessions(state);
  }

  void getSessions() async {
    state = await _localStorageService.getShowerSessions();
  }

  void removeSession(int sessionId) async {
    state = state.where((session) => session.id != sessionId).toList();
    await _localStorageService.saveShowerSessions(state);
  }

  void reset() async {
    state = [];
    await _localStorageService.saveShowerSessions(state);
  }
}
