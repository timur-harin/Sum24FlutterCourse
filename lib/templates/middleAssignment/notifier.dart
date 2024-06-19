import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'storage.dart';
import 'shower_procedure.dart';

final localStorageServiceProvider = Provider<LocalStorageService>((ref) {
  return LocalStorageService();
});

final showerProceduresProvider =
    StateNotifierProvider<ShowerProceduresNotifier, double>((ref) {
  final localStorageService = ref.watch(localStorageServiceProvider);
  return ShowerProceduresNotifier(localStorageService);
});

class ShowerProceduresNotifier extends StateNotifier<double> {
  final LocalStorageService _localStorageService;

  ShowerProceduresNotifier(this._localStorageService) : super(0) {
    _loadHistory();
  }

  void _loadHistory() async {
    state = (await _localStorageService.getDayFromHistory(state.toInt())) as double;
  }

  void addNewShowerProcedure(ShowerProcedure procedure) async {
    state += 1;
    await _localStorageService.saveHistory(procedure, state.toInt());
  }

  void reset() async {
    state = 0.0;
    await _localStorageService.saveHistory(ShowerProcedure(cold_duration: 0.0, hot_duration:  0.0), 1);
  }
}
