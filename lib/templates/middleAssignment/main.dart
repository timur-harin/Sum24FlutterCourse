import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: MiddleAssigmentApp()
  ));
}

class MiddleAssigmentApp extends StatelessWidget {
  const MiddleAssigmentApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Middle Assigment',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Previous sessions: '),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SettingsScreen()
                    )
                  );
                },
                child: const Text('Start new session'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ActiveSessionScreen extends StatefulWidget {
  final int time;
  final List<double> temperatureIntervals;

  ActiveSessionScreen({required this.time, required this.temperatureIntervals});
  
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<ActiveSessionScreen> with SingleTickerProviderStateMixin {
  Timer? _timer;
  late int _secondsRemaining;
  bool _isTimerRunning = true;
  late AnimationController _controller;
  late Animation<double> _animation;
  int currentInterval = 0;

  @override
  void initState() {
    super.initState();
    _secondsRemaining = widget.time ~/ 5;
    startTimer();
   
    _controller = AnimationController(
      duration: Duration(seconds: widget.time ~/ 5),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          if (currentInterval < 4) {
            currentInterval++;
            _controller.reset();
            _controller.forward();
          }
        }
      });

    _controller.forward();
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
          if (_secondsRemaining == 0 && currentInterval < 4) {
            // AudioPlayer = AudioCache
            _secondsRemaining = widget.time ~/ 5;
          } else if (_secondsRemaining == 0 && currentInterval == 4) {
            endSession();
          }
        } else {
          _timer?.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void stopTimer() {
    if (_isTimerRunning) {
      setState(() {
        _timer?.cancel();
        _controller.stop();
      });
    } else {
      startTimer();
      _controller.forward();
    }
  }

  void endSession() {
    _timer?.cancel();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FinalScreen(time: (_secondsRemaining~/5)*currentInterval+_secondsRemaining, tempIntervals: widget.temperatureIntervals)),
  );
  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Session processing'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 600, // Increase the width value
              height: 600, // Increase the height value
              child: AnimatedBuilder(
                animation: _animation,
                builder: (BuildContext context, Widget? child) {
                  return Column(
                    children: [
                      CustomPaint(
                        painter: CircleTimerPainter(
                          animation: _animation,
                          temperature: widget.temperatureIntervals[currentInterval],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Temperature: ${widget.temperatureIntervals[currentInterval]}',
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Phase №: ${currentInterval+1}',
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(height: 10),
                            Text(
                              '$_secondsRemaining',
                              style: TextStyle(fontSize: 32),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              )
            ),
            Column (
              children: [
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    stopTimer();
                    _isTimerRunning = !_isTimerRunning;
                  },
                  child: Text(_isTimerRunning ? 'Pause' : 'Continue'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FinalScreen(time: (_secondsRemaining~/5)*currentInterval+_secondsRemaining, tempIntervals: widget.temperatureIntervals),
                      )
                    );
                  },
                  child: Text('End session'),
                ),
              ]
            ),
          ],
        ),
      ),
    );
  }
}

class CircleTimerPainter extends CustomPainter {
  late double temperature;
  late Animation<double> animation;

  CircleTimerPainter({required this.animation, required this.temperature})
      : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = _getColorFromTemperature(temperature)
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - paint.strokeWidth) / 2;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -1.5 / 3.14,
      3.14 * 2 * animation.value,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CircleTimerPainter oldDelegate) {
    return animation.value != oldDelegate.animation.value;
  }

  Color _getColorFromTemperature(double temperature) {
  // Ваш код для определения цвета в зависимости от температуры
  if (temperature > 30) {
    return Colors.red;
  } else if (temperature > 20) {
    return Colors.orange;
  } else {
    return Colors.blue;
  }
}
}

// class CircleTimerPainter {
//   AnimationController animationController = AnimationController(
//     duration: Duration(seconds: 10),
//     vsync: this,
//   );

// Animation<double> animation = Tween<double>(begin: 0, end: 1).animate(animationController);

// animationController.forward();

// ...

// @override
// Widget build(BuildContext context) {
//   return AnimatedBuilder(
//     animation: animation,
//     builder: (BuildContext context, Widget child) {
//       return Text('${(animation.value * 10).floor()}');
//     },
//   );
// }

// }

// class TextInputField extends StatefulWidget {
//   @override
//   _TextInputFieldState createState() => _TextInputFieldState();
// }

// class _TextInputFieldState extends State<TextInputField> {
//   TextEditingController _controller = TextEditingController();

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       controller: _controller,
//       decoration: InputDecoration(
//         labelText: 'Duration (in seconds):',
//         hintText: 'Duration (in seconds):',
//       ),
//     );
//   }
// }

class SettingsScreen extends StatefulWidget {
  @override
  _MyHomePageState1 createState() => _MyHomePageState1();
}

class _MyHomePageState1 extends State<SettingsScreen> {
  TextEditingController _controller = TextEditingController();
  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  TextEditingController _controller3 = TextEditingController();
  TextEditingController _controller4 = TextEditingController();
  TextEditingController _controller5 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('SETTINGS'),
        ),
        body: Center(
          child: Column(
            children: [ 
              Text('Duration', style: TextStyle(fontSize: 24),),
              SizedBox(height: 16),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32), 
                child: TextField(
                  controller: _controller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Enter the duration (in seconds):',
                  )
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: TextField(
                  controller: _controller1,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Enter the temperature for 1st phase:',
                  )
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: TextField(
                  controller: _controller2,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Enter the temperature for 2nd phase:',
                  )
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: TextField(
                  controller: _controller3,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Enter the temperature for 3rd phase:',
                  )
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: TextField(
                  controller: _controller4,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Enter the temperature for 4th phase:',
                  )
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: TextField(
                  controller: _controller5,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Enter the temperature for 5th phase:',
                  )
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  int time = int.tryParse(_controller.text) ?? 0;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ActiveSessionScreen(time: time, temperatureIntervals: [double.parse(_controller1.text), double.parse(_controller2.text), double.parse(_controller3.text), double.parse(_controller4.text), double.parse(_controller5.text)]),
                    )
                  );
                },
                child: Text('Start'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ActiveSessionScreen(time: 50, temperatureIntervals: [10, 10, 10, 10, 10]),
                    )
                  );
                },
                child: Text('Default'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class FinalScreen  extends StatefulWidget {
  late int time;
  late List<double> tempIntervals;

  FinalScreen({required this.time, required this.tempIntervals});
  @override
  _FinalScreen createState() => _FinalScreen();
}

class _FinalScreen extends State<FinalScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Final screen'),
        ),
        body: Center(
          child: Text('Final screen'),
        ),
      ),
    );
  }
}

class StarButton extends StatefulWidget {
  @override
  _StarButtonState createState() => _StarButtonState();
}

class _StarButtonState extends State<StarButton> {
  bool _isStarred = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        _isStarred ? Icons.star : Icons.star_border,
        color: _isStarred ? Colors.yellow : Colors.grey,
      ),
      onPressed: () {
        setState(() {
          _isStarred = !_isStarred;
        });
      },
    );
  }
}

