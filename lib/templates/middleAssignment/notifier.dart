import 'sessionBath.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'storage.dart';

final localStorageServiceProvider = Provider<LocalStorageService>((ref) {
  return LocalStorageService();
});

final SessionProvider =
    StateNotifierProvider<WaterIntakeNotifier, sessionBath>((ref) {
  final localStorageService = ref.watch(localStorageServiceProvider);
  return WaterIntakeNotifier(localStorageService);
});

class WaterIntakeNotifier extends StateNotifier<sessionBath> {
  final LocalStorageService _localStorageService;

  WaterIntakeNotifier(this._localStorageService) : super(sessionBath()) {
    _loadSession();
  }

  void _loadSession() async {
    state = await _localStorageService.getSession();
  }

  void increment() async {
    final updatedSession = sessionBath(
        duration: List.from(state.duration),
        timeStart: List.from(state.timeStart));

    state = updatedSession;
    await _localStorageService.saveSession(updatedSession);
  }
}
