import 'dart:async';

import 'package:education/templates/middleAssignment/models/provider/provider.dart';
import 'package:education/templates/middleAssignment/models/shower_session.dart';
import 'package:education/templates/middleAssignment/screens/finish_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:education/templates/middleAssignment/services/storage_manager.dart';

class SessionScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<SessionScreen> createState() => _SessionScreenState();
}

class _SessionScreenState extends ConsumerState<SessionScreen> {
  final controller = TextEditingController();
  final controllerNumber = TextEditingController();
  final StorageManager storageManager = StorageManager();

  int actualNumber = 0;

  int timeLeft = 0;

  DateTime start = DateTime.now();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    ref.read(valueProvider.notifier);
  }



  @override
  Widget build(BuildContext context) {
    final value = ref.watch(valueProvider);


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
            },
            child: Text('Start Workout'),
          ),
          ElevatedButton(
            onPressed: () {
              value.addSession(ShowerSession(
                  DateFormat('yyyy-MM-dd HH:mm:ss').format(start),
                  actualNumber,
                  value.cycles));
              storageManager
                  .saveSessionsData(value.sessions); 
              Navigator.of(context).pushNamed('/finish_session');
            },
            child: Text('Finish'),
          ),
        ],
      )),
    );
  }
}
