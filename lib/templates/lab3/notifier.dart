import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'storage.dart';

final localStorageServiceProvider = Provider<LocalStorageService>((ref) {
  return LocalStorageService();
});

final waterIntakeProvider =
    StateNotifierProvider<WaterIntakeNotifier, double>((ref) {
  final localStorageService = ref.watch(localStorageServiceProvider);
  return WaterIntakeNotifier(localStorageService);
});

class WaterIntakeNotifier extends StateNotifier<double> {
  final LocalStorageService _localStorageService;

  WaterIntakeNotifier(this._localStorageService) : super(0) {
    _loadWaterIntake();
  }

  void _loadWaterIntake() async {
    // TODO - Load the water intake from _localStorageService using await
    final waterIntake = await _localStorageService.getWaterIntake();
    state = waterIntake;
  }

  void increment(double amount) async {
    state += amount;
    await _localStorageService.saveWaterIntake(state);
    // TODO - Save the water intake into _localStorageService using saveWaterIntake
  }

  void reset() async {
    // TODO - reset state and save it into _localStorageService using saveWaterIntake
    state = 0;
    await _localStorageService.saveWaterIntake(state);

  }
}
