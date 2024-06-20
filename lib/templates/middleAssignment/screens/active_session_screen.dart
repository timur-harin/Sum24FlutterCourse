import 'dart:async';
import 'package:education/templates/middleAssignment/small_widgets/gradient_button.dart';
import 'package:flutter/material.dart';
import '../small_widgets/gradient_appbar.dart';

class HomeActiveSessionScreen extends StatelessWidget {
  const HomeActiveSessionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)?.settings.arguments as Map;

    // Now you can use these arguments
    final totalDuration = arguments['totalDuration'];
    final hotPhaseDurations = arguments['hotPhaseDurations'];
    final coldPhaseDurations = arguments['coldPhaseDurations'];
    return Scaffold(
      body: ActiveSessionScreen(
        totalDuration: totalDuration,
        hotPhaseDurations: hotPhaseDurations,
        coldPhaseDurations: coldPhaseDurations,
      ),
    );
  }
}

class ActiveSessionScreen extends StatefulWidget {
  final int totalDuration;
  final List<int> hotPhaseDurations;
  final List<int> coldPhaseDurations;

  ActiveSessionScreen(
      {super.key,
      required this.totalDuration,
      required this.hotPhaseDurations,
      required this.coldPhaseDurations});

  @override
  _ActiveSessionScreenState createState() => _ActiveSessionScreenState();
}

class _ActiveSessionScreenState extends State<ActiveSessionScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Timer _timer;
  late Duration _duration;

  int _hotPhaseIndex = 0;
  int _coldPhaseIndex = 0;
  int _hotPhasesCompleted = 0;
  int _coldPhasesCompleted = 0;
  bool _isHotPhase = true;

  bool _isPaused = false;
  bool _isFinished = false;

  int _timeSpent = 0;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat(reverse: true);

    _duration = Duration(
        minutes: widget.hotPhaseDurations[_hotPhaseIndex] ~/ 60,
        seconds: widget.hotPhaseDurations[_hotPhaseIndex] % 60);
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_duration.inSeconds == 0) {
          if (_isHotPhase) {
            _hotPhasesCompleted++;
            if (_coldPhaseIndex < widget.coldPhaseDurations.length) {
              setState(() {
                timer.cancel();
              });
              _duration = Duration(
                minutes: widget.coldPhaseDurations[_coldPhaseIndex] ~/ 60,
                seconds: widget.coldPhaseDurations[_coldPhaseIndex] % 60,
              );
              _coldPhaseIndex++;
              startTimer();
            } else {
              _isFinished = true;
            }
          } else {
            _coldPhasesCompleted++;
            if (_hotPhaseIndex + 1 < widget.hotPhaseDurations.length) {
              setState(() {
                timer.cancel();
              });
              _hotPhaseIndex++;
              _duration = Duration(
                minutes: widget.hotPhaseDurations[_hotPhaseIndex] ~/ 60,
                seconds: widget.hotPhaseDurations[_hotPhaseIndex] % 60,
              );
              startTimer();
            } else {
              _isFinished = true;
            }
          }
          if (_isFinished) {
            timer.cancel();
          } else {
            _isHotPhase = !_isHotPhase;
          }
        } else {
          _duration = _duration - const Duration(seconds: 1);
          _timeSpent++;
        }
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GradientAppBar(
        title: 'Active Session',
      ),
      body: AnimatedContainer(
        duration: const Duration(seconds: 1),
        color: _isHotPhase ? Colors.red[200] : Colors.cyan[200],
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Visibility(
                visible: _isFinished,
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 130, 214, 135),
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const Column(
                    children: <Widget>[
                      Text('Session is completed!',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          )),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.all(32.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    Text(
                      'Hot Phases Completed: $_hotPhasesCompleted out of ${widget.hotPhaseDurations.length}',
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      'Cold Phases Completed: $_coldPhasesCompleted out of ${widget.coldPhaseDurations.length}',
                      style: const TextStyle(
                        color: Colors.cyan,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(32.0),
                      decoration: BoxDecoration(
                        color: _isHotPhase ? Colors.red[400] : Colors.cyan[400],
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        children: <Widget>[
                          AnimatedBuilder(
                            animation: _controller,
                            builder: (BuildContext context, Widget? child) {
                              return Text(
                                '${_duration.inMinutes}:${(_duration.inSeconds % 60).toString().padLeft(2, '0')}',
                                style: const TextStyle(
                                  fontSize: 60,
                                  color: Colors.white,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Visibility(
                    visible: !_isFinished,
                    child: GradientButton(
                      buttonText: _isPaused ? 'Continue' : 'Pause',
                      onPressed: () {
                        if (_isPaused) {
                          if (!_isFinished) {
                            _controller.repeat();
                            startTimer();
                          }
                        } else {
                          _controller.stop();
                          _timer.cancel();
                        }
                        setState(() {
                          _isPaused = !_isPaused;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  GradientButton(
                    buttonText: 'End Session',
                    onPressed: () {
                      _controller.stop();
                      _timer.cancel();

                      Navigator.of(context).pushReplacementNamed(
                        '/postSession',
                        arguments: {
                          'totalDuration': _timeSpent,
                          'hotPhasesCompleted': _hotPhasesCompleted,
                          'coldPhasesCompleted': _coldPhasesCompleted,
                        },
                      );
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
