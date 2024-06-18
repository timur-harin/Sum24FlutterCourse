import 'dart:async';
import 'package:education/templates/middleAssignment/ScreenLike.dart';
import 'package:flutter/material.dart';
 
int ColdCount=0;
int HotCount=0;
int time2=0;
int time3=0;
class TimerScreen2 extends StatefulWidget {
  final int time;
  final double coldTemp;
  final double hotTemp;
  final double coldPeriod;
  final double hotPeriod;
  const TimerScreen2({
    required this.coldTemp,
    required this.hotTemp,
    required this.time,
    required this.coldPeriod,
    required this.hotPeriod,
  });

  @override
  State<TimerScreen2> createState() => _TimerScreen2State();
}
class _TimerScreen2State extends State<TimerScreen2> {
  int _remainTime = 0;
  bool _isRunning = false;
  Timer? _timer;
  Color _backgroundColor = Colors.blue;
  
  get time => time;
  
  get coldTemp => coldTemp;
  
  get hotTemp => hotTemp;
  
  get coldPeriod => coldPeriod;
  
  get hotPeriod => hotPeriod;
   

  @override
  void initState() {
    super.initState();
    _remainTime = widget.time;
  }

  void _startTimer() {
    if (!_isRunning) {
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          _remainTime -= 1;
          if (_remainTime <= 0) {
            _timer?.cancel();
            _isRunning = false;
            Navigator.push(context, MaterialPageRoute(builder: (context) => ScreenLike()));
          } else if ( _backgroundColor==Colors.blue && _remainTime % widget.coldPeriod == 0) { 
            ColdCount+=1;
            _changeBackgroundColor(); 
            _showMessage(); 
          } else if(_backgroundColor==Colors.red && _remainTime % widget.hotPeriod == 0) { 
            _changeBackgroundColor(); 
            _showMessage(); 
            HotCount+=1;
        }});
      });
      setState(() {
        _isRunning = true;
      });
    } else {
      _timer?.cancel();
      setState(() {
        _isRunning = false;
        Navigator.push(context, MaterialPageRoute(builder: (context) => ScreenLike()));

      });
    }
    time2=widget.time -_remainTime;
    time3=widget.time;
  }

  void _changeBackgroundColor() {
    setState(() {
      _backgroundColor = _backgroundColor == Colors.blue? Colors.red : Colors.blue; 
    });
  }

  void _showMessage() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text('Поменяйте температуру воды'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: _backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              width: 20.0,
              height: 20.0,
            ),
            Text(
              'Осталось $_remainTime сек',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _startTimer,
              child: Text(_isRunning? 'Остановить' : 'Старт'),
            ),
          ],
        ),
      ),
    );
  }
}
