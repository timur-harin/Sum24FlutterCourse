import 'package:education/templates/middleAssignment/HomeScreen/DataSaver.dart';
import 'package:flutter/material.dart';

import 'dart:async';

// import 'package:education/templates/middleAssignment/HomeScreen/DataSaver.dart';
import 'package:education/templates/middleAssignment/HomeScreen/DataSaver.dart' as data_saver;
import 'package:education/templates/middleAssignment/HomeScreen/Statistic.dart' as stat;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  Duration duration = Duration();
  Timer? timer;


  @override
  void initState() {
    super.initState();
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

  void saveData(){
  data_saver.DataSaver dataSaver = data_saver.DataSaver(time: duration);
  stopTimer(resets: false);
  dataSaver.build(context);
  // dataSaver.setTime(newTime: duration);
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return data_saver.DataSaver(time: duration);
    }
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFDD0),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment. spaceEvenly,
          children: [
            statistics(),
            buttons(),
          ],
        ),
      ),
    );
  }

  Widget buttons() {
  final isRunning = timer == null ? false : timer!.isActive;
  final isCompleted = duration.inSeconds == 0;

  String twoDigits(int n) => n.toString().padLeft(2, '0');
  final minutes = twoDigits(duration.inMinutes.remainder(60));
  final seconds = twoDigits(duration.inSeconds.remainder(60));

  return IntrinsicWidth(
    child: Container(
    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    decoration: BoxDecoration(
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.circular(50.0), // Adjust to make it more oval
      color: Colors.blue.shade400,
    ),
    child: isRunning || !isCompleted
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  '$minutes:$seconds',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  )),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  if (isRunning) {
                    stopTimer(resets: false);
                  } else {
                    startTimer();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade700,
                ),
                child: isRunning 
                ? Icon(
                  Icons.pause,
                  color: Colors.white,
                )
                : Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                )
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: () {
                  if (isRunning) {
                    saveData();
                  } else {
                    stopTimer(resets: true);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade700,
                ),
                child: isRunning
                ? Text(
                  'SAVE',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                )
                : Icon(
                  Icons.cancel,
                  color: Colors.white,
                ),
              ),
            ],
          )
        : ElevatedButton(
            onPressed: () {
              startTimer();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.shade700,
            ),
            child: Text(
                'START TIMER',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
          ),
        ),
    );
  }

  Widget statistics() {
    return stat.Statistic();
  }

  // Widget data(){
  //   return data_saver.DataSaver();
  // }
}

