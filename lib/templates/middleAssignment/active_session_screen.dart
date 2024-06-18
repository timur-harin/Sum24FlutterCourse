import 'dart:async';
import 'package:education/templates/middleAssignment/session_summary_screen.dart';
import 'package:education/templates/middleAssignment/timer_controller.dart';
import 'package:flutter/material.dart';
import 'package:gradient_coloured_buttons/gradient_coloured_buttons.dart';
import 'main.dart';

class ActiveSessionScreen extends StatefulWidget {
  final ShowerSession session;

  const ActiveSessionScreen({
    super.key,
    required this.session,
  });

  @override
  _ActiveSessionScreenState createState() => _ActiveSessionScreenState();
}

class _ActiveSessionScreenState extends State<ActiveSessionScreen>
    with TickerProviderStateMixin {
  late TimerController _phaseTimerController;
  late TimerController _overallTimerController;
  late ValueNotifier<Color> _progressBarColor;
  late ValueNotifier<String> _currentPhaseNotifier;
  late Color _backgroundColor;

  double _opacity = 1.0;

  @override
  void initState() {
    super.initState();
    _phaseTimerController =
        TimerController(phases: widget.session.temperaturePhases);
    _currentPhaseNotifier = _phaseTimerController.currentPhaseNotifier;
    _overallTimerController = TimerController(phases: [
      TemperaturePhase(
          temperature: 'Overall', duration: widget.session.duration)
    ]);
    _progressBarColor =
        ValueNotifier(_phaseTimerController.currentPhase == 'Hot'
            ? Colors.red
            : _phaseTimerController.currentPhase == 'Cold'
                ? Colors.blue
                : Colors.green);
    _backgroundColor = _phaseTimerController.currentPhase == 'Hot'
        ? Colors.red.shade200
        : _phaseTimerController.currentPhase == 'Cold'
            ? Colors.blue.shade200
            : Colors.green.shade200;
    _phaseTimerController.addListener(() {
      if (_currentPhaseNotifier.value == 'Hot') {
        _progressBarColor.value = Colors.red.shade200;
      } else if (_currentPhaseNotifier.value == 'Cold') {
        _progressBarColor.value = Colors.blue.shade200;
      } else {
        _progressBarColor.value = Colors.green.shade200;
      }
      if (_phaseTimerController.remainingTime <= 2.5) {
        setState(() {
          _backgroundColor = Colors.white;
        });
      } else {
        setState(() {
          _backgroundColor = _progressBarColor.value;
        });
      }
    });
    Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (_phaseTimerController.currentPhase == 'End') {
        setState(() {
          _opacity = _opacity == 1.0 ? 0.0 : 1.0;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: _currentPhaseNotifier,
      builder: (context, currentPhase, child) {
        return AnimatedContainer(
          duration: const Duration(seconds: 5),
          color: _backgroundColor,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: Text('Active Session: ${widget.session.name}'),
            ),
            body: SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget.session.temperaturePhases.length,
                      itemBuilder: (context, index) {
                        return Text(
                            'Phase: ${widget.session.temperaturePhases[index].temperature}, Duration: ${widget.session.temperaturePhases[index].duration} seconds');
                      },
                    ),
                    ValueListenableBuilder<Color>(
                      valueListenable: _progressBarColor,
                      builder: (context, color, child) {
                        if (currentPhase != 'End') {
                          return Column(
                            children: [
                              AnimatedBuilder(
                                animation: _overallTimerController,
                                builder: (context, child) {
                                  Duration remaining = Duration(
                                      seconds: _overallTimerController
                                          .remainingTime);
                                  String minutes = remaining.inMinutes
                                      .remainder(60)
                                      .toString()
                                      .padLeft(2, '0');
                                  String seconds = remaining.inSeconds
                                      .remainder(60)
                                      .toString()
                                      .padLeft(2, '0');
                                  return Text(
                                    'Total time left: $minutes:$seconds',
                                    style: const TextStyle(
                                      fontSize: 30.0,
                                      color: Colors.black,
                                    ),
                                  );
                                },
                              ),
                              AnimatedBuilder(
                                animation: _phaseTimerController,
                                builder: (context, child) {
                                  Duration remaining = Duration(
                                      seconds:
                                          _phaseTimerController.remainingTime);
                                  String minutes = remaining.inMinutes
                                      .remainder(60)
                                      .toString()
                                      .padLeft(2, '0');
                                  String seconds = remaining.inSeconds
                                      .remainder(60)
                                      .toString()
                                      .padLeft(2, '0');
                                  return AnimatedOpacity(
                                    opacity: _opacity,
                                    duration: const Duration(milliseconds: 500),
                                    child: Text(
                                      '$minutes:$seconds',
                                      style: TextStyle(
                                        fontSize: 48.0,
                                        color: currentPhase == 'Hot'
                                            ? Colors.red
                                            : currentPhase == 'Cold'
                                                ? Colors.blue
                                                : Colors.green,
                                      ),
                                    ),
                                  );
                                },
                              ),
                              AnimatedBuilder(
                                animation: _phaseTimerController,
                                builder: (context, child) {
                                  return IconButton(
                                    icon: Icon(
                                      _phaseTimerController.state ==
                                              TimerState.paused
                                          ? Icons.play_arrow
                                          : Icons.pause,
                                      size: 48.0,
                                      color: _phaseTimerController.state ==
                                              TimerState.paused
                                          ? Colors.green
                                          : Colors.grey,
                                    ),
                                    onPressed: () {
                                      if (_phaseTimerController.state ==
                                          TimerState.paused) {
                                        _phaseTimerController.unpauseTimer();
                                        _overallTimerController.unpauseTimer();
                                      } else {
                                        _phaseTimerController.pauseTimer();
                                        _overallTimerController.pauseTimer();
                                      }
                                    },
                                  );
                                },
                              ),
                              GradientButton(
                                  text: 'End Session',
                                  onPressed: () {
                                    int timeLeft =
                                        _overallTimerController.remainingTime;
                                    // Stop the timers
                                    _phaseTimerController.dispose();
                                    _overallTimerController.dispose();

                                    // Navigate to the SessionSummaryScreen
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            SessionSummaryScreen(
                                          session: widget.session,
                                        ),
                                      ),
                                    );
                                  },
                                  gradientColors:
                                      _overallTimerController.remainingTime == 0
                                          ? [
                                              Colors.green,
                                              Colors.green.shade300
                                            ]
                                          : [Colors.red, Colors.red.shade300]),
                            ],
                          );
                        } else {
                          return Stack(
                            alignment: Alignment.center,
                            children: [
                              GradientButton(
                                  text: 'End Session',
                                  onPressed: () {
                                    int timeLeft =
                                        _overallTimerController.remainingTime;
                                    // Stop the timers
                                    _phaseTimerController.dispose();
                                    _overallTimerController.dispose();

                                    // Navigate to the SessionSummaryScreen
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            SessionSummaryScreen(
                                          session: widget.session,
                                        ),
                                      ),
                                    );
                                  },
                                  gradientColors:
                                      _overallTimerController.remainingTime == 0
                                          ? [
                                              Colors.green,
                                              Colors.green.shade300
                                            ]
                                          : [Colors.red, Colors.red.shade300]),
                            ],
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _phaseTimerController.dispose();
    _overallTimerController.dispose();
    _progressBarColor.dispose();
    super.dispose();
  }
}
