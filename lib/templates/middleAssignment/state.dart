import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'models/temperature_phase.dart';
import 'models/shower_session.dart';

class AppState extends StateNotifier<List<ShowerSession>> {
  AppState() : super([]);

  void addSession(ShowerSession session) {
    state = [...state, session];
  }

  List<ShowerSession> get sessionHistory => state;
}

final appStateProvider = StateNotifierProvider<AppState, List<ShowerSession>>(
  (ref) => AppState(),
);
