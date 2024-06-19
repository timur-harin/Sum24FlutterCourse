import 'dart:async';

import 'package:flutter/material.dart';
import '../data/session.dart';
import '../providers/provider.dart';
import 'package:provider/provider.dart';

class SessionPage extends StatefulWidget {
  const SessionPage({super.key});

  @override
  State<SessionPage> createState() => _SessionPageState();
}

class _SessionPageState extends State<SessionPage> {
  int number_cycles = 3;

  int actual_number = 0;

  int time_left = 0;

  DateTime start = DateTime.now();
  late Timer _timer;

  void startTimer(int numberCycles, int numberInCycle) {
    time_left = numberInCycle;
    final cycles = numberCycles;
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (time_left == 0) {
          if (cycles > 0) {
            setState(() {
              timer.cancel();
            });
            number_cycles--;
            startTimer(cycles - 1, numberInCycle);
          } else {
            timer.cancel();
          }
        } else {
          setState(() {
            actual_number++;
            time_left--;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final sessionProvider = Provider.of<SessionProvider>(context);
    final number = sessionProvider.number;

    return Scaffold(
      body: Column(children: [
        ElevatedButton(
            onPressed: () {
              start = DateTime.now();
              startTimer(number_cycles, number);
            },
            child: Text('Start')),
        Text('Time: $time_left '),
        Text('Cycles: $number_cycles'),
        ElevatedButton(
          onPressed: () {
            sessionProvider.addSession(Session(
              23,
              number == 0
                  ? SessionType.Finished
                  : number == 1
                      ? SessionType.Stopped
                      : SessionType.Finished,
              start,
              endTime: start.add(Duration(seconds: number)),
            ));
            Navigator.of(context).pushNamed('/finish');
          },
          child: Text('Finish'),
        )
      ]),
    );
  }
}
