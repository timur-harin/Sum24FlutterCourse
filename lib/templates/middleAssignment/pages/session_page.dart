import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../providers/provider.dart';
import 'package:provider/provider.dart';

class SessionPage extends StatefulWidget {
  const SessionPage({super.key});

  @override
  State<SessionPage> createState() => _SessionPageState();
}

class _SessionPageState extends State<SessionPage> {
  int number_cycles = 0;

  int actual_number = 0;

  static int time_left = 0;

  var color = '- - -';

  var tempColor = const Color.fromARGB(255, 194, 239, 245);

  late Timer _timer;

  bool checker = true;

  int sec = 0;
  int min = 0;
  String secStr = '00';
  String minStr = '00';

  void startTimer(int numberCycles, int numberInCycle, var colors, Color cc,
      int currentTime) {
    time_left = currentTime;
    final cycles = numberCycles;
    number_cycles = numberCycles;
    color = colors;
    tempColor = cc;

    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (checker) {
          timer.cancel();
        }
        actual_number++;
        sec = actual_number % 60;
        min = (actual_number / 60).floor();
        if (sec < 10) {
          secStr = '0' + sec.toString();
        } else {
          secStr = sec.toString();
        }
        if (min < 10) {
          minStr = '0' + min.toString();
        } else {
          minStr = min.toString();
        }
        if (time_left == 1) {
          if (cycles > 1) {
            time_left--;
            number_cycles--;
            setState(() {
              if (color == 'Hot') {
                print('TO COLD HUI');
                tempColor = const Color.fromRGBO(100, 170, 228, 1);
              } else {
                print('TO HOT HUI');
                tempColor = const Color.fromARGB(255, 232, 145, 139);
              }
              timer.cancel();
            });
            if (color == 'Hot') {
              startTimer(
                  cycles - 1, numberInCycle, 'Cold', tempColor, numberInCycle);
            } else {
              startTimer(
                  cycles - 1, numberInCycle, 'Hot', tempColor, numberInCycle);
            }
          } else if (cycles == 1) {
            setState(() {
              time_left--;
              number_cycles--;
            });
            timer.cancel();
          }
        } else {
          setState(() {
            time_left--;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final sessionProvider = Provider.of<SessionProvider>(context);

    final number = sessionProvider.number;
    final numberOfcycles = sessionProvider.numberCycles;
    final initColor = sessionProvider.color;
    final curColor = sessionProvider.colorColor;

    return Scaffold(
        backgroundColor: tempColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Text(
              minStr + ':' + secStr, 
              style: TextStyle(fontSize: 100)
            ),
            
            Text(
              'To end of cycle: $time_left sec',
              style: TextStyle(fontSize: 20),
            ),
            Padding(padding: EdgeInsets.only(top: 10)),
            Text(
              'Remaining cycles: $number_cycles',
              style: TextStyle(fontSize: 20),
            ),
            Padding(padding: EdgeInsets.only(top: 10)),
            Text(
              'Current temperature: $color',
              style: TextStyle(fontSize: 20),
            ),
            Padding(padding: EdgeInsets.only(top: 10)),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      width: 200,
                      height: 50,
                      child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all<Color>(
                                const Color.fromARGB(255, 235, 255, 119)),
                            textStyle: WidgetStateProperty.all<TextStyle>(
                                const TextStyle(fontSize: 20)),
                            foregroundColor:
                                WidgetStateProperty.all<Color>(Colors.black),
                          ),
                          onPressed: () {
                            checker = false;
                            startTimer(numberOfcycles, number, initColor,
                                curColor, number);
                          },
                          child: Text('Start'))),
                  Padding(padding: EdgeInsets.only(left: 20)),
                  Container(
                      width: 200,
                      height: 50,
                      child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all<Color>(
                                const Color.fromARGB(255, 235, 255, 119)),
                            textStyle: WidgetStateProperty.all<TextStyle>(
                                const TextStyle(fontSize: 20)),
                            foregroundColor:
                                WidgetStateProperty.all<Color>(Colors.black),
                          ),
                          onPressed: () {
                            setState(() {
                              checker = !checker;
                            });
                            if (!checker) {
                              startTimer(number_cycles, number, color,
                                  tempColor, time_left);
                            }
                          },
                          child: Icon(Icons.pause))),
                  Padding(padding: EdgeInsets.only(left: 20)),
                  Container(
                      width: 200,
                      height: 50,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all<Color>(
                              const Color.fromARGB(255, 235, 255, 119)),
                          textStyle: WidgetStateProperty.all<TextStyle>(
                              const TextStyle(fontSize: 20)),
                          foregroundColor:
                              WidgetStateProperty.all<Color>(Colors.black),
                        ),
                        onPressed: () {
                          checker = true;
                          sessionProvider.duration = actual_number;
                          sessionProvider.numberCycles -= number_cycles;
                          Navigator.of(context).pushNamed('/finish');
                        },
                        child: Text('Finish'),
                      ))
                ],
              ),
            )
          ]),
        ));
  }
}
