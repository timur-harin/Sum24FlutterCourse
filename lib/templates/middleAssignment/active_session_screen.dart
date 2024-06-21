import 'dart:async';
import 'package:education/templates/middleAssignment/home_screen.dart';
import 'package:education/templates/middleAssignment/shower_session.dart';
import 'package:education/templates/middleAssignment/summary_screen.dart';
import 'package:education/templates/middleAssignment/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ActiveSessionScreen extends ConsumerStatefulWidget {
  final ShowerSession session;
  final int currentCycle;
  final bool isHot;

  ActiveSessionScreen({
    required this.session,
    required this.currentCycle,
    required this.isHot,
  });

  @override
  _ActiveSessionScreenState createState() => _ActiveSessionScreenState();
}

class _ActiveSessionScreenState extends ConsumerState<ActiveSessionScreen> {
  Timer? _timer;
  int _duration = 0;
  int _totalDuration = 0;
  bool _isHot = true;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _duration++;
        _totalDuration++;
        if (_duration >= widget.session.cycles[widget.currentCycle].hotDuration && _isHot) {
          _isHot = false;
          _duration = 0;
        } else if (_duration >= widget.session.cycles[widget.currentCycle].coldDuration && !_isHot) {
          _isHot = true;
          _duration = 0;
        }
        if (_totalDuration >= widget.session.totalDuration * 60) {
          // Total duration reached, navigate to SummaryScreen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => SummaryScreen(
              date: widget.session.date,
              totalMinutes: widget.session.totalDuration,
              hotDuration: widget.session.hotDuration,
              coldDuration: widget.session.coldDuration,
              hotTemperature: widget.session.hotTemperature,
              coldTemperature: widget.session.coldTemperature,
              cycles: widget.session.cycles.length,
            )),
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final cycle = widget.session.cycles[widget.currentCycle];
    final temperature = _isHot ? widget.session.hotTemperature : widget.session.coldTemperature;
    final fillColor = _isHot ? AppColors.hot : AppColors.cold;

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Active Session',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
        backgroundColor: AppColors.primary,
        actions: [
          IconButton(
            icon: Icon(Icons.stop),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => SummaryScreen(
                  date: widget.session.date,
                  totalMinutes: _totalDuration ~/ 60,
                  hotDuration: widget.session.hotDuration,
                  coldDuration: widget.session.coldDuration,
                  hotTemperature: widget.session.hotTemperature,
                  coldTemperature: widget.session.coldTemperature,
                  cycles: widget.currentCycle,
                )),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Text(
              'Water Temperature: $temperature°C',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).brightness == Brightness.dark
                    ? AppColors.textDark
                    : AppColors.textLight,
              ),
            ),
            SizedBox(height: 20),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(fillColor),
              strokeWidth: 8,
              value: _duration / (_isHot ? cycle.hotDuration : cycle.coldDuration),
            ),
          ],
        ),
      ),
    );
  }
}
