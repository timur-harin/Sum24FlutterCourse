import 'dart:async';

import 'package:education/templates/middleAssignment/TimerScreen2.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

double CoT=0;
double HoT=0;
int tim=0;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TimerScreen(),
    );
  }
}

class TimerScreen extends StatefulWidget {
  @override
  _TimerScreenState createState() => _TimerScreenState();
}

 class _TimerScreenState extends State<TimerScreen> {
  int _selectedTime = 10; // время по умолчанию
  double _selectedTemperature = 22.0; // температура по умолчанию
  double _selectedColdTempr = 16.0;
  double _ColdPeriod= 10.0;
  double _HotPeriod=10.0;
  Timer? _timer; // таймер
  bool _isRunning = false; // флаг запущенного таймера

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Выберите время:',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedTime -= 10;
                      if (_selectedTime < 0) _selectedTime = 0;
                    });
                  },
                  child: Text('-10 сек'),
                ),
                SizedBox(width: 20),
                Text('$_selectedTime сек'),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedTime += 10;
                    });
                  },
                  child: Text('+10 сек'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Выберите температуру холодной воды:',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedColdTempr -= 1.0;
                      CoT=_selectedColdTempr;
                    });
                  },
                  child: Text('-1 град'),
                ),
                SizedBox(width: 20),
                Text('${_selectedColdTempr.toStringAsFixed(1)} град'),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedColdTempr += 1.0;
                      CoT=_selectedColdTempr;
                    });
                  },
                  child: Text('+1 град'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Выберите температуру горячей воды:',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedTemperature -= 1.0;
                      HoT=_selectedTemperature;
                    });
                  },
                  child: Text('-1 град'),
                ),
                SizedBox(width: 20),
                Text('${_selectedTemperature.toStringAsFixed(1)} град'),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedTemperature += 1.0;
                      HoT=_selectedTemperature;
                    });
                  },
                  child: Text('+1 град'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Выберите время периода горячей воды:',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _HotPeriod -= 10.0;
                    });
                  },
                  child: Text('-10 cек'),
                ),
                SizedBox(width: 20),
                Text('${_HotPeriod.toStringAsFixed(1)} сек'),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _HotPeriod += 10.0;
                    });
                  },
                  child: Text('+10 сек'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Выберите время периода холодной воды:',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _ColdPeriod -= 10.0;
                    });
                  },
                  child: Text('-10 cек'),
                ),
                SizedBox(width: 20),
                Text('${_ColdPeriod.toStringAsFixed(1)} сек'),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _ColdPeriod += 10.0;
                    });
                  },
                  child: Text('+10 сек'),
                ),
              ],
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => TimerScreen2(
                  time: _selectedTime,
                  coldTemp: _selectedColdTempr,
                  hotTemp: _selectedTemperature,
                  coldPeriod:  _ColdPeriod,
                  hotPeriod:  _HotPeriod,
                )));
              },
              child: Text( 'Старт'),
            ),
          ],
        ),
      ),
    );
  }
}