import 'dart:async';
import 'package:education/templates/middleAssignment/ShowerCycle.dart';
import  'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'storage.dart';

class ShowerProcessScreen extends StatefulWidget {

  final ShowerCycle showerCycle;
  final LocalStorage localStorage = LocalStorage();

  ShowerProcessScreen({super.key, required this.showerCycle});

  @override
  State<StatefulWidget> createState() => _ShowerProcessScreenState();

}

class _ShowerProcessScreenState extends State<ShowerProcessScreen> {
  late int totalTimeInSeconds;
  late int timeLeftForPhase;
  late Timer _timer;
  late bool isHotWaterPhase;
  late int phaseDuration;

  @override
  void initState() {
    super.initState();
    totalTimeInSeconds = countTotalTime();
    timeLeftForPhase = widget.showerCycle.startingPhase == 'Hot water'
        ? widget.showerCycle.hotWaterMinutes * 60
        : widget.showerCycle.coldWaterMinutes * 60;
    isHotWaterPhase = widget.showerCycle.startingPhase == 'Hot water';
    phaseDuration = timeLeftForPhase;
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (timeLeftForPhase > 0) {
          timeLeftForPhase--;
        } else {
          switchPhase();
        }
        if (totalTimeInSeconds > 0) {
          totalTimeInSeconds--;
        } else {
          _timer.cancel();
          onProcessFinished();
        }
      });
    });
  }

  void switchPhase() {
    isHotWaterPhase = !isHotWaterPhase;
    timeLeftForPhase = isHotWaterPhase
        ? widget.showerCycle.hotWaterMinutes * 60
        : widget.showerCycle.coldWaterMinutes * 60;
  }

  void onProcessFinished() async {
    await widget.localStorage.saveShower(widget.showerCycle);
    Navigator.pop(context, true);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedContainer(
            duration: Duration(seconds: 3),
            color: isHotWaterPhase ? Colors.red : Colors.blue,
            child: Center(
              child: Text(
                formatTime(timeLeftForPhase),
                style: TextStyle(fontSize: 48, color: Colors.white),
              ),
            ),
          ),
          Positioned(
            top: 16,
            right: 16,
            child: Text(
              formatTime(totalTimeInSeconds),
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
          ),
          Positioned(
            top: 16,
            left: 16,
            child: IconButton(
              icon: Icon(Icons.stop, color: Colors.white),
              onPressed: () {
                _timer.cancel();
                Navigator.pop(context, false);
              },
            ),
          ),
        ],
      ),
    );
  }

  String formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  int countTotalTime() {
    ShowerCycle cycle = widget.showerCycle;
    final totalTime = (cycle.hotWaterMinutes + cycle.coldWaterMinutes) * cycle.numberOfCycles +
        (cycle.includeAdditionalTemperatureChange ? (cycle.startingPhase == 'Hot water' ? cycle.hotWaterMinutes : cycle.coldWaterMinutes) : 0);
    return totalTime * 60;
  }


}