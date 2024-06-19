// riverpod Providers
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CyclesState extends StateNotifier<int> {
  CyclesState() : super(0);

  void setState(int value) {
    state = value;
  }

  int getState() {
    return state;
  }
}

final cyclesProvider = StateNotifierProvider<CyclesState, int>((ref) {
  return CyclesState();
});