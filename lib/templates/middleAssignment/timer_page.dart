import 'dart:async';
import 'package:education/templates/middleAssignment/results_page.dart';
import 'package:flutter/material.dart';
import 'preferences_page.dart';
import 'package:audioplayers/audioplayers.dart';
import 'notifier.dart';

class TimerPage extends StatefulWidget {
  final PreferencesState preferencesState;
  const TimerPage({Key? key, required this.preferencesState}) : super(key: key);
  @override
  TimerPageState createState() => TimerPageState(preferencesState: PreferencesState(preferencesState.duration, preferencesState.minTemp, preferencesState.maxTemp));
}

class TimerPageState extends State<TimerPage> {
  Color _backgroundColor = const Color.fromARGB(213, 255, 82, 82);
  final PreferencesState preferencesState;
  late int _minutes;
  late int _seconds;
  late int _secondsCopy;
  late int _minutesCopy;
  int secondsLeft = 0;
  bool _isRunning = false;
  bool _isPaused = true;
  bool _isHide = false;


  Timer? _timer;

  TimerPageState({required this.preferencesState}) {
    _minutes = preferencesState.duration;
    _seconds = 0;
    _secondsCopy = _seconds;
    _minutesCopy = _minutes;
  }
  

  void _pauseTimer() {
    _isPaused = true;
    _isRunning = false;
    setState(() => _timer?.cancel());
  }

  void _resumeTimer() {
    _isRunning = true;
    _isPaused = false;
  }

  void _toResultScreen() {
    _isPaused = true;
    _isRunning = false;
    setState(() => _timer?.cancel());
    
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context)
       => ResultsPage(timerPageState:
        TimerPageState(preferencesState:
         PreferencesState(preferencesState.duration,
          preferencesState.minTemp,
           preferencesState.maxTemp)), secondsLeft: secondsLeft,),
      ),
    );
  }

  void playSound() async {
    final player = AudioPlayer();
    await player.play('assets/Sound_11084.wav');
  }

  void _startTimer() {
    _isRunning = true;
    _isPaused = false;
    _isHide = true;
    Timer.periodic(const Duration(seconds: 1), (timer)  {
      if (!_isPaused) {
      if (secondsLeft == (_minutes * 60) ~/ 2) {
          setState(() {
            _backgroundColor = const Color.fromARGB(209, 68, 137, 255);
          });
          playSound();
        }
        if (_secondsCopy == 0 && _minutesCopy != 0) {
          setState(() {
            _minutesCopy--;
            _secondsCopy = 59;
            setState(() {
              secondsLeft++;
            });
          });
        } else if (_minutesCopy == 0 && _secondsCopy == 0) {
          _toResultScreen();
        } else if (_secondsCopy > 0) {
          setState(() {
            secondsLeft++;
            _secondsCopy--;
          });
        } 
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        title: const Text('Session'),
        backgroundColor: const Color.fromARGB(255, 62, 160, 185),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            Text(
              '${_minutesCopy.toString().padLeft(2,'0')}:${_secondsCopy.toString().padLeft(2, '0')}',
              style: const TextStyle(fontSize: 50),
              
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _isRunning || _isHide ? _toResultScreen : _startTimer,
                  child: Text(_isRunning || _isHide ? 'Stop': 'Start'),
                ),
                ElevatedButton(
                  onPressed: _isRunning ? _pauseTimer : _resumeTimer,
                  child: Text(_isPaused ? 'Resume' : 'Pause'),
                ),
              ],
            ),
          ],
        )
      ),
    );
  }
}

