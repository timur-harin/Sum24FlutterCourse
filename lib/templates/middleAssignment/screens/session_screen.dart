import 'dart:async';

import 'package:education/templates/middleAssignment/models/temperature_phase.dart';
import 'package:education/templates/middleAssignment/providers/preferences_provider.dart';
import 'package:education/templates/middleAssignment/providers/session_provider.dart';
import 'package:education/templates/middleAssignment/widgets/custom_render_object.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



class SessionScreen extends ConsumerStatefulWidget {

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SessionScreenState();
}

class _SessionScreenState extends ConsumerState<SessionScreen> {
  late Timer _timer;
  DateTime start = DateTime.now();
  int totalDuration = 0;
  int time_left = 0;
  int number_cycles = 0;
  int actual_number = 0;
  TemperaturePhase current_phase = TemperaturePhase.pause;
  int phaseDuration = 0;
  bool isPaused = false;

  void startTimer(int time) {
    time_left = time;
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (time_left == 0) {
          if (actual_number < number_cycles) {
            timer.cancel();
            setState(() {
              number_cycles--;
            });
            current_phase = current_phase == TemperaturePhase.hot ? TemperaturePhase.cold : TemperaturePhase.hot;
            ref.read(sessionRiverpod.notifier).updatePhases(current_phase);
            setState(() {
              actual_number++;
            });
            startTimer(phaseDuration);
          } else {
            setState(() {
              actual_number = ref.read(preferencesProvider).numberOfPhases;
              number_cycles = 0;
              timer.cancel();
            });
          }
        } else {
          setState(() {
            time_left--;
            totalDuration++;
          });
        }
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children:  <Widget>[
            PhaseWidget(time: time_left, cycles_left: number_cycles, cycles_done: actual_number),
            ElevatedButton(
            onPressed:()
            {
              
              number_cycles = ref.read(preferencesProvider).numberOfPhases - actual_number;
              start = DateTime.now();
              phaseDuration = ref.read(preferencesProvider).phaseDuration;
              if(!isPaused) {
                current_phase = ref.read(sessionRiverpod.notifier).lastPhase;
                startTimer( phaseDuration);
              }else{
                startTimer(time_left);
              }
            }, 
            child: const Text("Start")),
            // Text('Number of cycles left: $number_cycles'),
            // Text('Number of cycles done: $actual_number'),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _timer.cancel();
                  isPaused = true;
                });
              }, 
              child: const Text("Pause")),
            ElevatedButton(
              onPressed: () {
                _timer.cancel();
                ref.read(sessionRiverpod.notifier).setDate(DateTime.now());
                ref.read(sessionRiverpod.notifier).setTotalDuration(totalDuration);
                Navigator.of(context).pushNamed('/summary');
              }, 
              child: const Text("Finish")),
          ],
        ) 
      ),
    );
  }
}