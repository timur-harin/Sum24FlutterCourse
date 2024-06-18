import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'SessionSummaryScreen.dart';
import 'session_details.dart';
import 'session_history_provider.dart';

enum SessionPhase {
  Hot,
  Cold,
}

enum Pause {
  On,
  Off,
}

class SessionScreen extends ConsumerStatefulWidget {
  final int duration;
  final int interval;
  final SessionPhase startPhase;

  SessionScreen({
    required this.duration,
    required this.interval,
    required this.startPhase,
  });

  @override
  _SessionScreenState createState() => _SessionScreenState();
}

class _SessionScreenState extends ConsumerState<SessionScreen> {
  late SessionPhase _currentPhase;
  Timer? _timer;
  int _remainingSessionTime = 0;
  int _remainingIntervalTime = 0;
  int _totalPhases = 0;
  String _timerText = '';
  DateTime _currentDate = DateTime.now();
  Pause _currentState = Pause.Off;

  @override
  void initState() {
    super.initState();
    _currentPhase = widget.startPhase; // Correctly initialize the current phase
    _remainingSessionTime = widget.duration * 60;
    _remainingIntervalTime = widget.interval * 60;
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingSessionTime > 0) {
          _remainingSessionTime--;
          _remainingIntervalTime--;

          if (_remainingIntervalTime <= 0) {
            _togglePhase();
          }

          int minutes = _remainingSessionTime ~/ 60;
          int seconds = _remainingSessionTime % 60;
          _timerText = '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
        } else {
          _timer?.cancel();
          _endSession();
        }
      });
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    setState(() {
      _currentState = Pause.On;
    });
  }

  void _resumeTimer() {
    _startTimer();
    setState(() {
      _currentState = Pause.Off;
    });
  }

  void _togglePhase() {
    setState(() {
      _currentPhase = _currentPhase == SessionPhase.Hot ? SessionPhase.Cold : SessionPhase.Hot;
      _remainingIntervalTime = widget.interval * 60;
      _totalPhases++;
    });
  }

  void handlePause() {
    if (_currentState == Pause.Off) {
      _stopTimer();
    } else {
      _resumeTimer();
    }
  }

  void _endSession() {
    final sessionDetails = SessionDetails(
      totalTime: widget.duration * 60,
      totalPhases: _totalPhases,
      sessionDateTime: _currentDate,
    );

    ref.read(sessionHistoryProvider.notifier).addSession(sessionDetails);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => SessionSummaryScreen(
          totalTime: sessionDetails.totalTime,
          totalPhases: sessionDetails.totalPhases,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Session'),
      ),
      body: AnimatedContainer(
        duration: Duration(seconds: 1),
        color: _currentPhase == SessionPhase.Hot ? Color.fromRGBO(230, 102, 93, 1) : Color.fromRGBO(157, 213, 235, 1),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Text(
                _timerText,
                style: TextStyle(fontSize: 48, color: Colors.white),
              ),
              SizedBox(height: 20),
              Text(
                _currentPhase == SessionPhase.Hot ? 'Hot Phase' : 'Cold Phase',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
              SizedBox(height: 30),
              IconButton(
                onPressed: handlePause,
                icon: Icon(_currentState == Pause.Off ? Icons.pause : Icons.play_arrow_sharp, size: 40,),
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
