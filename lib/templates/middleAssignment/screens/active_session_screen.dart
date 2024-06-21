import 'package:flutter/material.dart';
import '../models/models.dart';

class ActiveSessionScreen extends StatefulWidget {
  final ShowerSession session;

  ActiveSessionScreen(this.session);

  @override
  _ActiveSessionScreenState createState() => _ActiveSessionScreenState();
}

class _ActiveSessionScreenState extends State<ActiveSessionScreen> {
  late int _remainingTime;
  late String _currentPhase;
  int _currentPhaseIndex = 0;
  bool _isPaused = false;

  @override
  void initState() {
    super.initState();
    _startPhase();
  }

  void _startPhase() {
    setState(() {
      _currentPhase = widget.session.phases[_currentPhaseIndex].phase;
      _remainingTime = widget.session.phases[_currentPhaseIndex].duration;
    });

    Future.delayed(Duration(seconds: 1), _tick);
  }

  void _tick() {
    if (_isPaused) return;

    if (_remainingTime > 0) {
      setState(() {
        _remainingTime--;
      });
      Future.delayed(Duration(seconds: 1), _tick);
    } else {
      _currentPhaseIndex++;
      if (_currentPhaseIndex < widget.session.phases.length) {
        _startPhase();
      } else {
        Navigator.pop(context);
      }
    }
  }

  void _pause() {
    setState(() {
      _isPaused = !_isPaused;
      if (!_isPaused) {
        _tick();
      }
    });
  }

  void _endSession() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Active Session'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _currentPhase,
                    style: TextStyle(fontSize: 24, color: _currentPhase == 'Hot' ? Colors.red : Colors.blue),
                  ),
                  Text(
                    'Time remaining: $_remainingTime seconds',
                    style: TextStyle(fontSize: 24),
                  ),
                ],
              ),
            ),
          ),
          ElevatedButton(
            onPressed: _pause,
            child: Text(_isPaused ? 'Resume' : 'Pause'),
          ),
          ElevatedButton(
            onPressed: _endSession,
            child: Text('End Session'),
          ),
        ],
      ),
    );
  }
}
