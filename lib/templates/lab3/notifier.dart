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
    state = await _localStorageService.getWaterIntake();
  }

  void increment(double amount) async {
    if(state+amount < 601){
      state += amount;
      await _localStorageService.saveWaterIntake(state);
    }
    
    
    
  }

  void reset() async {
    // TODO - reset state and save it into _localStorageService using saveWaterIntake
    state = 0.0;
      await _localStorageService.saveWaterIntake(state);
  }
}
