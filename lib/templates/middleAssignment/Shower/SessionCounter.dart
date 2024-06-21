import 'package:flutter_riverpod/flutter_riverpod.dart';

final totalSessionTimeProvider = StateNotifierProvider<TotalSessionTimeNotifier, int>((ref) {
  return TotalSessionTimeNotifier();
});

class TotalSessionTimeNotifier extends StateNotifier<int> {
  TotalSessionTimeNotifier() : super(0);

  void addTime(int time) {
    state += time;
  }

  void removeTime(int time) {
    state -= time;
  }
}
