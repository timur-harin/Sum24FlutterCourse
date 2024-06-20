import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShowerSession {
  final DateTime date;
  final int hotDuration;
  final int coldDuration;
  final int totalDuration;

  ShowerSession({
    required this.date,
    required this.hotDuration,
    required this.coldDuration,
    required this.totalDuration,
  });
}

class SessionHistoryNotifier extends StateNotifier<List<ShowerSession>> {
  SessionHistoryNotifier() : super([]);

  void addSession(ShowerSession session) {
    state = [...state, session];
  }
}

final sessionHistoryProvider = StateNotifierProvider<SessionHistoryNotifier, List<ShowerSession>>((ref) {
  return SessionHistoryNotifier();
});

final addSessionProvider = Provider((ref) {
  return (ShowerSession session) {
    ref.read(sessionHistoryProvider.notifier).addSession(session);
  };
});
