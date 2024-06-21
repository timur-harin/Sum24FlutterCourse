import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'models/models.dart';

final sessionHistoryProvider = StateNotifierProvider<SessionHistoryNotifier, List<ShowerSession>>(
  (ref) => SessionHistoryNotifier(),
);

class SessionHistoryNotifier extends StateNotifier<List<ShowerSession>> {
  SessionHistoryNotifier() : super([]) {
    _loadSessions();
  }

  Future<void> _loadSessions() async {
    final box = await Hive.openBox<ShowerSession>('shower_sessions');
    state = box.values.toList();
  }

  Future<void> addSession(ShowerSession session) async {
    final box = await Hive.openBox<ShowerSession>('shower_sessions');
    await box.add(session);
    state = box.values.toList();
  }
}
