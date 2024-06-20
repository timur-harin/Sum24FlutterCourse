import 'package:flutter/material.dart';
import 'dart:async';
import 'HistoryScreen.dart';
import 'SessionSummary.dart';

abstract class Phase {
  int get duration;
}

class HotPhase implements Phase {
  @override
  final int duration;
  HotPhase(this.duration);
}

class ColdPhase implements Phase {
  @override
  final int duration;
  ColdPhase(this.duration);
}

mixin PhaseManagement on StatefulWidget {
  late Phase currentPhase;
  late bool isHotPhase;

  void updatePhase(ShowerSession session) {
    isHotPhase = session.isHotPhase;
    currentPhase = isHotPhase 
        ? HotPhase(session.preferences.hotWaterDuration)
        : ColdPhase(session.preferences.coldWaterDuration);
  }

  void switchPhase(ShowerSession session) {
    isHotPhase = !isHotPhase;
    session.phasesCompleted++;
    updatePhase(session);
  }
}

class UserPreferences {
  final int sessionDuration;
  final int hotWaterDuration;
  final int coldWaterDuration;
  final bool startWithHotWater;

  UserPreferences({
    required this.sessionDuration,
    required this.hotWaterDuration,
    required this.coldWaterDuration,
    required this.startWithHotWater,
  });
}

class ShowerSession {
  final UserPreferences preferences;
  int phasesCompleted = 0;
  bool _hotPhase;

  ShowerSession(this.preferences)
      : _hotPhase = preferences.startWithHotWater ? true : false;


  int get phaseDuration => _hotPhase 
      ? preferences.hotWaterDuration 
      : preferences.coldWaterDuration;
  
  bool get isHotPhase => _hotPhase;
}

class SessionScreen extends StatefulWidget with PhaseManagement {
  final UserPreferences preferences;

  SessionScreen({required this.preferences});

  @override
  _SessionScreenState createState() => _SessionScreenState();
}

class _SessionScreenState extends State<SessionScreen> {
  Timer? _timer;
  int _elapsedTime = 0;
  int _phaseElapsedTime = 0;
  bool _sessionStarted = false;
  bool _isPaused = false;
  late ShowerSession _session;
  SessionHistory historyScreen = SessionHistory();
  int _phaseTimer = 0;
  @override
  void initState() {
    super.initState();
    _session = ShowerSession(widget.preferences);
    widget.updatePhase(_session);
    _phaseTimer = widget.currentPhase.duration;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _switchPhase() {
    setState(() {
      widget.switchPhase(_session);
      _phaseTimer = widget.currentPhase.duration;
    });
  }

  void _phaseTimerHandler() {
    if (_phaseElapsedTime >= widget.currentPhase.duration) {
      _switchPhase();
      _phaseElapsedTime = 0;
    }
  }

  void _startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer?.cancel();

    _timer = Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          _elapsedTime++;
          _phaseElapsedTime++;
          _phaseTimer = widget.currentPhase.duration - _phaseElapsedTime;
          _phaseTimerHandler();
          if (_elapsedTime >= widget.preferences.sessionDuration) {
            _stopSession();
          }
        },
      ),
    );
  }

  void _startSession() {
    setState(() {
      _sessionStarted = true;
      _startTimer();
    });
  }

  void _stopSession() {
    _timer?.cancel();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SessionSummary(session: _session),
      ),
    );
  }

  void _pauseOrResumeTimer() {
    if (_isPaused) {
      _startTimer();
    } else {
      _timer?.cancel();
    }
    setState(() {
      _isPaused = !_isPaused;
    });
  }

  @override
  Widget build(BuildContext context) {
    int minutes = _elapsedTime ~/ 60;
    int seconds = _elapsedTime % 60;
    int phaseTimerMinutes = _phaseTimer ~/ 60;
    int phaseTimerSeconds = _phaseTimer % 60;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Session Screen'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 1.0,
            colors: [
              Colors.white,
              widget.isHotPhase ? Colors.red : Colors.blue,
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Session Duration: ${widget.preferences.sessionDuration}",
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
              Text(
                "Hot Water Duration: ${widget.preferences.hotWaterDuration}",
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
              Text(
                "Cold Water Duration: ${widget.preferences.coldWaterDuration}",
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
              Text(
                widget.preferences.startWithHotWater ? 'Start with Hot Water' : 'Start with Cold Water',
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                '${phaseTimerMinutes}m ${phaseTimerSeconds}s',
                style: TextStyle(
                  fontSize: 50.0,
                  color: widget.isHotPhase ? Colors.red : Colors.blue,
                ),
              ),
              Text(
                'Time passed: ${minutes}m ${seconds}s',
                style: const TextStyle(fontSize: 24),
              ),
              ElevatedButton(
                onPressed: _sessionStarted ? null : _startSession,
                child: const Text('Start Session', 
                style: TextStyle(color: Colors.amber),),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _sessionStarted ? _pauseOrResumeTimer : null,
                child: Text(_isPaused ? 'Resume Timer' : 'Pause Timer', 
                style: const TextStyle(color: Colors.amber),),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _sessionStarted ? _stopSession : null,
                child: const Text('End Session', 
                style: TextStyle(color: Colors.amber),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
