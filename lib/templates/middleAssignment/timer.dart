import 'package:education/templates/middleAssignment/SessionSummary.dart';
import 'package:education/templates/middleAssignment/UserPreferences.dart';
import 'package:education/templates/middleAssignment/riverpod.dart';
import 'package:education/templates/widgets/round-button.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

import 'package:flutter/widgets.dart';

class TimerScreen extends StatefulWidget {
  final int overallTime, repetitions;
  final Duration hotTime, coldTime;
  const TimerScreen(
      {super.key,
      required this.overallTime,
      required this.repetitions,
      required this.hotTime,
      required this.coldTime});

  @override
  _TimerScreenState createState() => _TimerScreenState(
      overallTime: overallTime,
      repetitions: repetitions,
      hotTime: hotTime,
      coldTime: coldTime);
}

class _TimerScreenState extends State<TimerScreen>
    with TickerProviderStateMixin {
  bool isHot = true;
  Timer? _timer;
  int overallTime, repetitions, overallHot = 0, overallCold = 0;
  Duration hotTime, coldTime;
  bool _isTimer1 = true;
  String timer1Text = '00 : 00 : 00';
  String timer2Text = '00 : 00 : 00';
  String itog = '00 : 00 : 00';
  double progress = 1.0;
  late AnimationController controller1, controller2;
  late AnimationController controller;
  bool isPlaying = true;
  FlutterRingtonePlayer _ringtonePlayer = FlutterRingtonePlayer();

  _TimerScreenState(
      {required this.overallTime,
      required this.repetitions,
      required this.hotTime,
      required this.coldTime});

  String get _timerText {
    Duration count = controller.duration! * controller.value;
    itog = controller.isDismissed
        ? '${(controller.duration!.inHours % 60).toString().padLeft(2, '0')} : ${(controller.duration!.inMinutes % 60).toString().padLeft(2, '0')} : ${(controller.duration!.inSeconds % 60).toString().padLeft(2, '0')}'
        : '${(count.inHours % 60).toString().padLeft(2, '0')} : ${(count.inMinutes % 60).toString().padLeft(2, '0')} : ${(count.inSeconds % 60).toString().padLeft(2, '0')}';
    return itog;
  }

  @override
  void initState() {
    super.initState();
    hotTime = widget.hotTime + Duration(seconds: 1);
    coldTime = widget.coldTime + Duration(seconds: 1);
    overallTime = widget.overallTime;
    repetitions = widget.repetitions;

    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    if (isPlaying) {
      if (repetitions > 0) {
        _timer?.cancel();

        progress = 1.0;

        Duration curTimer = isHot ? hotTime : coldTime;

        controller = AnimationController(
          vsync: this,
          duration: curTimer,
        );

        controller.reverse(
            from: controller.value == 0 ? 1.0 : controller.value);

        controller.addListener(() {
          if (controller.isAnimating) {
            setState(() {
              progress = controller.value;
            });
          } else {
            setState(() {
              progress = 1.0;
            });
          }
        });

        _timer = Timer.periodic(curTimer, (timer) {
          setState(() {
            isHot = !isHot;
            if (_isTimer1) {
              _ringtonePlayer.playAlarm(volume: 0.5);
              Future.delayed(Duration(seconds: 2), () {
        _ringtonePlayer.stop();
              });
              curTimer = coldTime;
              overallTime += hotTime.inSeconds - 1;
              overallHot += hotTime.inSeconds - 1;
              
            } else {
              _ringtonePlayer.playAlarm(volume: 0.5);
              curTimer = hotTime;
              overallTime += coldTime.inSeconds - 1;
              overallCold += coldTime.inSeconds - 1;
              repetitions--;
              //_ringtonePlayer.stop();
              Future.delayed(Duration(seconds: 2), () {
        _ringtonePlayer.stop();
              });
            }
            _isTimer1 = !_isTimer1;
            startTimer();
          });
        });
      } else {
        _timer?.cancel();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SessionSummary(
                    overallTime: overallTime + coldTime.inSeconds - 1,
                    repetitions: repetitions - 1, overallHot: overallHot, overallCold: overallCold)));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isHot
          ? const Color.fromRGBO(231, 1, 13, 1)
          : Color.fromARGB(255, 2, 112, 202),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 350,
                    height: 350,
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.white,
                      value: progress,
                      strokeWidth: 6,
                      valueColor: isHot
                          ? AlwaysStoppedAnimation<Color>(Colors.red)
                          : AlwaysStoppedAnimation<Color>(Colors.blue),
                    ),
                  ),
                  Text(
                    _timerText,
                    style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    if (controller.isAnimating) {
                      controller.stop();
                      setState(() {
                        isPlaying = false;
                      });
                    } else {
                      controller.reverse(
                          from: controller.value == 0 ? 1.0 : controller.value);
                      setState(() {
                        isPlaying = true;
                      });
                    }
                  },
                  child: RoundButton(
                    icon: isPlaying == true ? Icons.pause : Icons.play_arrow,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    controller.reset();
                    setState(() {
                      isPlaying = false;
                    });
                    _timer?.cancel();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UserPreferences()));
                  },
                  child: RoundButton(
                    icon: Icons.refresh,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  isPlaying = false;
                });
                int remain = 0;
                if (isHot) {
                  remain = hotTime.inSeconds -
                      1 -
                      (int.parse(itog.split(' ')[0]) * 3600 +
                          int.parse(itog.split(' ')[2]) * 60 +
                          int.parse(itog.split(' ')[4]));
                          overallHot += remain;
                } else {
                  remain = coldTime.inSeconds -
                      1 -
                      (int.parse(itog.split(' ')[0]) * 3600 +
                          int.parse(itog.split(' ')[2]) * 60 +
                          int.parse(itog.split(' ')[4]));
                          overallCold += remain;
                }
                _timer?.cancel();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SessionSummary(
                            overallTime: overallTime + remain,
                            repetitions: repetitions, overallHot: overallHot, overallCold: overallCold)));
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Color.fromARGB(255, 0, 0, 0),
                backgroundColor: Color.fromRGBO(
                    255, 255, 255, 1), // Foreground color (text color)
                textStyle: TextStyle(
                    fontSize: 17, fontWeight: FontWeight.bold), // Text style
                elevation: 5, // Elevation
              ),
              child: Text('Finish')),
        ],
      ),
    );
  }
}
