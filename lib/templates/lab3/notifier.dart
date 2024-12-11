import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'storage.dart';

const double maxLevel = 2000.0;
const int stepNumber = 20;

final localStorageServiceProvider = Provider<LocalStorageService>((ref) {
  return LocalStorageService();
});

final waterIntakeProvider =
    StateNotifierProvider<WaterIntakeNotifier, double>((ref) {
  final localStorageService = ref.watch(localStorageServiceProvider);
  return WaterIntakeNotifier(localStorageService,
      maxLevel: maxLevel, steps: stepNumber);
});

class WaterIntakeNotifier extends StateNotifier<double> {
  final double maxLevel;
  late double _step;

  final LocalStorageService _localStorageService;

  WaterIntakeNotifier(this._localStorageService,
      {required int steps, this.maxLevel = 100.0})
      : super(0.0) {
    _step = (steps > 0.0) ? maxLevel / steps : maxLevel;
    _loadWaterIntake();
  }

  void _loadWaterIntake() async {
    state = await _localStorageService.getWaterIntake();
  }

  void increment() async {
    if (state < maxLevel) {
      state += _step;
      if (maxLevel - state < .0001) {
        state = maxLevel;
      }
    }
    _localStorageService.saveWaterIntake(state);
  }

  void reset() async {
    state = 0.0;
    _localStorageService.saveWaterIntake(state);
  }
}
