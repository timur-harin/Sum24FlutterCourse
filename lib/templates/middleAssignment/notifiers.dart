import 'package:education/templates/middleAssignment/models/session_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'widgets.dart';
import 'local_storage.dart';
import 'package:pausable_timer/pausable_timer.dart';


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

  void addSession({required String duration, required int phasesNum}) {
    _localStorageService.addSession(id: _sessions.length.toString(), duration: duration, phasesNum: phasesNum);
    _sessions.add(ShowerSessionWidget(_sessions.length.toString()));
    notifyListeners();
  }

  Session getSession({required id}) {
   return _localStorageService.getSession(id: id);
  }
}

final startPhaseProvider = ChangeNotifierProvider<StartPhaseNotifier>((ref) {
  return StartPhaseNotifier();
});

class StartPhaseNotifier with ChangeNotifier {
  bool _isHotDisabled;
  bool get isHotDisabled => _isHotDisabled;


  StartPhaseNotifier() : _isHotDisabled = false;

  void switchPhase() {
    _isHotDisabled = !_isHotDisabled;
    notifyListeners();
  }
}

final currentPhaseProvider = ChangeNotifierProvider<CurrentPhaseNotifier>((ref) {
  return CurrentPhaseNotifier(ref.watch(startPhaseProvider).isHotDisabled);
});

class CurrentPhaseNotifier with ChangeNotifier {
  bool _isHotDisabled;
  bool get isHotDisabled => _isHotDisabled;


  CurrentPhaseNotifier(this._isHotDisabled);

  void switchPhase() {
    _isHotDisabled = !_isHotDisabled;
  }
}

DateTime _timePickerTime = DateTime(0);
final timePickerTimeProvider = StateProvider<DateTime>((ref) {
  return _timePickerTime;
});

final _textInputController = TextEditingController();
final textInputControllerProvider = StateProvider<TextEditingController>((ref) {
  return _textInputController;
});


final timerProvider = ChangeNotifierProvider<TimerNotifier>((ref) {
  return TimerNotifier();
});

class TimerNotifier with ChangeNotifier {
  late PausableTimer _timer;
  int timerValue = 0;
  int totalTime = 0;
  bool _onPause = true;


  void initializeTimer({required int phasesNum, required int phaseTime}) async {
    int _timeLeft = phaseTime;
    timerValue = phaseTime;

    _timer = PausableTimer.periodic(
        const Duration(seconds: 1),
        () {
          if (_timeLeft == 0) {
            if (phasesNum > 1) {
              _timer.cancel();
              initializeTimer(phasesNum: phasesNum - 1, phaseTime: phaseTime);
              _onPause = true;
              startTimer();
            } else {
              _timer.cancel();
            }
          } else {
            _timeLeft--;
            totalTime++;
            timerValue = _timeLeft;
            notifyListeners();
          }
        }
    );
  }

  void startTimer() {
    print(_onPause);
    if (_onPause) {
      print("object");
      _onPause = false;
      _timer.start();
    }
  }

  void pauseTimer() {
    _onPause = true;
    _timer.pause();
  }

  void stopTimer() {
    _onPause = true;
    _timer.pause();
    _timer.cancel();
  }
}

