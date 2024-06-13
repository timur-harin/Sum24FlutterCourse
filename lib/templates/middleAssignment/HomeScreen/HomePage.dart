import 'dart:isolate';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Duration duration = Duration();
  Timer? timer;

  @override
  void initState() {
    super.initState();
    
    // startTimer();
  }

  void addTime() {
    final addSeconds = 1;
    setState(() {
      final seconds = duration.inSeconds + addSeconds;
      duration = Duration(seconds: seconds);
    });
  }

  void reset() {
    setState(() => duration = Duration());
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) => addTime());
  }
  void stopTimer({bool resets = true}) {
    if (resets) {
      reset();
      timer?.cancel();
    } else {
      setState(() => timer?.cancel());
    }
  }

  @override
  Widget build(BuildContext context) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment. spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildTimeCard(time: minutes, header: 'MINUTES'),
                const SizedBox(width: 8),
                buildTimeCard(time: seconds, header: 'SECONDS'),
              ]
            ),
            buttons(),
          ],
        ),
      ),
    );
  }


  Widget buttons(){
    final isRunning = timer == null ? false : timer!.isActive;
    final isCompleted = duration.inSeconds == 0;

    return isRunning || !isCompleted ?
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              if (isRunning){
                stopTimer(resets: false);
              } else {
                startTimer();
              }
            },
            child: isRunning? Text('STOP') : Text('RESUME'),
          ),
          const SizedBox(width: 12),
          ElevatedButton(
            onPressed: () {
              stopTimer(resets: true);
            },
            child: Text('RESET'),
          ),
        ],
      ) : 
      ElevatedButton(
        onPressed: () {
          startTimer();
        },
        child: Text('START'),
      );
  }

  Widget buildTimeCard({required String time, required String header}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.blue[600],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            time,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 40,
            ),
          ),
        ),
        SizedBox(height: 16),
        Text(
          header,
          style: TextStyle(
            fontSize: 15,
            color: Colors.blue[600],
          ),
        ),
      ],
    );
  }
}
