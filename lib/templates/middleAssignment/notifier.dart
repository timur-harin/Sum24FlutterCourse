import 'package:riverpod/riverpod.dart';
import 'storage.dart';

final localStorageProvider = Provider<LocalStorage>((ref) {
  return LocalStorage();
});

final sessionProvider = StateNotifierProvider<SessionNotifier, List<String>>((ref) {
  final localStorageService = ref.watch(localStorageProvider);
  return SessionNotifier(localStorageService);
});

class SessionNotifier extends StateNotifier<List<String>> {
  final LocalStorage localStorage;
  SessionNotifier(this.localStorage) : super(['0', '0', 'Unknown water']) {
    loadSession();
  }

  void loadSession() async {
    state = await localStorage.getSession();
  }

  void saving(int duration, int switches, String startWater) async {
    await localStorage.saveSession(duration, switches, startWater);
    loadSession();
  }
}