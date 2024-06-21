import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'Constants.dart';
import 'ShowerSessionPreferences.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SharedPrefsProviderNotifier extends StateNotifier<List<String>> {
  SharedPrefsProviderNotifier() : super([]);
  var _showerSessionHistory = <String>[];
  static const sharedKey = "showerSessionHistory";

  get showerSessionHistory => _showerSessionHistory;

  Future loadShowerSessionHistory() async {
    final prefs = await SharedPreferences.getInstance();
    _showerSessionHistory = prefs.getStringList(sharedKey) ?? [];
  }
}

class ShowerSessionPrefsNotifier extends StateNotifier<ShowerSessionPreferences?> {
  ShowerSessionPrefsNotifier() : super(null);
  ShowerSessionPreferences? _showerSessionPrefs;

  ShowerSessionPreferences? getShowerSessionPrefs() {
    return _showerSessionPrefs;
  }

  void setShowerSessionPrefs(String initialPhase, int coldPhaseDuration, int hotPhaseDuration) {
    _showerSessionPrefs = ShowerSessionPreferences(initialPhase, coldPhaseDuration, hotPhaseDuration);
    state = _showerSessionPrefs;
  }
}

class InitialPhaseChooserNotifier extends StateNotifier<String> {
  InitialPhaseChooserNotifier() : super(defaultInitialPhase);
  String _initialShowerSessionPhase = defaultInitialPhase;

  String get initialShowerSessionPhase => _initialShowerSessionPhase;

  void setInitialShowerSessionPhase(String value) {
    _initialShowerSessionPhase = value;
    state = _initialShowerSessionPhase;
  }

}

class FeedbackNotifier extends StateNotifier<int> {
  FeedbackNotifier() : super(3);
  int _defaultRate = 3;

  int get defaultRate => _defaultRate;

  void setDefaultRate(int newValue) {
    _defaultRate = newValue;
    state = _defaultRate;
  }
}
