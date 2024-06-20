import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';
import 'shower_session.dart';
import 'theme.dart';

class ActiveSessionScreen extends ConsumerStatefulWidget {
  final int hotDuration;
  final int coldDuration;

  ActiveSessionScreen({required this.hotDuration, required this.coldDuration});

  @override
  _ActiveSessionScreenState createState() => _ActiveSessionScreenState();
}

class _ActiveSessionScreenState extends ConsumerState<ActiveSessionScreen>
    with SingleTickerProviderStateMixin {
  late Timer _timer;
  late int _currentDuration;
  late bool _isHotPhase;
  late int _totalDuration;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _isHotPhase = true;
    _currentDuration = widget.hotDuration;
    _totalDuration = 0;
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_currentDuration > 0) {
          _currentDuration--;
        } else {
          _isHotPhase = !_isHotPhase;
          _animationController.forward(from: 0.0);
          _currentDuration = _isHotPhase ? widget.hotDuration : widget.coldDuration;
        }
        _totalDuration++;
      });
    });
  }

  void _endSession() {
    _timer.cancel();
    final newSession = ShowerSession(
      date: DateTime.now(),
      hotDuration: widget.hotDuration,
      coldDuration: widget.coldDuration,
      totalDuration: _totalDuration,
    );
    ref.read(addSessionProvider)(newSession);
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _timer.cancel();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Active Session', style: Theme.of(context).textTheme.headlineLarge)),
        backgroundColor: AppColors.primary,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: _endSession,
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return CustomPaint(
                  painter: WaterPainter(
                    isHotPhase: _isHotPhase,
                    animationValue: _animationController.value,
                  ),
                );
              },
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _isHotPhase ? 'Hot Phase' : 'Cold Phase',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
                Text(
                  'Time Remaining: $_currentDuration seconds',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                ElevatedButton(
                  onPressed: _endSession,
                  child: Text('End Session'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class WaterPainter extends CustomPainter {
  final bool isHotPhase;
  final double animationValue;

  WaterPainter({required this.isHotPhase, required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = isHotPhase ? AppColors.hot : AppColors.cold
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, size.height * (0.5 - 0.5 * animationValue))
      ..lineTo(size.width, size.height * (0.5 - 0.5 * animationValue))
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    final path2 = Path()
      ..moveTo(0, size.height * (0.5 + 0.5 * animationValue))
      ..lineTo(size.width, size.height * (0.5 + 0.5 * animationValue))
      ..lineTo(size.width, 0)
      ..lineTo(0, 0)
      ..close();

    canvas.drawPath(path, paint);
    canvas.drawPath(path2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
