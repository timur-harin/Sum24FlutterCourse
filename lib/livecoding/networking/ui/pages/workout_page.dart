// import 'dart:async';

// import 'package:education/livecoding/networking/data/workout.dart';
// import 'package:education/livecoding/networking/providers/provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class WorkoutPage extends StatefulWidget {
//   const WorkoutPage({super.key});

//   @override
//   State<WorkoutPage> createState() => _WorkoutPageState();
// }

// class _WorkoutPageState extends State<WorkoutPage> {
//   int number_cycles = 3;

//   int actual_number = 0;

//   int time_left = 0;

//   DateTime start = DateTime.now();
//   late Timer _timer;

//   void startTimer(int numberCycles, int numberInCycle) {
//     time_left = numberInCycle;
//     final cycles = numberCycles;
//     const oneSec = const Duration(seconds: 1);
//     _timer = new Timer.periodic(
//       oneSec,
//       (Timer timer) {
//         if (time_left == 0) {
//           if (cycles > 0) {
//             setState(() {
//               timer.cancel();
//             });
//             number_cycles--;
//             startTimer(cycles - 1, numberInCycle);
//           } else {
//             timer.cancel();
//           }
//         } else {
//           setState(() {
//             actual_number++;
//             time_left--;
//           });
//         }
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final workoutProvider = Provider.of<WorkoutProvider>(context);
//     final number = workoutProvider.number;

//     return Scaffold(
//       body: Column(children: [
//         ElevatedButton(
//             onPressed: () {
//               start = DateTime.now();
//               startTimer(number_cycles, number);
//             },
//             child: const Text('Start')),
//         Text('Time: $time_left '),
//         Text('Cycles: $number_cycles'),
//         ElevatedButton(
//           onPressed: () {
//             workoutProvider.addWorkout(Workout(
//               'Workout $number',
//               number == 0
//                   ? WorkoutType.WarmUp
//                   : number == 1
//                       ? WorkoutType.Exercise
//                       : WorkoutType.CoolDown,
//               start,
//               endTime: start.add(Duration(seconds: number)),
//             ));
//             Navigator.of(context).pushNamed('/finish');
//           },
//           child: const Text('Finish'),
//         )
//       ]),
//     );
//   }
// }
