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
  SessionNotifier(this.localStorage) : super(['1', '1', '1']) {
    loadSession();
  }

  void loadSession() async {
    state = await localStorage.getSession();
    print(state);
  }

  void saving(int duration, int minTemp, int maxTemp) async {
    await localStorage.saveSession(duration, minTemp, maxTemp);
    loadSession();
  }
}