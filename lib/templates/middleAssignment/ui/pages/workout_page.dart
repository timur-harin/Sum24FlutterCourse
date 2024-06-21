import 'dart:async';

import 'package:education/templates/middleAssignment/providers/provider.dart';
import 'package:education/templates/middleAssignment/providers/workout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WorkoutPage extends ConsumerStatefulWidget {
  const WorkoutPage({super.key});

  @override
  _WorkoutPageState createState() => _WorkoutPageState();
}

class _WorkoutPageState extends ConsumerState<WorkoutPage> {
  late int hotCycleDuration;
  late int hotNumberOfCycles;
  late int coldCycleDuration;
  late int coldNumberOfCycles;
  late Timer _timer;
  bool isPaused = false;
  DateTime start = DateTime.now();
  int elapsedTime = 0;
  bool isHotCycle = true;
  int remainingHotCycles = 0;
  int remainingColdCycles = 0;
  bool isManuallyFinished = false;

  @override
  void initState() {
    super.initState();
  }

  void startTimer() {
    setState(() {
      remainingHotCycles = hotNumberOfCycles;
      remainingColdCycles = coldNumberOfCycles;
    });

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        if (!isPaused) {
          setState(() {
            elapsedTime++;

            if (isHotCycle && remainingHotCycles > 0) {
              if (elapsedTime % hotCycleDuration == 0) {
                remainingHotCycles--;
                if (remainingColdCycles > 0) {
                  isHotCycle = false;
                }
              }
            } else if (!isHotCycle && remainingColdCycles > 0) {
              if (elapsedTime % coldCycleDuration == 0) {
                remainingColdCycles--;
                if (remainingHotCycles > 0) {
                  isHotCycle = true;
                }
              }
            }

            if (remainingHotCycles < 0) remainingHotCycles = 0;
            if (remainingColdCycles < 0) remainingColdCycles = 0;

            if (remainingHotCycles == 0 && remainingColdCycles == 0) {
              timer.cancel();
              if (!isManuallyFinished) {
                navigateToFinish();
              }
            }
          });
        }
      },
    );
  }

  void pauseTimer() {
    setState(() {
      isPaused = true;
    });
  }

  void resumeTimer() {
    setState(() {
      isPaused = false;
    });
  }

  void navigateToFinish() {
    if (_timer.isActive) {
      _timer.cancel();
    }
    final workoutNotifier = ref.read(workoutProvider.notifier);
    workoutNotifier.addWorkout(Workout(
      'Workout ${elapsedTime}s',
      WorkoutType.Exercise,
      start,
      endTime: DateTime.now(),
      actualTime: elapsedTime,
      actualCycles: hotNumberOfCycles -
          remainingHotCycles +
          coldNumberOfCycles -
          remainingColdCycles,
      hotCycles: hotNumberOfCycles - remainingHotCycles,
      coldCycles: coldNumberOfCycles - remainingColdCycles,
      date: DateTime.now(),
    ));
    Navigator.of(context).pushNamed('/finish');
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, int>;
    hotCycleDuration = args['hotCycleDuration']!;
    hotNumberOfCycles = args['hotNumberOfCycles']!;
    coldCycleDuration = args['coldCycleDuration']!;
    coldNumberOfCycles = args['coldNumberOfCycles']!;

    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(seconds: 1),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isHotCycle
                ? [Colors.red, Colors.orange]
                : [Colors.blue, Colors.cyan],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: startTimer,
              child: Text('Start'),
            ),
            Text('Elapsed Time: $elapsedTime seconds'),
            Text('Remaining Hot Cycles: $remainingHotCycles'),
            Text('Remaining Cold Cycles: $remainingColdCycles'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: isPaused ? null : pauseTimer,
                  child: Text('Pause'),
                ),
                ElevatedButton(
                  onPressed: isPaused ? resumeTimer : null,
                  child: Text('Resume'),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  isManuallyFinished = true;
                });
                navigateToFinish();
              },
              child: Text('Finish'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    if (_timer.isActive) {
      _timer.cancel();
    }
    super.dispose();
  }
}
