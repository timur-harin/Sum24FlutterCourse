import 'package:flutter_riverpod/flutter_riverpod.dart';

final settingsStateProvider = StateProvider<Pair>((ref) {
  return Pair(0, 0);
});

class Pair {
  int first;
  int second;
  Pair(this.first, this.second);
}
