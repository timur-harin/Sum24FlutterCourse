import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'local_storage_service.dart';

/// Provider for the LocalStorageService instance.
final localStorageServiceProvider = Provider<LocalStorageService>((ref) {
  return LocalStorageService();
});

/// Provider for managing the history state using StateNotifier.
final historyProvider =
StateNotifierProvider<HistoryNotifier, List<String>>((ref) {
  final localStorageService = ref.watch(localStorageServiceProvider);
  return HistoryNotifier(localStorageService);
});

/// StateNotifier class for managing the history state.
class HistoryNotifier extends StateNotifier<List<String>> {
  final LocalStorageService _localStorageService;

  /// Constructor for HistoryNotifier.
  ///
  /// @param _localStorageService The LocalStorageService instance.
  HistoryNotifier(this._localStorageService) : super([]) {
    _loadHistory();
  }

  /// Loads the history from local storage.
  void _loadHistory() async {
    state = await _localStorageService.getHistory();
  }

  /// Adds a new session to the history.
  ///
  /// @param sessionInfo The information of the session to add.
  void addSession(String sessionInfo) async {
    state = [...state, sessionInfo];
    await _localStorageService.saveHistory(state);
  }
}
