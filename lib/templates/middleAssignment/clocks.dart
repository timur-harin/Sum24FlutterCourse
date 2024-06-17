import 'dart:async';

import 'package:education/templates/middleAssignment/homeScreen.dart';
import 'package:flutter/material.dart';

class Clocks extends StatefulWidget {
  final String time;
  final VoidCallback onIncrement;

  Clocks({
    Key? key,
    required this.time,
    required this.onIncrement,
  }) : super(key: key);

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
  double phase = 1.5 * 60;
  double phaseTO = 0;
  int seconds = 0;
  bool isGoing = true;

  @override
  void initState() {
    super.initState();
    time = int.parse(widget.time);
    if ((time / 1.5).floor() % 2 == 0) {
      phase = 1.5 * 60;
    } else {
      phase = (time / ((time / 1.5).floor() - 1)) * 60;
    }

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
        duration: Duration(seconds: 1), // Продолжительность анимации 1 секунда
        curve: Curves.easeInOut, // Кривая анимации для плавности
        color: isGoing ? stateColor[index] : stateColor[1],
        child: Center(
          child: Text(
            isGoing
                ? "${((time * 60 - seconds) / 60).floor()} : ${(10 * 60 - seconds) % 60}"
                : "Finish",
            style: TextStyle(fontSize: 72), // Устанавливаем размер шрифта
          ),
        ),
      ),
      floatingActionButton: isGoing
          ? null
          : IconButton(
              onPressed: () {
                widget.onIncrement();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Homescreen()),
                );
              },
              icon: Icon(Icons.arrow_back),
            ),
    );
  }
}
