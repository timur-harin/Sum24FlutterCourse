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
  bool _isPuase = false;
  int _seconds = 60;
  Timer? _timer;

  void startTime() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_seconds == 0) {
          _progress = 0;
          _seconds = 60;
          _isPuase = false;
          //_timer?.cancel();
          _onTimerComplete();
        } else {
          _seconds--;
          _progress += 1 / 60;
        }
      });
    });
  }

  void _onTimerComplete() {
    final dataProvider = Provider.of<DataProvider>(context, listen: false);
    final selectedTemperaturePhase = dataProvider.selectedTemperaturePhase;
    final selectedSessionDuration = dataProvider.selectedSessionDuration;

    final newEvent = CustomEvent(date: DateTime.now())
        .setPhase(selectedTemperaturePhase!)
        .updateDuration(selectedSessionDuration.inSeconds)
        .updateColor();

    dataProvider.addCustomEvent(newEvent);

    Navigator.pushReplacementNamed(context, '/');
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
    return Scaffold(
      backgroundColor: Colors.lightGreen[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black87,
          ),
          onPressed: () {
            Navigator.of(context).pushNamed('/');
          },
        ),
      ),
      body: Center(
        child: Consumer<DataProvider>(
          builder: (context, dataProvider, child) {
            final selectedTemperaturePhase =
                dataProvider.selectedTemperaturePhase;
            final selectedSessionDuration =
                dataProvider.selectedSessionDuration;
            return Column(
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
                      value: _progress,
                    ),
                  ),
                  Text(
                      formattedTime(
                          timeInSeconds:
                              dataProvider.selectedSessionDuration.inSeconds),
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
                            _seconds = 60;
                            _isPuase = false;
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
                          if (_isPuase) {
                            _timer?.cancel();
                          } else {
                            startTime();
                          }
                          setState(() {
                            _isPuase = !_isPuase;
                          });
                        },
                        icon: Icon(
                          _isPuase
                              ? Icons.stop_circle_outlined
                              : Icons.play_circle_outline_outlined,
                          size: 70,
                          color: _isPuase ? Colors.red : Colors.green,
                        ),
                        tooltip: _isPuase ? 'Pause' : ('Begin Session'),
                      ),
                    ])
              ],
            );
          },
        ),
      ),
    );
  }
}
