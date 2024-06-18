import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'local_storage.dart';

final localStorageServiceProvider = Provider<LocalStorageService>((ref) {
  return LocalStorageService();
});

final showerSessionProvider =
    StateNotifierProvider<ShowerSessionNotifier, List<String>>((ref) {
  final localStorageService = ref.watch(localStorageServiceProvider);
  return ShowerSessionNotifier(localStorageService);
});

class ShowerSessionNotifier extends StateNotifier<List<String>> {
  final LocalStorageService _localStorageService;

  ShowerSessionNotifier(this._localStorageService) : super(['Unknown', 'Unknown', 'Unknown']) {
    _ShowerSession();
  }

  void _ShowerSession() async {
    state = await _localStorageService.getShowerSession();
  }

  void reset(String duration, String minTemp, String maxTemp) async {
    await _localStorageService.saveShowerSession(duration, minTemp, maxTemp);
  }
}