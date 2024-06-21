import 'package:flutter/material.dart';
import 'dart:async';
import 'sessionsummary.dart';

class ActiveSessionScreen extends StatefulWidget {
  final int duration;
  final int interval;
  final int coldTemp;
  final int hotTemp;

  const ActiveSessionScreen({super.key, required this.duration, required this.interval, required this.coldTemp, required this.hotTemp});

  @override
  _ActiveSessionScreenState createState() => _ActiveSessionScreenState();
}

class _ActiveSessionScreenState extends State<ActiveSessionScreen> {
  late int _remainingTime;
  bool _isHot = true;
  bool _isPaused = false;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _remainingTime = widget.duration * 60;
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!_isPaused) {
        if (_remainingTime > 0) {
          setState(() {
            _remainingTime--;
            if ((_remainingTime % widget.interval) == 0) {
              _isHot = !_isHot;
            }
          });
        } else {
          _timer.cancel();
          _endSession();
        }
      }
    });
  }

  void _endSession() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => SessionSummaryScreen(duration: widget.duration),
      ),
    );
  }

  void _togglePause() {
    setState(() {
      _isPaused = !_isPaused;
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Widget _buildGradientButton(String text, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF58D0FE), Color(0xFFA262FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Active Session'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(seconds: 1),
              height: 250,
              width: 300,
              decoration: BoxDecoration(
                color: _isHot ? Colors.redAccent : Colors.blueAccent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  '${(_remainingTime ~/ 60).toString()}:${(_remainingTime % 60).toString().padLeft(2, '0')} Minutes left',
                  style: const TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildGradientButton(
                  _isPaused ? 'Resume the session' : 'Suspend a session',
                  _togglePause,
                ),
                const SizedBox(width: 20),
                _buildGradientButton(
                  'End the session',
                  () {
                    _timer.cancel();
                    _endSession();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
