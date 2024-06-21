import 'package:education/templates/middleAssignment/session.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class SessionNotifier extends Notifier<List<Session>> {
  @override
  List<Session> build() {
    return [];
  }

  void addSession(Session session) {
    state = [...state, session];
  }

  void removeSession(Session session) {
    state = state.where((element) => element != session).toList();
  }

  void setSessions(List<Session> sessions) {
    state = sessions;
  }

  Session lastSession() {
    return state.last;
  }

  List<Session> getSessions() {
    return state;
  }
}

final finishedSessionNotifierProvider = NotifierProvider<SessionNotifier, List<Session>>(() {
  return SessionNotifier();
});