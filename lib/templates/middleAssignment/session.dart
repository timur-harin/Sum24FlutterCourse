import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers.dart';

import 'dart:async';

class Session extends ConsumerWidget {
  const Session({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hotShowerPhase = ref.read(hotShowerPhaseProvider);
    final coldShowerPhase = ref.read(coldShowerPhaseProvider);
    final phasesAmount = ref.read(phasesAmountProvider);
    final startWithHot = ref.read(startHotShowerProvider);

    int initialTime = ((phasesAmount / 2).ceil() * hotShowerPhase +
            (phasesAmount / 2).floor() * coldShowerPhase)
        .round();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CountdownTimer(initialSeconds: initialTime),
          ],
        ),
      ),
    );
  }
}

class CountdownTimer extends StatefulWidget {
  final int initialSeconds;

  const CountdownTimer({Key? key, required this.initialSeconds})
      : super(key: key);

  @override
  _CountdownTimerState createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  late int _remainingSeconds;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _remainingSeconds = widget.initialSeconds;
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        _timer?.cancel();
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
          style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _remainingSeconds = widget.initialSeconds;
              _timer?.cancel();
              _startTimer();
            });
          },
          child: const Text('Reset Timer'),
        ),
      ],
    );
  }
}
