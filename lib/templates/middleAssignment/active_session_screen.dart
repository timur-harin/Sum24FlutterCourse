import 'dart:async';
import 'package:education/templates/middleAssignment/session_summary_screen.dart';
import 'package:flutter/material.dart';



class ActiveSessionScreen extends StatefulWidget {
  final double temp;
  final double tempCold;
  final int timeCold;
  final int timeHot;
  final int countHot;
  final int countCold;
  final int time;

  const ActiveSessionScreen({
     super.key,
    required this.temp,
    required this.tempCold,
    required this.timeCold,
    required this.timeHot,
    required this.countHot,
    required this.countCold,
    required this.time,
  });

  @override
  _ActiveSessionScreenState createState() => _ActiveSessionScreenState();
}

class _ActiveSessionScreenState extends State<ActiveSessionScreen> {
  Timer? _timer;
  int _seconds = 0;
  bool _isRunning = false;
  bool _isPaused = false;
  bool _isHot = true;
  int _remainingHotIntervals = 0;
  int _remainingColdIntervals = 0;
  double _HotTemp = 0;
  double _ColdTemp = 0;
  int _totalTime = 0;

  @override
  void initState() {
    super.initState();
    _remainingHotIntervals = widget.countHot;
    _remainingColdIntervals = widget.countCold;
    _HotTemp = widget.temp;
    _ColdTemp = widget.tempCold;
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: _isHot? const AssetImage('assets/red_temp.png') : const AssetImage('assets/blue_temp.png'), width: 150, height: 150,),
            const SizedBox(height: 20),
            Text(
              _formatDuration(_seconds),
              style: const TextStyle(fontSize: 90, fontWeight: FontWeight.bold, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            Text(_isHot? '$_HotTemp°C' : '$_ColdTemp°C', 
            style: const TextStyle(
                color: Colors.grey,
                fontSize: 65,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.grey,
                    fixedSize: const Size(120, 60),
                  ),
                  onPressed: _isRunning? null : _startTimer,
                  child: const Text(
                    'Start',
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.grey ,
                    fixedSize: const Size(120, 60),
                  ),
                  onPressed: _isRunning? _pauseTimer : null,
                  child: Text(_isPaused? 'Resume' : 'Pause', style: const TextStyle(color: Colors.white, fontSize: 17),),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.grey,
                    fixedSize: const Size(120, 60),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => SessionSummaryScreen(
                        remainingCold: _remainingColdIntervals,
                        remainingHot: _remainingHotIntervals,
                        time: _totalTime ~/ 60,
                        hotCount: widget.countHot,
                        coldCount: widget.countCold,
                      )),
                    );
                  },
                  child: const Text('Stop', style: TextStyle(color: Colors.white, fontSize: 17),),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


  void _startTimer() {
  setState(() {
    _isRunning = true;
    _isPaused = false;
  });
  _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
    if (_isRunning && !_isPaused) {
      if (_isHot) {
        if (_seconds < widget.timeHot * 60) {
          setState(() {
            _seconds++;
            _totalTime++;
          });
        } else {
          setState(() {
            _seconds = 0;
            _isHot = false;
          });
          if (_remainingHotIntervals > 0) {
            _remainingHotIntervals--;
          }
        }
      } else {
        if (_seconds < widget.timeCold * 60) {
          setState(() {
            _seconds++;
            _totalTime++;
          });
        } else {
          setState(() {
            _seconds = 0;
            _isHot = true;
          });
          if (_remainingColdIntervals > 0) {
            _remainingColdIntervals--;
          }
        }
      }
      if (_remainingHotIntervals == 0 && _remainingColdIntervals == 0) {
        _stopTimer();
      }
    }
  });
}

  void _pauseTimer() {
    setState(() {
      _isPaused =!_isPaused;
    });
    if (_isPaused) {
      _timer?.cancel();
    } else if (_isRunning) {
      _startTimer();
    }
  }

  void _stopTimer() {
    setState(() {
      _isRunning = false;
      _isPaused = false;
    });
    _timer?.cancel();
    _seconds = 0;

    if (_remainingHotIntervals == 0 && _remainingColdIntervals == 0) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SessionSummaryScreen(
        remainingCold: _remainingColdIntervals,
                        remainingHot: _remainingHotIntervals,
                        time: _totalTime~/ 60,
                        hotCount: widget.countHot,
                        coldCount: widget.countCold,
      )),
    );
  }
  }

  String _formatDuration(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

}