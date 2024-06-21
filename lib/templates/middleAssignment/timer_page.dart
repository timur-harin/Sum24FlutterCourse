import 'dart:async';
import 'package:flutter/material.dart';
import 'provider.dart';
import 'package:provider/provider.dart';
import 'home_page.dart';

class TimerPage extends StatefulWidget {
  @override
  State<TimerPage> createState() => _TimerPage();

  const TimerPage({super.key});
}

class _TimerPage extends State<TimerPage> {
  double _progress = 0;
  bool _isPaused = false;
  var _seconds;
  Timer? _timer;
  double _progressCircle = 0;

  @override
  void startTime(int secondsValue) {
    _seconds = secondsValue;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_seconds <= 0) {
          _progress = 0;
          _seconds = secondsValue;
          _isPaused = false;
          _onTimerComplete();
        } else {
          _seconds--;
          _progress += 1;
          _progressCircle += 1 / secondsValue;
        }
      });
    });
  }

  void _onTimerComplete() {
    _timer?.cancel();

    _showConfirmationDialog(context);
  }

  Future<void> _showConfirmationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmation'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Do you want to save this session?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed('/');
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                final dataProvider =
                    Provider.of<DataProvider>(context, listen: false);
                final selectedTemperaturePhase =
                    dataProvider.selectedTemperaturePhase;
                final selectedSessionDuration =
                    dataProvider.selectedSessionDuration;

                final newEvent = CustomEvent(date: DateTime.now())
                    .setPhase(selectedTemperaturePhase!)
                    .updateDuration(selectedSessionDuration.inSeconds)
                    .updateColor();

                dataProvider.addCustomEvent(newEvent);

                Navigator.of(context).pop();
                Navigator.of(context).pushNamed('/');
              },
            ),
          ],
        );
      },
    );
  }

  String formattedTime({required int timeInSeconds}) {
    int sec = timeInSeconds % 60;
    int min = (timeInSeconds / 60).floor();
    String minute = min.toString().length <= 1 ? '0$min' : '$min';
    String second = sec.toString().length <= 1 ? '0$sec' : '$sec';
    return '$minute:$second';
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(builder: (context, dataProvider, child) {
      final selectedTemperaturePhase = dataProvider.selectedTemperaturePhase;
      final selectedSessionDuration = dataProvider.selectedSessionDuration;
      Color backgroundColor = Colors.lightGreen[50]!;
      if (selectedTemperaturePhase != null) {
        if (selectedTemperaturePhase.description == 'Cold temperature') {
          backgroundColor = const Color.fromARGB(255, 136, 217, 255)!;
        } else if (selectedTemperaturePhase.description == 'Hot temperature') {
          backgroundColor = Color.fromARGB(255, 238, 174, 181)!;
        }
      }
      return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black87,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed('/startSessionPage');
            },
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(100.0),
                child: Column(children: [
                  Text(
                      'Let\'s start a ${selectedTemperaturePhase?.description} session!',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 24,
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(2.0, 2.0),
                            blurRadius: 2.0,
                            color: Color.fromARGB(255, 163, 151, 151),
                          ),
                        ],
                      )),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Press',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                          )),
                      SizedBox(width: 8),
                      Icon(Icons.play_circle_outline_outlined),
                    ],
                  )
                ]),
              ),
              Stack(alignment: Alignment.center, children: [
                SizedBox(
                  height: 250,
                  width: 250,
                  child: CircularProgressIndicator(
                    strokeWidth: 14,
                    backgroundColor: Colors.grey,
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Colors.white),
                    value: _progressCircle,
                  ),
                ),
                Text(
                    formattedTime(
                        timeInSeconds: selectedSessionDuration.inSeconds -
                            _progress.toInt()),
                    style: const TextStyle(
                      fontSize: 45,
                    ))
              ]),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _timer?.cancel();
                        _progress = 0;
                        _seconds = selectedSessionDuration.inSeconds;
                        _isPaused = false;
                      });
                    },
                    icon: const Icon(
                      Icons.stop_circle_sharp,
                      size: 70,
                      color: Colors.orange,
                    ),
                    tooltip: 'Stop',
                  ),
                  IconButton(
                    onPressed: () {
                      if (_isPaused) {
                        _timer?.cancel();
                      } else {
                        startTime(selectedSessionDuration.inSeconds -
                            _progress.toInt());
                      }
                      setState(() {
                        _isPaused = !_isPaused;
                      });
                    },
                    icon: Icon(
                      _isPaused
                          ? Icons.stop_circle_outlined
                          : Icons.play_circle_outline_outlined,
                      size: 70,
                      color: _isPaused ? Colors.red : Colors.green,
                    ),
                    tooltip: _isPaused ? 'Pause' : ('Begin Session'),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
