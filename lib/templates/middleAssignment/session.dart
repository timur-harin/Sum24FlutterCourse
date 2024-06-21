import 'package:education/templates/middleAssignment/hive_service.dart';
import 'package:education/templates/middleAssignment/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers.dart';
import 'package:education/templates/middleAssignment/data.dart';
import 'dart:async';

class Session extends ConsumerWidget {
  const Session({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hotShowerPhase = ref.read(hotShowerPhaseProvider);
    final coldShowerPhase = ref.read(coldShowerPhaseProvider);
    final phasesAmount = ref.read(phasesAmountProvider);
    final startWithHot = ref.read(startHotShowerProvider);

    int initialTime = ((phasesAmount / 2).ceil() *
                (startWithHot ? hotShowerPhase : coldShowerPhase) +
            (phasesAmount / 2).floor() *
                (startWithHot ? coldShowerPhase : hotShowerPhase))
        .round();

    return PopScope(
      canPop: false,
      child: Scaffold(
        body: AnimatedContainer(
          duration: const Duration(seconds: 1),
          color: ref.watch(backgroundColorProvider),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CountdownTimer(
                  initialSeconds: initialTime,
                  hotShowerTime: hotShowerPhase.toInt(),
                  coldShowerTime: coldShowerPhase.toInt(),
                  ref: ref,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CountdownTimer extends StatefulWidget {
  final int initialSeconds;
  final int hotShowerTime;
  final int coldShowerTime;
  final WidgetRef ref;

  const CountdownTimer({
    super.key,
    required this.initialSeconds,
    required this.hotShowerTime,
    required this.coldShowerTime,
    required this.ref,
  });

  @override
  _CountdownTimerState createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  late Color _backgroundColor;
  late int _remainingSeconds;
  Timer? _timer;
  late int temp;
  int completedPhases = 0;
  bool isPaused = false;

  void finishSession() {
    widget.ref.read(ratingProvider.notifier).state = 1;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Session Summary'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Time spent: ${secondsToMinutesSeconds(widget.ref.read(timeSpentProvider))} minutes\n'
                'Completed phases: $completedPhases',
              ),
              const SizedBox(
                height: 15,
              ),
              RatingStars(ref: widget.ref),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                HiveService.add(Data(
                  hotShowerTime:
                      widget.ref.read(hotShowerPhaseProvider).round(),
                  coldShowerTime:
                      widget.ref.read(coldShowerPhaseProvider).round(),
                  totalTime: widget.ref.read(timeSpentProvider),
                  totalPhases: completedPhases,
                  rating: widget.ref.read(ratingProvider),
                ));

                widget.ref.read(startHotShowerProvider.notifier).state = true;
                widget.ref.read(backgroundColorProvider.notifier).state =
                    Colors.orange;
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const HomePage()),
                  (route) => false,
                );
              },
              child: Text('Proceed',
                  style: TextStyle(color: Colors.lightBlue.withOpacity(0.8))),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _remainingSeconds = widget.initialSeconds;
    temp = _remainingSeconds;
    _backgroundColor = widget.ref.read(startHotShowerProvider)
        ? Colors.orange
        : Colors.lightBlue;
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 200), (timer) {
      if (_remainingSeconds > 0 && !isPaused) {
        setState(() {
          _remainingSeconds--;
          if (widget.ref.read(startHotShowerProvider)) {
            if (temp - _remainingSeconds == widget.hotShowerTime + 1) {
              widget.ref.read(startHotShowerProvider.notifier).state = false;
              _backgroundColor = Colors.lightBlue;
              temp -= widget.hotShowerTime;
              completedPhases++;
            }
          } else {
            if (temp - _remainingSeconds == widget.coldShowerTime + 1) {
              widget.ref.read(startHotShowerProvider.notifier).state = true;
              _backgroundColor = Colors.orange;
              temp -= widget.coldShowerTime;
              completedPhases++;
            }
          }
          widget.ref.read(backgroundColorProvider.notifier).state =
              _backgroundColor;
        });
      } else if (_remainingSeconds <= 0) {
        widget.ref.read(timeSpentProvider.notifier).state =
            widget.initialSeconds - _remainingSeconds;
        _timer?.cancel();
        finishSession();
      }
    });
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          _formatTime(_remainingSeconds),
          style: const TextStyle(
              fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.white.withOpacity(0.3),
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 35),
                foregroundColor: Colors.white,
                textStyle:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                side: const BorderSide(color: Colors.white),
              ),
              onPressed: () {
                setState(() {
                  isPaused = !isPaused;
                });
              },
              child: Text(isPaused ? 'Resume' : 'Pause'),
            ),
            const SizedBox(width: 20),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.white.withOpacity(0.3),
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 35),
                foregroundColor: Colors.white,
                textStyle:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                side: const BorderSide(color: Colors.white),
              ),
              onPressed: () {
                setState(() {
                  widget.ref.read(timeSpentProvider.notifier).state =
                      widget.initialSeconds - _remainingSeconds;
                  isPaused = true;
                  finishSession();
                });
              },
              child: const Text('Finish'),
            ),
          ],
        ),
      ],
    );
  }
}

class RatingStars extends StatefulWidget {
  final Function(int)? onRatingChanged;
  final int initialRating;
  WidgetRef ref;

  RatingStars({
    super.key,
    this.onRatingChanged,
    this.initialRating = 1,
    required this.ref,
  });

  @override
  _RatingStarsState createState() => _RatingStarsState();
}

class _RatingStarsState extends State<RatingStars> {
  late int _rating;

  @override
  void initState() {
    super.initState();

    _rating = widget.initialRating;
  }

  void _updateRating(int newRating) {
    setState(() {
      _rating = newRating;
      widget.ref.read(ratingProvider.notifier).state = newRating;
    });
    if (widget.onRatingChanged != null) {
      widget.onRatingChanged!(_rating);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        int starNumber = index + 1;
        return GestureDetector(
          onTap: () => _updateRating(starNumber),
          child: Icon(
            _rating >= starNumber ? Icons.star : Icons.star_border,
            color: _rating >= starNumber ? Colors.amber : Colors.grey,
          ),
        );
      }),
    );
  }
}
