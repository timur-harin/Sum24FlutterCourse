import 'dart:async';
import 'package:education/templates/middleAssignment/session_summary_screen.dart';
import 'theme.dart';
import 'package:education/templates/middleAssignment/timer_controller.dart';
import 'package:flutter/material.dart';
import 'package:gradient_coloured_buttons/gradient_coloured_buttons.dart';
import 'main.dart';
import 'package:neon_widgets/neon_widgets.dart';
import 'package:provider/provider.dart' as provider;
import 'app_bar.dart';

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
    _phaseTimerController.addListener(() {
      if (_currentPhaseNotifier.value == 'Hot') {
        _progressBarColor.value = Colors.red.shade200;
      } else if (_currentPhaseNotifier.value == 'Cold') {
        _progressBarColor.value = Colors.blue.shade200;
      } else {
        _progressBarColor.value = Colors.green.shade200;
      }
      if (_phaseTimerController.remainingTime <= 2) {
        setState(() {});
      } else {
        setState(() {});
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
    provider.Provider.of<ThemeProvider>(context);
    return ValueListenableBuilder<String>(
      valueListenable: _currentPhaseNotifier,
      builder: (context, currentPhase, child) {
        return AnimatedContainer(
          duration: const Duration(seconds: 2),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: currentPhase == 'Hot' &&
                      Theme.of(context).brightness == Brightness.dark
                  ? [Colors.black, Colors.red]
                  : currentPhase == 'Cold' &&
                          Theme.of(context).brightness == Brightness.dark
                      ? [Colors.black, Colors.blue]
                      : currentPhase == 'Hot' &&
                              Theme.of(context).brightness == Brightness.light
                          ? [Colors.white, Colors.red]
                          : currentPhase == 'Cold' &&
                                  Theme.of(context).brightness ==
                                      Brightness.light
                              ? [Colors.white, Colors.blue]
                              : Theme.of(context).brightness == Brightness.dark
                                  ? [Colors.black, Colors.green]
                                  : [Colors.white, Colors.green],
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar:
                CustomAppBar(title: 'Active Session: ${widget.session.name}'),
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
                                    child: NeonText(
                                      text: '$minutes:$seconds',
                                      spreadColor: currentPhase == 'Hot'
                                          ? Colors.red
                                          : currentPhase == 'Cold'
                                              ? Colors.blue
                                              : Colors.green,
                                      blurRadius: 22,
                                      textSize: 74,
                                      textColor: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.white
                                          : Colors.black,
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
                                    int timeSpent = widget.session.duration -
                                        _overallTimerController.remainingTime;
                                    _phaseTimerController.dispose();
                                    _overallTimerController.dispose();
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            SessionSummaryScreen(
                                          session: widget.session,
                                          timeSpent:
                                              timeSpent, // Pass the timeSpent here
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
                                  int timeSpent = widget.session.duration;
                                  _phaseTimerController.dispose();
                                  _overallTimerController.dispose();
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          SessionSummaryScreen(
                                        session: widget.session,
                                        timeSpent: timeSpent,
                                      ),
                                    ),
                                  );
                                },
                                gradientColors: [
                                  Colors.green,
                                  Colors.green.shade300
                                ],
                              ),
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
