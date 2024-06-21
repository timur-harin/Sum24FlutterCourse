import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:education/templates/middleAssignment/data/models/shower_history.dart';


final temperatureProvider = StateProvider<Color>((ref) => Colors.red);

class WhileSessionWidget extends ConsumerStatefulWidget {
  const WhileSessionWidget({super.key, required this.session});

  final ShowerSession session;

  @override
  ConsumerState createState() => _WhileSessionWidgetState();
}

class _WhileSessionWidgetState extends ConsumerState<WhileSessionWidget> {
  int _countDownValue = 0;
  Timer? _timer;
  var index = 0;
  List<TemperaturePhase> _phases = [];

  @override
  void initState() {
    _phases = widget.session.temperaturePhases;
    _countDownValue = _phases[index].duration;
    ref.read(temperatureProvider.notifier).state = _phases[index].temperature == "Hot" ? Colors.red : Colors.blue;
    index++;
    super.initState();
  }

  void startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countDownValue > 0) {
        setState(() {
          _countDownValue--;
        });
      } else {
        changePhase();
      }
    });
  }

  void changePhase() {
    if (index < _phases.length) {
      setState(() {
        _countDownValue = _phases[index].duration;
        ref.read(temperatureProvider.notifier).state = _phases[index].temperature == "Hot" ? Colors.red : Colors.blue;
        index++;

      });
    } else {
      _timer?.cancel();
      showDialog(
          context: context,
          builder: (context) => const AlertDialog(title: Text("Session Finished")));
    }
  }

  void stopCountdown() {
    _timer?.cancel(); // Cancel the timer if it's running
  }

  @override
  Widget build(BuildContext context) {
    final _color = ref.watch(temperatureProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Countdown Timer'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        color: _color,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '$_countDownValue',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_timer != null && _timer!.isActive) {
                    stopCountdown();
                  } else {
                    startCountdown();
                  }
                },
                child: const Text('Start/Stop'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
