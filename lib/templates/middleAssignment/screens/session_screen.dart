import 'dart:async';

import 'package:education/templates/middleAssignment/models/provider/provider.dart';
import 'package:education/templates/middleAssignment/models/shower_session.dart';
import 'package:education/templates/middleAssignment/screens/finish_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class SessionScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<SessionScreen> createState() => _SessionScreenState();
}

class _SessionScreenState extends ConsumerState<SessionScreen> {
  final controller = TextEditingController();
  final controllerNumber = TextEditingController();

  int actualNumber = 0;

  int timeLeft = 0;

  DateTime start = DateTime.now();
  Timer? _timer;
  @override
  void initState() {
    super.initState();
    // ref.read(timerProvider.notifier).startTimer();
    ref.read(valueProvider.notifier);
  }

  // @override
  // void dispose() {
  //   ref.read(timerProvider.notifier).stopTimer();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final value = ref.watch(valueProvider);
    // final int seconds = ref.watch(timerProvider);
    // final int hours = seconds ~/ 3600;
    // final int minutes = (seconds % 3600) ~/ 60;
    // final int secs = seconds % 60;

    void startTimer(int numberCycles, int numberInCycle) {
      timeLeft = numberInCycle;
      final cycles = numberCycles;
      const oneSec = Duration(seconds: 1);
      _timer = Timer.periodic(
        oneSec,
        (Timer timer) {
          if (timeLeft == 0) {
            if (cycles > 0) {
              setState(() {
                timer.cancel();
              });
              value.decreaseCycles();
              actualNumber++;
              value.change();
              startTimer(cycles - 1, numberInCycle);
            } else {
              timer.cancel();
            }
          } else {
            setState(() {
              actualNumber++;
              timeLeft--;
            });
          }
        },
      );
    }


    return Scaffold(
      backgroundColor: value.color,
      appBar: AppBar(
        title: Text('Session Timer'),
      ),
      body: Center(
        child: Column(
          children: [
            // Text(
            //   '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}',
            //   style: TextStyle(
            //     fontSize: 48.0, // Замените на нужный размер шрифта
            //     fontWeight: FontWeight.bold, // Замените на нужное начертание шрифта
            //   ),
            // ),
            TextField(
              
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter workout duration of cycle',
              ),
              keyboardType: TextInputType.number,
              controller: controller,
              onChanged: (text) => {
                value.cycles = int.parse(text),
              },
            ),
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Number of cycles',
              ),
              keyboardType: TextInputType.number,
              controller: controllerNumber,
              onChanged: (text) => {
                value.timeInCycle = int.parse(text),
              },
            ),
            Text('$actualNumber'),
            Text('$timeLeft'),
          
            ElevatedButton(
              onPressed: () {
                startTimer(value.cycles, value.timeInCycle);
                value.change();
                // ref.read(timerProvider.notifier).stopTimer();
                // ref.read(timerProvider.notifier).startTimer();},
              },
              child: Text('Start Workout'),
            ),
            ElevatedButton(
              onPressed: () {
                value.addSession(ShowerSession(
                  DateFormat('yyyy-MM-dd HH:mm:ss').format(start),
                   actualNumber,
                  value.cycles

                ));
                            Navigator.of(context).pushNamed('/finish_session');  ; 

              },
              child: Text('Finish'),
            ),
          ],
        )
      ),
    );

    
  }

  

}
// class TimerNotifier extends StateNotifier<int> {
//   Timer? _timer;

//   TimerNotifier() : super(0);

//   void startTimer() {
//     _timer?.cancel(); // Отменяем текущий таймер, если он существует
//     _timer = Timer.periodic(Duration(seconds: 1), (_) {
//       state++;
//     });
//   }

//   void stopTimer() {
//     _timer?.cancel();
//   }

//   @override
//   void dispose() {
//     _timer?.cancel();
//     super.dispose();
//   }
// }

// final timerProvider = StateNotifierProvider<TimerNotifier, int>((ref) {
//   return TimerNotifier();
// });