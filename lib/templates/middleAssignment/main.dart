import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MaterialApp(
    home: MiddleAssigmentApp()
  ));
}

class MiddleAssigmentApp extends StatefulWidget {
  @override
  _HistoryScreen createState() => _HistoryScreen();
}

class _HistoryScreen extends State<MiddleAssigmentApp> {
  List<Session> sessions = [];

  @override
  void initState() {
    super.initState();
    _loadSessions();
  }

  _loadSessions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      sessions = (json.decode(prefs.getString('sessions') ?? '[]') as List)
          .map((sessionJson) => Session.fromJson(sessionJson))
          .toList();
    });
  }

  _saveSessions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('sessions', json.encode(sessions));
  }

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Middle Assigment',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 209, 180, 255),
        appBar: AppBar(
          title: Text('Sessions history'),
        ),
        body: ListView.builder(
          itemCount: sessions.length,
          itemBuilder: (context, index) {
            final session = sessions[index];
            return ListTile(
              title: Text('Сессия ${index + 1}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Длительность: ${session.time}'),
                  Text('Температуры: ${session.temperatureIntervals}'),
                  Text('Оценка: ${session.rate}'),
                ],
              ),
            );
          },
        ),
        floatingActionButton: Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsScreen())
              ).then((result) {
                if (result != null && result is Session) {
                  setState(() {
                    sessions.insert(0, result);
                    if (sessions.length > 5) {
                      sessions.removeLast();
                    }
                    _saveSessions();
                  });
                }
              });
            },
            child: Text("Start", style: TextStyle(fontSize: 20)),
          ),
        ),
      )
    );
  }
}

class ActiveSessionScreen extends StatefulWidget {
  final Duration time;
  final List<int> temperatureIntervals;

  ActiveSessionScreen({required this.time, required this.temperatureIntervals});
  
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<ActiveSessionScreen> with SingleTickerProviderStateMixin {
  late Timer _timer;
  late Duration _secondsRemaining;
  int currentInterval = 0;
  bool _isTimerRunning = true;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _secondsRemaining = widget.time;

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining.inSeconds > 0) {
          // if (_secondsRemaining.inSeconds == 1) {
          //   soundPlay();
          // }
          _secondsRemaining = _secondsRemaining - Duration(seconds: 1);
        } else {
          timer.cancel();
          if (currentInterval < 4) {
            currentInterval++;
            _secondsRemaining =
                Duration(seconds: widget.time.inSeconds ~/ 5);
            startTimer();
          } else {
            _showRatingDialog();
          }
        }
      });
    });
   
    _controller = AnimationController(
      duration: Duration(seconds: widget.time.inSeconds ~/ 5),
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

  soundPlay() {
    AudioCache.instance = AudioCache(prefix: '');
    final player = AudioPlayer();
    player.play(AssetSource('lib/templates/middleAssignment/assets/signal.mp3'));
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining.inSeconds > 0) {
          // print(_secondsRemaining.inSeconds);
          if (_secondsRemaining.inSeconds == widget.time.inSeconds - (widget.time.inSeconds ~/ 5 * 5 - 1) ||
          _secondsRemaining.inSeconds == widget.time.inSeconds - (widget.time.inSeconds ~/ 5 - 1) ||
          _secondsRemaining.inSeconds == widget.time.inSeconds - (widget.time.inSeconds ~/ 5 * 2 - 1) ||
          _secondsRemaining.inSeconds == widget.time.inSeconds - (widget.time.inSeconds ~/ 5 * 3 - 1) ||
          _secondsRemaining.inSeconds == widget.time.inSeconds - (widget.time.inSeconds ~/ 5 * 4 - 1)) {
            print("OOOOOOOOOOOOOOOOOOO");
            soundPlay();
          }
          _secondsRemaining = _secondsRemaining - Duration(seconds: 1);
          // if (_secondsRemaining.inSeconds == 0 && currentInterval < 4) {
          //   _secondsRemaining = widget.time.inSeconds ~/ 5;
          // } else if (_secondsRemaining == 0 && currentInterval == 4) {
          //   endSession();
          // }
        } else {
          _timer.cancel();
          if (currentInterval < 4) {
            currentInterval++;
            _secondsRemaining =
                Duration(seconds: widget.time.inSeconds ~/ 5);
            startTimer();
          } else {
            _showRatingDialog();
          }
        }
      });
    });
  }

  void _showRatingDialog() {
    showDialog(
      context: context,
      builder: (context) => RatingDialog(
        totalTime: widget.time - _secondsRemaining,
        temperatureIntervals: widget.temperatureIntervals,
      ),
    ).then((result) {
      if (result != null && result is Session) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FinalScreen(session: result),
          ),
        ).then((_) {
          Navigator.pop(context, result);
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer.cancel();
    super.dispose();
  }

  void stopTimer() {
    if (_isTimerRunning) {
      setState(() {
        _timer.cancel();
        _controller.stop();
      });
    } else {
      startTimer();
      _controller.forward();
    }
  }

  // void endSession() {
  //   _timer.cancel();
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => FinalScreen(time: (widget.time~/5)*currentInterval+((widget.time ~/ 5) -_secondsRemaining), phases: currentInterval)),
  //   );
  // } 

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
              width: 300, // Increase the width value
              height: 300, // Increase the height value
              child: AnimatedBuilder(
                animation: _animation,
                builder: (BuildContext context, Widget? child) {
                  return Column(
                    children: [
                      CustomPaint(
                        painter: CircleTimerPainter(
                          animation: _animation,
                          temperature: widget.temperatureIntervals[currentInterval].toDouble(),
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
                              '${_secondsRemaining.inMinutes}:${_secondsRemaining.inSeconds.remainder(60).toString().padLeft(2, '0')}',
                              style: TextStyle(fontSize: 48.0),
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
                ElevatedButton(
                  onPressed: () {
                    _timer.cancel();
                    _showRatingDialog();
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

class RatingDialog extends StatefulWidget {
  final Duration totalTime;
  final List<int> temperatureIntervals;

  RatingDialog({
    required this.totalTime,
    required this.temperatureIntervals,
  });

  @override
  _RatingDialogState createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  int rating = 0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Rate the session'),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (int i = 1; i <= 5; i++)
            IconButton(
              icon: Icon(
                i <= rating ? Icons.star : Icons.star_border,
                color: Color.fromARGB(255, 255, 0, 0),
              ),
              onPressed: () {
                setState(() {
                  rating = i;
                });
              },
            ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(
              context,
              Session(
                time: widget.totalTime,
                temperatureIntervals: widget.temperatureIntervals,
                rate: rating,
              ),
            );
          },
          child: Text('Save session'),
        ),
      ],
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

class SettingsScreen extends StatefulWidget {
  @override
  _MyHomePageState1 createState() => _MyHomePageState1();
}

class _MyHomePageState1 extends State<SettingsScreen> {
  final _formKey = GlobalKey<FormState>();
  late Duration totalTime;
  final List<int> temperatureIntervals = List.filled(5, 0);
  bool flag = false;

  void change() {
    setState(() {
      flag = !flag;
    });
  }

  @override
  void initState() {
    super.initState();
    totalTime = Duration(minutes: 30);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('SETTINGS'),
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Enter the duration (in minutes)',
                  ),
                  initialValue: (totalTime.inMinutes).toString(),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    try {
                      totalTime = Duration(minutes: int.parse(value));
                    } on FormatException catch (e) {
                    }
                  },
                ),
                SizedBox(height: 16.0),
                Expanded(
                  child: ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Enter the temperature for phase №: ${index + 1}',
                        ),
                        initialValue: temperatureIntervals[index].toString(),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          try {
                            temperatureIntervals[index] = int.parse(value);
                          } on FormatException catch (e) {
                          }
                        },
                      );
                    },
                  ),
                ),
                SizedBox(height: 16.0),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        change();
                      },
                      child: Text(flag ? 'The session will last ${totalTime.inSeconds} seconds, and each phase will last ${totalTime.inSeconds ~/ 5} seconds.\nThe temperature for each phase: 1) ${temperatureIntervals[0]}℃, 2) ${temperatureIntervals[1]}℃, 3) ${temperatureIntervals[2]}℃, 4) ${temperatureIntervals[3]}℃, 5) ${temperatureIntervals[4]}℃' : 'Overview'),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ActiveSessionScreen(
                            time: totalTime,
                            temperatureIntervals: temperatureIntervals,
                          ),
                        ),
                      ).then((result) {
                        if (result != null && result is Session) {
                          Navigator.pop(context, result);
                        }
                      });
                    }
                  },
                  child: Text('Begin session'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FinalScreen extends StatelessWidget {
  final Session session;
  FinalScreen({required this.session});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('SUMMARY')),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'You have successfully completed the session.',
                style: TextStyle(fontSize: 24),
                // textAlign: TextAlign.center
              ),
              SizedBox(height: 16),
              Text(
                'You spent ${session.time} seconds.',
                style: TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 16),
              Text('Temperature intervals: ${session.temperatureIntervals}'),
              const SizedBox(height: 16),
              Text('Session rate: ${session.rate}'),
              const SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Go back to the session history'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Session {
  final Duration time;
  final List<int> temperatureIntervals;
  final int rate;

  Session({
    required this.time,
    required this.temperatureIntervals,
    required this.rate,
  });

  Map<String, dynamic> toJson() => {
    'time': time.inSeconds,
    'temperatureIntervals': temperatureIntervals,
    'rate': rate,
  };

  factory Session.fromJson(Map<String, dynamic> json) => Session(
    time: Duration(seconds: json['time']),
    temperatureIntervals: List<int>.from(json['temperatureIntervals']),
    rate: json['rate'],
  );
}
