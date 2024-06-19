import 'dart:async';

import 'package:education/templates/middleAssignment/providers/cycles_provider.dart';
import 'package:education/templates/middleAssignment/providers/duration_provider.dart';
import 'package:education/templates/middleAssignment/providers/shower_take_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:education/templates/middleAssignment/data/shower_take.dart';


class TakeShowerPage extends ConsumerStatefulWidget {
  const TakeShowerPage({super.key});

  @override
  ConsumerState<TakeShowerPage> createState() => _TakeShowerPageState();
}

class _TakeShowerPageState extends ConsumerState<TakeShowerPage> {
  DateTime start = DateTime.now();
  late Timer _timer;
  
  int number_cycles = 3;
  int actual_number = 0;
  int time_left = 0;


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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Take a Shower!'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Aim Cycles: ${ref.watch(cyclesProvider)}'),
                Text('Aim Cycle Duration: ${ref.watch(durationProvider)}'),
              ],
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                ElevatedButton(
                  onPressed: () {
                    start = DateTime.now();
                    startTimer(ref.watch(cyclesProvider), ref.watch(durationProvider));
                  },
                  child: const Text('Start')
                ),

                Text('Time: $time_left '),
                Text('Cycles: $number_cycles'),

                ElevatedButton(
                  onPressed: () {
                    ref.read(showerTakesProvider.notifier).addShowerTake(
                      ShowerTake(
                        'Shower ${ref.watch(showerTakesProvider).length + 1}',
                        ref.watch(durationProvider),
                        number_cycles,
                        start,
                        endTime: DateTime.now(),
                      )
                    );
                    Navigator.of(context).pushNamed('/finish');
                  },
                  child: const Text('Finish'),
                ),
              ]
            )
          ],
        ),
      )
    );
  }
}