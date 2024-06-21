import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ShowerSession.dart';
import 'ShowerSessionProvider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ShowerTimerProvider with ChangeNotifier {
  Duration _currentDuration = Duration(seconds: 10);
  Timer? _timer;
  String _startPhase = 'Hot';
  int _repetitions = 1;
  int _duration = 10;
  int _currentRepetition = 0;
  String _currentPhase = 'Hot';
  bool _isPaused = false;
  final GlobalKey<NavigatorState> navigatorKey;
  int _completedRepetitions = 0;
  int _totalDuration = 0;

  ShowerTimerProvider(this.navigatorKey);

  String get startPhase => _startPhase;
  Duration get currentDuration => _currentDuration;
  String get currentPhase => _currentPhase;
  bool get isPaused => _isPaused;
  int get completedRepetitions => _completedRepetitions;
  int get totalDuration => _totalDuration;

  void setStartPhase(String phase) {
    _startPhase = phase;
    notifyListeners();
  }

  void setRepetitions(int repetitions) {
    _repetitions = repetitions;
    notifyListeners();
  }

  void setDuration(int duration) {
    _duration = duration;
    _currentDuration = Duration(seconds: duration);
    notifyListeners();
  }

  void startShower() {
    _currentRepetition = 0;
    _completedRepetitions = 0;
    _totalDuration = 0;
    _currentPhase = _startPhase;
    _currentDuration = Duration(seconds: _duration);
    _isPaused = false;
    notifyListeners();
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_isPaused) return;

      if (_currentDuration.inSeconds > 0) {
        _currentDuration -= Duration(seconds: 1);
        _totalDuration++;
        notifyListeners();
      } else {
        _currentRepetition++;

        if (_currentRepetition % 2 == 0) {
          _completedRepetitions++;
        }

        if (_completedRepetitions >= _repetitions) {
          _currentRepetition = 0;
          showFinishMenu(navigatorKey.currentContext!);
          timer.cancel();
          return;
        }

        _currentPhase = (_currentPhase == 'Hot') ? 'Cold' : 'Hot';
        _currentDuration = Duration(seconds: _duration);
        notifyListeners();
      }
    });
  }

  void togglePauseResume() {
    _isPaused = !_isPaused;
    notifyListeners();
  }

  void cancelShower() {
    _timer?.cancel();
    _isPaused = false;
    showFinishMenu(navigatorKey.currentContext!, isCancelled: true);
    notifyListeners();
  }

  void showFinishMenu(BuildContext context, {bool isCancelled = false}) {
    int _rating = 0;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(isCancelled ? 'Shower session cancelled!' : 'Shower session finished!'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Completed Repetitions: $_completedRepetitions'),
              Text('Total Duration: $_totalDuration seconds'),
              SizedBox(height: 20),
              Text('Rate this session:'),
              RatingBar.builder(
                initialRating: 0,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  _rating = rating.toInt();
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final sessionProvider = Provider.of<ShowerSessionProvider>(
                    context,
                    listen: false,
                  );

                  final session = ShowerSession(
                    startPhase: _startPhase,
                    repetitions: _repetitions,
                    completedRepetitions: _completedRepetitions,
                    totalDuration: _totalDuration,
                    timestamp: DateTime.now(),
                    rating: _rating,
                  );

                  sessionProvider.addSession(session);

                  _rating = 0;
                  Navigator.popUntil(context, ModalRoute.withName('/'));
                },
                child: Text('Return to Main Menu'),
              ),
            ],
          ),
        );
      },
    );
  }

  void showSessionSummary(BuildContext context) {
    final sessionProvider =
        Provider.of<ShowerSessionProvider>(context, listen: false);

    final session = ShowerSession(
      startPhase: _startPhase,
      repetitions: _repetitions,
      completedRepetitions: _completedRepetitions,
      totalDuration: _totalDuration,
      timestamp: DateTime.now(),
      rating: 0,
    );

    sessionProvider.addSession(session);

    Navigator.popUntil(context, ModalRoute.withName('/'));
  }
}
