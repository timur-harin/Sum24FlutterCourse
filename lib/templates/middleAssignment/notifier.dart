import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'storage.dart';

final localStorageServiceProvider = Provider<LocalStorageService>((ref) {
  return LocalStorageService();
});

final showerSessionProvider =
    StateNotifierProvider<showerSessionNotifier, List<ShowerSession>>((ref) {
  final localStorageService = ref.watch(localStorageServiceProvider);
  return showerSessionNotifier(localStorageService);
});

class showerSessionNotifier extends StateNotifier<List<ShowerSession>> {
  final LocalStorageService _localStorageService;

  showerSessionNotifier(this._localStorageService) : super([]) {
    _loadSessions();
  }

  void _loadSessions() async {
    Future<void> loadSessions() async {
    state = await _localStorageService.getSessions();
    }
  }
}
