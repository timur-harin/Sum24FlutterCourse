// riverpod Providers
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DurationState extends StateNotifier<int> {
  DurationState() : super(0);

  void setState(int value) {
    state = value;
  }
}

final durationProvider = StateNotifierProvider<DurationState, int>((ref) {
  return DurationState();
});