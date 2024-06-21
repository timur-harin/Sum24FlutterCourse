import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';
import 'summaryScreen.dart';

class CustomAnimationWidget extends StatefulWidget {
  final bool isWarmPhase;

  CustomAnimationWidget({required this.isWarmPhase});

  @override
  _CustomAnimationWidgetState createState() => _CustomAnimationWidgetState();
}

class _CustomAnimationWidgetState extends State<CustomAnimationWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Opacity(
          opacity: _animation.value,
          child: CustomPaint(
            size: Size(200, 200),
            painter: widget.isWarmPhase ? SunPainter() : SnowflakePainter(),
          ),
        );
      },
    );
  }
}

class SunPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.orange
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 3;

    // Draw the central circle of the sun
    paint.style = PaintingStyle.fill;
    canvas.drawCircle(center, radius / 2, paint);

    // Draw the rays of the sun
    paint.style = PaintingStyle.stroke;
    for (int i = 0; i < 12; i++) {
      final angle = i * 30.0 * (pi / 180.0);
      final x = center.dx + radius * cos(angle);
      final y = center.dy + radius * sin(angle);
      canvas.drawLine(center, Offset(x, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class SnowflakePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 3;

    for (int i = 0; i < 6; i++) {
      final angle = i * 60.0 * (pi / 180.0);
      final x = center.dx + radius * cos(angle);
      final y = center.dy + radius * sin(angle);
      canvas.drawLine(center, Offset(x, y), paint);
      drawBranch(canvas, paint, center, Offset(x, y), 3, radius);
    }
  }

  void drawBranch(Canvas canvas, Paint paint, Offset start, Offset end, int depth, double radius) {
    if (depth == 0) return;
    final dx = (end.dx - start.dx) / 3;
    final dy = (end.dy - start.dy) / 3;

    final p1 = Offset(start.dx + dx, start.dy + dy);
    final p2 = Offset(end.dx - dx, end.dy - dy);

    final mid = Offset(
      (p1.dx + p2.dx) / 2,
      (p1.dy + p2.dy) / 2,
    );

    final angle = atan2(dy, dx) + pi / 3;
    final branchEnd = Offset(
      mid.dx + radius / 4 * cos(angle),
      mid.dy + radius / 4 * sin(angle),
    );

    canvas.drawLine(p1, branchEnd, paint);
    canvas.drawLine(branchEnd, p2, paint);

    drawBranch(canvas, paint, p1, branchEnd, depth - 1, radius);
    drawBranch(canvas, paint, branchEnd, p2, depth - 1, radius);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class SessionScreen extends StatefulWidget {
  final double warmWaterSeconds;
  final double coldWaterSeconds;
  final double repeatCycles;

  SessionScreen({
    required this.warmWaterSeconds,
    required this.coldWaterSeconds,
    required this.repeatCycles,
  });

  @override
  _SessionScreenState createState() => _SessionScreenState();
}

class _SessionScreenState extends State<SessionScreen> {
  int _counter = 0;
  Timer? _timer;
  int _currentCycle = 0;
  bool _isWarmPhase = true;
  bool _isChangingPhase = false;
  bool _sessionComplete = false;
  bool _isTimerRunning = false;
  Color _backgroundColor = Color.fromARGB(255, 255, 176, 176); // Initial color for warm phase

  void _startTimer() {
    _stopTimer(); // Ensure any existing timer is stopped before starting a new one
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _counter++;
        _isTimerRunning = true;
      });

      if (_isWarmPhase && _counter > widget.warmWaterSeconds) {
        _initiatePhaseChange();
      } else if (!_isWarmPhase && _counter > widget.coldWaterSeconds) {
        _initiatePhaseChange();
      }
    });
  }

  void _initiatePhaseChange() {
    _stopTimer();
    setState(() {
      _isChangingPhase = true;
      _counter = 0;
    });

    Future.delayed(Duration(seconds: 7), () {
      _switchPhase();
      if (_currentCycle < widget.repeatCycles) {
        _startTimer();
      }
    });
  }

  void _switchPhase() {
    setState(() {
      if (_isWarmPhase) {
        _isWarmPhase = false;
        _backgroundColor = Color.fromARGB(255, 176, 215, 255); // Change to blue for cold phase
      } else {
        _currentCycle++;
        if (_currentCycle >= widget.repeatCycles) {
          _isChangingPhase = false; // No phase change message after the last cold phase
          _sessionComplete = true; // Mark session as complete
          return; // Do not restart the timer if all cycles are completed
        }
        _isWarmPhase = true;
        _backgroundColor = Color.fromARGB(255, 255, 176, 176); // Change to red for warm phase
      }
      _counter = 0; // Reset the counter after switching phase
      _isChangingPhase = false;
    });
  }

  void _stopTimer() {
    if (_timer != null) {
      _timer!.cancel();
      _timer = null; // Reset the timer to null after cancelling
      setState(() {
        _isTimerRunning = false;
      });
    }
  }

  void _resetTimer() {
    _stopTimer(); // Ensure the timer stops when reset is pressed
    setState(() {
      _counter = 0;
      _currentCycle = 0;
      _isWarmPhase = true;
      _isChangingPhase = false;
      _sessionComplete = false;
      _backgroundColor = Color.fromARGB(255, 255, 176, 176); // Reset to warm phase color
    });
  }

  String _formatPreviousSessionData() {
    return 'Warm water: ${(widget.warmWaterSeconds / 60).floor().toStringAsFixed(0)} minutes ${(widget.warmWaterSeconds % 60).toStringAsFixed(0)} seconds, Cold water: ${widget.coldWaterSeconds.toStringAsFixed(0)} seconds, Repeat cycles: ${widget.repeatCycles.toStringAsFixed(0)} time(s), Total time (with phase switches): ${((widget.warmWaterSeconds + widget.coldWaterSeconds + 7) * widget.repeatCycles / 60).floor().toStringAsFixed(0)} minutes ${((widget.warmWaterSeconds + widget.coldWaterSeconds + 7) * widget.repeatCycles % 60).toStringAsFixed(0)} seconds';
  }

  @override
  void dispose() {
    _stopTimer(); // Ensure timer is cancelled when widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: AnimatedContainer(
        duration: Duration(seconds: 1), // Change duration to 1 second
        color: _backgroundColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              if (!_isChangingPhase && !_sessionComplete)
                Text('Timer: $_counter seconds', style: TextStyle(fontSize: 24)),
              SizedBox(height: 20),
              if (_isChangingPhase)
                Text('Change to ${_isWarmPhase ? "Cold" : "Warm"} Phase',
                    style: TextStyle(fontSize: 24)),
              Text('Cycle: $_currentCycle/${widget.repeatCycles.toInt()}'),
              SizedBox(height: 20),
              if (_isChangingPhase)
                CustomAnimationWidget(isWarmPhase: !_isWarmPhase), // Pass the phase information to the animation widget
              if (!_isChangingPhase && !_sessionComplete) ...[
                Text('Phase: ${_isWarmPhase ? "Warm" : "Cold"}'),
                SizedBox(height: 20),
              ],
              if (_sessionComplete)
                SizedBox(height: 20),
              if (_currentCycle < widget.repeatCycles.toInt()) ...[
                if (!_isTimerRunning && !_isChangingPhase)
                  ElevatedButton(
                    onPressed: _startTimer,
                    child: Text('Start Timer'),
                  ),
                if (_isTimerRunning)
                  ElevatedButton(
                    onPressed: _stopTimer,
                    child: Text('Stop Timer'),
                  ),
                if (!_isChangingPhase)
                  SizedBox(height: 10),
                if (!_isChangingPhase)
                  ElevatedButton(
                    onPressed: _resetTimer,
                    child: Text('Reset Timer'),
                  ),
              ] else
                ElevatedButton(
                  onPressed: () async {
                    String sessionSummary = _formatPreviousSessionData();
                    await Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SummaryScreen(sessionData: sessionSummary),
                      ),
                    );
                  },
                  child: Text("End Session and Save Data"),
                ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

