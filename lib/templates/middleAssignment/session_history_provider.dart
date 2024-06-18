import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'session_details.dart';

class SessionHistoryNotifier extends StateNotifier<List<SessionDetails>> {
  SessionHistoryNotifier() : super([]);

  void addSession(SessionDetails session) {
    state = [...state, session];
  }
}

final sessionHistoryProvider = StateNotifierProvider<SessionHistoryNotifier, List<SessionDetails>>((ref) {
  return SessionHistoryNotifier();
});
