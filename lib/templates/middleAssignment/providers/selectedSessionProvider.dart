
import 'package:education/templates/middleAssignment/session.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectedSessionNotifier extends Notifier<Session> {
  @override
  Session build() {
    return state;
  }

  void setSession(Session session) {
    state = session;
  }
}


final selectedSessionNotifierProvider = NotifierProvider<SelectedSessionNotifier, Session>((){
  return SelectedSessionNotifier();
});