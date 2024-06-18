import 'dart:async';
import 'package:education/templates/middleAssignment/finish_screen.dart';
import 'package:flutter/material.dart';
import 'package:education/templates/middleAssignment/storage.dart';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';

class TimerScreen extends StatefulWidget {
  final List<ShowerPhase> phases;
  final DateTime sessionDate;

  const TimerScreen({Key? key, required this.phases, required this.sessionDate}) : super(key: key);

  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  late Timer _timer;
  double _progress = 0;
  int _currentTime = 0;
  int _currentPhaseIndex = 0;
  late final List<int> _phaseDurations;
  late final int _totalTime;
  late int _phaseTimeLeft;
  bool _isTimerPaused = false;

  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> playSound() async {
    if (_currentPhaseIndex < widget.phases.length) {
      String soundPath;
      String phaseName = widget.phases[_currentPhaseIndex].name;

      if (phaseName == "hot") {
        soundPath = 'sounds/hot_shower.mp3';
      } else {
        soundPath = 'sounds/cold_shower.mp3';
      }
      await _audioPlayer.play(AssetSource(soundPath));

      if (_currentPhaseIndex == widget.phases.length - 1) {
        await _audioPlayer.play(AssetSource('sounds/timer.mp3'));
      }
    }
  }


  void pauseTimer() {
    if (_timer.isActive) {
      _timer.cancel();
      setState(() {
        _isTimerPaused = true;
      });
    }
  }

  void resumeTimer() {
    if (!_timer.isActive) {
      startTimer();
      setState(() {
        _isTimerPaused = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _phaseDurations = widget.phases.map((phase) => phase.duration.inSeconds).toList();
    _totalTime = _phaseDurations.fold(0, (sum, duration) => sum + duration);
    _phaseTimeLeft = _phaseDurations.isNotEmpty ? _phaseDurations.first : 0;
    startTimer();
    }


  void startTimer() {
    _currentTime = 0;
    ShowerSession session = ShowerSession(date: widget.sessionDate, phases: widget.phases);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
    setState(() {
      if (_currentTime < _totalTime) {
        _currentTime++;
        _phaseTimeLeft--;
        _progress = _currentTime / _totalTime;
        if (_phaseTimeLeft == 0 && _currentPhaseIndex < widget.phases.length - 1) {
          _currentPhaseIndex++;
          _phaseTimeLeft = _phaseDurations[_currentPhaseIndex];
          playSound();
        }
      } else {
        _timer.cancel();
        playSound();
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text(
                "Session Complete",
                style: TextStyle(
                  color: Color(0xFF24305E),
                ),  
              ),
              content: const Text(
                "The session has ended.",
                style: TextStyle(
                  color: Color(0xFF24305E),
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text(
                    "OK",
                    style: TextStyle(
                      color: Color(0xFF24305E),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FinishScreen(currentSession: session),
                      ),
                    );
                  },
                ),
              ],
            );
          },
        );
      }
    });
  });
}

  @override 
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int remainingTime = _phaseTimeLeft;
    int remainingMinutes = remainingTime ~/ 60;
    int remainingSeconds = remainingTime % 60;

    String formattedTime = '${remainingMinutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
    Color phaseColor = widget.phases[_currentPhaseIndex].name == "cold" ? const Color(0xFF374785) : const Color.fromARGB(255, 155, 36, 36);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Timer'),
        backgroundColor: const Color(0xFF24305E),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomPaint(
              foregroundPainter: CircleProgress(_progress, phaseColor),
              child: Container(
                width: 200,
                height: 200,
                child: Center(
                  child: Text(
                    formattedTime,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (_isTimerPaused) {
                      resumeTimer();
                    } else {
                      pauseTimer();
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(const Color(0xFF24305E)),
                    foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
                  ),
                  child: Text(
                    _isTimerPaused ? 'Resume' : 'Pause',
                    ),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text(
                            "Session Complete",
                             style: TextStyle(
                                  color: Color(0xFF24305E),
                                  backgroundColor: Colors.white,
                                ),
                            ),
                          content: const Text(
                            "The session has ended.",
                             style: TextStyle(
                                  color: Color(0xFF24305E),
                                  backgroundColor: Colors.white,
                                ),
                            ),
                          actions: <Widget>[
                            TextButton(
                              child: const Text(
                                "OK",
                                style: TextStyle(
                                  color: Color(0xFF24305E),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FinishScreen(currentSession: ShowerSession(date: widget.sessionDate, phases: widget.phases)),
                                  ),
                                );
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(const Color(0xFF24305E)),
                    foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
                  ),
                  child: const Text('End Early'),
                ),
              ],
            )
          ],
        )
      ),
    );
  }
}

class CircleProgress extends CustomPainter {
    double progress;
    Color color;

    CircleProgress(this.progress, this.color);

    @override
    void paint(Canvas canvas, Size size) {
      Paint paint = Paint()
        ..color = color
        ..strokeWidth = 10
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;

      Offset center = Offset(size.width / 2, size.height / 2);
      double radius = size.width / 2;

      paint.color = color.withAlpha(100);
      
      canvas.drawCircle(center, radius, paint);

      paint.color = color;
      double angle = 2 * pi * progress;
      canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2, angle, false, paint);
    }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}