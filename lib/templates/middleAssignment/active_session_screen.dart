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
          _totalDuration++;
          if (_currentDuration == 0) {
            _isHotPhase = !_isHotPhase;
            _currentDuration = _isHotPhase ? widget.hotDuration : widget.coldDuration;
          }
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color waterColor = _isHotPhase ? AppColors.hot : AppColors.cold;
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Active Session', style: Theme.of(context).textTheme.headlineLarge)),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        color: waterColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _isHotPhase ? 'Hot Phase' : 'Cold Phase',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              '$_currentDuration seconds',
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('End Session'),
            ),
          ],
        ),
      ),
    );
  }
}
