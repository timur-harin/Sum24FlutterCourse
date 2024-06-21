// package:education/templates/middleAssignment/new_session_screen.dart
import 'package:flutter/material.dart';
import 'dart:async';
import 'shower_history.dart';

class NewSessionScreen extends StatefulWidget {
  final ShowerSession session;
  final List<int> duration;
  final List<bool> isHotList;

  NewSessionScreen({required this.session, required this.duration, required this.isHotList});

  @override
  _NewSessionScreenState createState() => _NewSessionScreenState();
}

class RatingBar extends StatefulWidget {
  @override
  _RatingBarState createState() => _RatingBarState();
}

class _RatingBarState extends State<RatingBar> {
  int _rating = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return IconButton(
          icon: Icon(
            _rating > index ? Icons.star : Icons.star_border,
          ),
          onPressed: () {
            setState(() {
              _rating = index + 1;
            });
          },
        );
      }),
    );
  }
}

class _NewSessionScreenState extends State<NewSessionScreen> with SingleTickerProviderStateMixin {
  Timer? _timer;
  bool _isStarted = false;
  int _currentCycleIndex = 0;
  int _start = 0;
  List<bool> _isHotList = [];
  AnimationController? _controller;
  Animation? _hotAnimation;
  Animation? _coldAnimation;

  @override
  void initState() {
    super.initState();
    _start = widget.duration[_currentCycleIndex];
    _isHotList = widget.isHotList;

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )
      ..repeat(reverse: true);

    _hotAnimation = ColorTween(
      begin: const Color.fromRGBO(205, 74, 76, 1),
      end: const Color.fromRGBO(250, 67, 67, 1.0),
    ).animate(_controller!);

    _coldAnimation = ColorTween(
      begin: const Color.fromRGBO(160, 201, 242, 1),
      end: const Color.fromRGBO(23, 22, 246, 1.0),
    ).animate(_controller!);
  }

  void startTimer() {
    _isStarted = true;
    _timer = Timer.periodic(
      Duration(seconds: 1),
          (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            _currentCycleIndex++; // Переходим к следующему циклу
            if (_currentCycleIndex < widget.duration.length) {
              _start = widget.duration[_currentCycleIndex];
              startTimer(); // Запускаем таймер для следующего цикла
            } else {
              _isStarted =
              false; // Останавливаем таймер, если все циклы завершены
              _showFeedbackDialog(); // Показываем диалоговое окно для оценки
            }
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  void _showFeedbackDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text('Shower Session Ended'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                      'Would you like to leave feedback for this shower session?'),
                  RatingBar(),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('Save'),
                  onPressed: () {
                    // Save the rating
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller?.dispose();
    super.dispose();
  }

  String formatDuration(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString()
        .padLeft(2, '0')}';
  }

  bool _isPaused = false;

  void pauseTimer() {
    if (_timer != null) {
      if (_isPaused) {
        startTimer();
      } else {
        _timer!.cancel();
      }
      setState(() {
        _isPaused = !_isPaused;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Session'),
      ),
      body: AnimatedBuilder(
        animation: _controller!,
        builder: (context, child) {
          return Container(
            color: _currentCycleIndex < _isHotList.length
                ? (_isHotList[_currentCycleIndex]
                ? _hotAnimation!.value
                : _coldAnimation!.value)
                : Colors.white,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Total duration of all cycles: ${widget.session
                      .totalDuration.inSeconds} seconds'),
                  if (_currentCycleIndex < widget.session.intervals.length)
                    Text('Current cycle duration: ${widget.session
                        .intervals[_currentCycleIndex].inSeconds} seconds'),
                  Text('Current cycle: ${_currentCycleIndex + 1}'),
                  Text('${formatDuration(_start)}',
                      style: TextStyle(fontSize: 48)),
                  if (_currentCycleIndex < _isHotList.length)
                    Text('Water temperature: ${_isHotList[_currentCycleIndex]
                        ? 'Hot'
                        : 'Cold'}'),
                  if (!_isStarted)
                    ElevatedButton(
                      onPressed: startTimer,
                      child: const Text('Start'),
                    ),
                  if (_isStarted)
                    ElevatedButton(
                      onPressed: pauseTimer,
                      child: Text(_isPaused ? 'Resume' : 'Pause'),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}