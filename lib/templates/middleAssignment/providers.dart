import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import 'data.dart';

const _uuid = Uuid();

class SessionList extends StateNotifier<List<Session>> {
  SessionList(List<Session>? initialSessions) : super(initialSessions ?? []);

  void add() {
    state = [
      ...state,
      Session(
        id: _uuid.v4(),
        startTime: DateTime.now(),
      ),
    ];
  }

  void delete(String id) {
    final newList = state.where((session) => session.id != id).toList();
    state = newList;
  }
}

final sessionListProvider = StateNotifierProvider<SessionList, List<Session>>((ref) {
  return SessionList(const []);
});

void add(WidgetRef ref) {
  ref.read(sessionListProvider.notifier).add();
}

void delete(WidgetRef ref, String id) { 
  ref.read(sessionListProvider.notifier).delete(id);
}