import 'dart:async';

import 'package:education/templates/middleAssignment/homeScreen.dart';
import 'package:flutter/material.dart';

class Clocks extends StatefulWidget {
  final String time;
  final String phase;
  final VoidCallback onIncrement;
  final VoidCallback prevent;

  Clocks(
      {Key? key,
      required this.time,
      required this.phase,
      required this.onIncrement,
      required this.prevent})
      : super(key: key);

  @override
  _BigClockState createState() => _BigClockState();
}

class _BigClockState extends State<Clocks> {
  late Timer _timer;
  late DateTime _currentTime;
  late int time;
  var stateColor = [
    Color.fromRGBO(230, 31, 31, 1),
    Color.fromRGBO(16, 89, 171, 1)
  ];
  int index = 0;
  late int phase;
  double phaseTO = 0;
  int seconds = 0;
  bool isGoing = true;
  bool pause = false;

  @override
  void initState() {
    super.initState();
    time = int.parse(widget.time);
    phase = int.parse(widget.phase).round();

    _timer = Timer.periodic(Duration(seconds: 1), _updateTime);

    _currentTime = DateTime.now();
  }

  @override
  void dispose() {
    // Останавливаем таймер при уничтожении виджета
    _timer.cancel();
    super.dispose();
  }

  void _updateTime(Timer timer) {
    if (!pause) {
      setState(() {
        seconds++;
        phaseTO++;
        if (phaseTO > phase) {
          phaseTO = 0;
          if (index == 0) {
            index = 1;
          } else {
            index = 0;
          }
        }
        if (seconds > time * 60) {
          isGoing = false;
          _timer.cancel();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Форматируем текущее время в строку "часы:минуты:секунды"
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(53, 126, 212, 1),
        centerTitle: true,
        title: const SizedBox(
          height: 50,
          child: Text(
            "Showing in process",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30,
              color: Color.fromRGBO(0, 0, 0, 1),
              fontWeight: FontWeight.bold,
              fontFamily: 'Title',
            ),
          ),
        ),
      ),
      body: AnimatedContainer(
        duration: Duration(seconds: 1),
        curve: Curves.easeInOut,
        color: isGoing ? stateColor[index] : stateColor[1],
        child: Center(
          child: isGoing
              ? Column(children: [
                  Text(
                    "${((time * 60 - seconds) / 60).floor()} : ${(10 * 60 - seconds) % 60}",
                    style: TextStyle(fontSize: 72),
                  ),
                  pause
                      ? TextButton(
                          onPressed: () {
                            setState(() {
                              pause = false;
                            });
                          },
                          child: Text('Continue'),
                          style: ButtonStyle(
                            padding: WidgetStateProperty.all(
                                const EdgeInsets.all(15)),
                            backgroundColor: WidgetStateProperty.all(
                                const Color.fromRGBO(53, 175, 212, 1)),
                          ),
                        )
                      : TextButton(
                          onPressed: () {
                            setState(() {
                              pause = true;
                            });
                          },
                          child: Text('Pause'),
                          style: ButtonStyle(
                            padding: WidgetStateProperty.all(
                                const EdgeInsets.all(15)),
                            backgroundColor: WidgetStateProperty.all(
                                const Color.fromRGBO(53, 175, 212, 1)),
                          ),
                        ),
                  SizedBox(
                    height: 15,
                  ),
                  TextButton(
                    onPressed: () {
                      widget.prevent();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Homescreen()),
                      );
                    },
                    child: Text('Cansle'),
                    style: ButtonStyle(
                      padding:
                          WidgetStateProperty.all(const EdgeInsets.all(15)),
                      backgroundColor: WidgetStateProperty.all(
                          const Color.fromRGBO(53, 175, 212, 1)),
                    ),
                  )
                ])
              : TextButton(
                  onPressed: () {
                    widget.onIncrement();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Homescreen()),
                    );
                  },
                  style: ButtonStyle(
                    padding: WidgetStateProperty.all(const EdgeInsets.all(15)),
                    backgroundColor: WidgetStateProperty.all(
                        const Color.fromRGBO(53, 175, 212, 1)),
                  ),
                  child: const Text("Finish",
                      style: TextStyle(
                          fontSize: 72, color: Color.fromRGBO(0, 0, 0, 1)))),
        ),
      ),
    );
  }
}
