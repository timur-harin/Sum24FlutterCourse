// riverpod Providers
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TempretureState extends StateNotifier<String> {
  TempretureState() : super("Cold Now");

  void setState(String value) {
    state = value;
  }

  String switchState() {
    if (state == "Cold Now") {
      state = "Hot Now";
    } else {
      state = "Cold Now";
    }
    return state;
  }
}

final tempretureProvider = StateNotifierProvider<TempretureState, String>((ref) {
  return TempretureState();
});