import 'package:flutter/material.dart';
import 'dart:async';

class ActiveSessionScreen extends StatelessWidget {
  final String currentPhase;
  final Duration initialRemainingTime1;
  final Duration initialRemainingTime2;
  final Function onSessionEnd;

  ActiveSessionScreen({
    required this.currentPhase,
    required this.initialRemainingTime1,
    required this.initialRemainingTime2,
    required this.onSessionEnd,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Active Session'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Current Temperature Phase: $currentPhase',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TimerWidget(
              initialDuration: initialRemainingTime1,
              timerName: 'Timer 1',
              onTimerFinished: onSessionEnd,
            ),
            SizedBox(height: 16),
            TimerWidget(
              initialDuration: initialRemainingTime2,
              timerName: 'Timer 2',
              onTimerFinished: onSessionEnd,
            ),
          ],
        ),
      ),
    );
  }
}

class TimerWidget extends StatefulWidget {
  final Duration initialDuration;
  final String timerName;
  final Function onTimerFinished;

  TimerWidget({
    required this.initialDuration,
    required this.timerName,
    required this.onTimerFinished,
  });

  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  late Duration _remainingTime;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _remainingTime = widget.initialDuration;
  }

  void _startTimer() {
    if (_timer == null) {
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          if (_remainingTime.inSeconds > 0) {
            _remainingTime -= Duration(seconds: 1);
          } else {
            _timer?.cancel();
            _timer = null;
            widget.onTimerFinished();
          }
        });
      });
    }
  }

  void _pauseTimer() {
    _timer?.cancel();
    _timer = null;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '${widget.timerName}: ${_remainingTime.inMinutes}:${(_remainingTime.inSeconds % 60).toString().padLeft(2, '0')}',
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _startTimer,
              child: Text('Start ${widget.timerName}'),
            ),
            SizedBox(width: 16),
            ElevatedButton(
              onPressed: _pauseTimer,
              child: Text('Pause ${widget.timerName}'),
            ),
          ],
        ),
      ],
    );
  }
}
