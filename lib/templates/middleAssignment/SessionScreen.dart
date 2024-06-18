import 'package:flutter/material.dart';
import 'dart:async';
import 'HistoryScreen.dart';
import 'SessionSummary.dart';

class SessionScreen extends StatefulWidget {
  final int sessionDuration;
  final int hotWaterDuration;
  final int coldWaterDuration;
  final bool startWithHotWater;
  int phasesCompleted = 0;
  SessionScreen({
    required this.sessionDuration,
    required this.hotWaterDuration,
    required this.coldWaterDuration,
    required this.startWithHotWater,
  });

  @override
  _SessionScreenState createState() => _SessionScreenState();
}

class _SessionScreenState extends State<SessionScreen> {
  Timer? _timer;
  int _start = 0;
  int _phaseTime = 0;
  bool _sessionStarted = false;
  late bool _hotPhase;
  late int _phaseDuration;
  bool _isPaused = false;
  SessionHistory historyScreen = SessionHistory();
  int _phaseTimer = 0;
  @override
  void initState() {
    super.initState();
    _hotPhase = widget.startWithHotWater;
    _phaseDuration = _hotPhase ? widget.hotWaterDuration : widget.coldWaterDuration;
    _phaseTimer =  _phaseDuration;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _switchPhase() {
    setState(() {
      _hotPhase = !_hotPhase;
      _phaseDuration = _hotPhase ? widget.hotWaterDuration : widget.coldWaterDuration;
      widget.phasesCompleted++;
    });
  }

  void phaseTimer() {
    if (_phaseTime >= _phaseDuration) {
      _switchPhase();
      _phaseTime = 0;
    }
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer?.cancel();
    
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          _start++;
          _phaseTime++;
          _phaseTimer =  _phaseDuration - _phaseTime;
          phaseTimer();
          if (_start >= widget.sessionDuration) {
            _stopSession();
          }
        },
      ),
    );
  }

  void _startSession() {
    setState(() {
      _sessionStarted = true;
      startTimer();
    });
  }

  void _stopSession() {
    _timer?.cancel();
    SessionScreen session = SessionScreen(
      sessionDuration: widget.sessionDuration,
      hotWaterDuration: widget.hotWaterDuration,
      coldWaterDuration: widget.coldWaterDuration,
      startWithHotWater: widget.startWithHotWater,
    );
    historyScreen.addSession(session);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SummaryScreen(session: session)),
    );
  } 

  void _pauseOrResumeTimer() {
    if (_isPaused) {
      startTimer();
    } else {
      _timer?.cancel();
    }
    setState(() {
      _isPaused = !_isPaused;
    });
  }

  @override
  Widget build(BuildContext context) {
    int minutes = _start ~/ 60;
    int seconds = _start % 60;
    int phaseTimerMinutes = _phaseTimer ~/ 60;
    int phaseTimerSeconds = _phaseTimer % 60;
    return Scaffold(
      appBar: AppBar(
        title: Text('Session Screen'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 1.0,
            colors: [
              Colors.white,
              _hotPhase ? Colors.red : Colors.blue,
            ],
          ),
        ),
        child: Center(
          child: Column (
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
              "Session Duration: ${widget.sessionDuration}",
              style: const TextStyle(
                fontSize: 16.0,
                color: Colors.black,
              ),
              ),
              Text(
                "Hot Water Duration: ${widget.hotWaterDuration}",
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
              Text(
                "Cold Water Duration: ${widget.coldWaterDuration}",
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
              Text(widget.startWithHotWater ? 'Start with Hot Water' : 'Start with Cold Water',
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              Text(
                '${phaseTimerMinutes}m ${phaseTimerSeconds}s',
                style: TextStyle(
                  fontSize: 50.0,
                  color: _hotPhase ? Colors.red : Colors.blue,
                ),
              ),
              Text(
                'Time passed: ${minutes}m ${seconds}s',
                style: TextStyle(fontSize: 24),
              ),
              ElevatedButton(
                onPressed: _sessionStarted ? null : _startSession,
                child: Text('Start Session'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: _sessionStarted ? _pauseOrResumeTimer : null,
                child: Text(_isPaused ? 'Resume Timer' : 'Pause Timer'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: _sessionStarted ? _stopSession : null,
                child: Text('End Session'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
