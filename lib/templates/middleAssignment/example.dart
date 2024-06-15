import 'package:flutter/material.dart';
import 'dart:async';

void main() => runApp(TimerApp());

class TimerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TimerPage(),
    );
  }
}

class TimerPage extends StatefulWidget {
  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  int _remainingSeconds = 10; // Initial timer value in seconds
  bool _isRunning = false;
  bool _isPaused = false;
  Timer? _timer;

  void _startOrResumeTimer() {
    _isRunning = true;
    _isPaused = false;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        _stopTimer();
      }
    });
  }

  void _pauseTimer() {
    _isRunning = false;
    _isPaused = true;
    _timer?.cancel();
  }

  void _stopTimer() {
    _isRunning = false;
    _isPaused = true;
    _timer?.cancel();
    // Optionally, reset the timer or perform other actions upon stopping
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pausable Timer')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Time Remaining: $_remainingSeconds seconds',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isRunning || _isPaused? _pauseTimer : _startOrResumeTimer,
              child: Text(_isPaused? 'Resume' : 'Start'),
            ),
            ElevatedButton(
              onPressed: _isRunning? _pauseTimer : _startOrResumeTimer,
              child: Text('Pause'),
            ),
            ElevatedButton(
              onPressed: _stopTimer,
              child: Text('Stop'),
            ),
          ],
        ),
      ),
    );
  }
}
