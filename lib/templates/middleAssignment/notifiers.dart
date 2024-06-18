import 'package:education/templates/middleAssignment/models/session_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'widgets.dart';
import 'local_storage.dart';


final localStorageServiceProvider = Provider<LocalStorageService>((ref) {
  return LocalStorageService();
});

final showerSessionsProvider = ChangeNotifierProvider<ShowerSessionsNotifier>((ref) {
  final localStorageService = ref.watch(localStorageServiceProvider);
  return ShowerSessionsNotifier(localStorageService);
});


class ShowerSessionsNotifier with ChangeNotifier {
  final List<ShowerSessionWidget> _sessions = [];
  List<ShowerSessionWidget> get sessions => _sessions;
  final LocalStorageService _localStorageService;

  ShowerSessionsNotifier(this._localStorageService);

  void addSession() {
    _localStorageService.addSession(id: _sessions.length.toString());
    _sessions.add(ShowerSessionWidget(_sessions.length.toString()));
    notifyListeners();
  }

  Session getSession({required id}) {
   return _localStorageService.getSession(id: id);
  }
}