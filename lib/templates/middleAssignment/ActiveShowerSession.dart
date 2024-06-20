import 'dart:async';
import 'dart:convert';

import 'SessionSummary.dart';
import 'ShowerSessionEntry.dart';
import 'main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'IntervalCircle.dart';
import 'IntervalTimer.dart';

class _ActiveShowerSession extends State<ActiveShowerSession> {
  Timer? timer;
  int? _currentSecond;
  int? _currentIntervalSecond;
  int? _intervalTimeLeft;
  double? _intervalLength;
  bool? _isCold;
  DateTime? _startTime;

  @override
  void initState() {
    super.initState();
    _intervalLength = widget.sessionLength / widget.nIntervals;
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) => tick());
    _isCold = true;
    _currentSecond = 0;
    _currentIntervalSecond = 0;
    _intervalTimeLeft = _intervalLength!.round();
    _startTime = DateTime.now();
    // Stop the session after session length seconds via calling the finishSession
    Future.delayed(Duration(seconds: widget.sessionLength.round()), () => finishSession());
  }

  void tick() {
    setState(() {
      _currentSecond = _currentSecond! + 1;
      if (_currentIntervalSecond == _intervalLength!.round() - 1) {
        SystemSound.play(SystemSoundType.alert);
        _isCold = !_isCold!;
      }
      _currentIntervalSecond = _currentSecond! % _intervalLength!.round();
      _intervalTimeLeft = _intervalLength!.round() - _currentIntervalSecond!;
    });
  }

  Future<void> finishSession() async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SessionSummary(
                widget.sessionLength.round(), widget.nIntervals, _startTime!, _currentSecond!, (_currentSecond! / _intervalLength!).round())));
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    final coldColor = Color.fromARGB(255, 00, 105, 137);
    final warmColor = Color.fromARGB(255, 232, 141, 103);

    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          onPressed: () {
            finishSession();
          },
          icon: Icon(Icons.flag),
          label: Text("Finish session"),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Container(
            decoration: BoxDecoration(
                color: _isCold!
                    ? coldColor.withAlpha(32)
                    : warmColor.withAlpha(32)),
            child: Padding(
              padding: EdgeInsets.only(top: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                      child: Text.rich(
                          TextSpan(children: [
                            TextSpan(children: [
                              WidgetSpan(
                                  child: Icon(
                                Icons.timer,
                                size: 34,
                              ))
                            ]),
                            TextSpan(
                                text: " " +
                                    (widget.sessionLength / 60)
                                        .round()
                                        .toString() +
                                    " minute" +
                                    ((widget.sessionLength / 60).round() <= 1
                                        ? ""
                                        : "s")),
                          ]),
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 30))),
                  Center(
                      child: Text(_intervalLength!.toString() +
                          " seconds for interval")),
                  Center(
                      child: Text(
                          (widget.sessionLength.round() - _currentSecond!)
                                  .toString() +
                              " seconds left",
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  Padding(
                    padding: EdgeInsets.only(top: 100, bottom: 100),
                    child: IntervalTimer(
                        widget.nIntervals,
                        widget.sessionLength,
                        _currentSecond! / widget.sessionLength,
                        _isCold!),
                  ),
                  Center(
                      child: Text(
                          (_isCold! ? "Cold" : "Warm") +
                              " shower for $_intervalTimeLeft secs",
                          style: TextStyle(
                              fontSize: 30,
                              color: _isCold! ? coldColor : warmColor))),
                ],
              ),
            )));
  }
}

class ActiveShowerSession extends StatefulWidget {
  final double sessionLength;
  final int nIntervals;

  const ActiveShowerSession(
      {Key? key, required this.sessionLength, required this.nIntervals})
      : super(key: key);

  @override
  State createState() => _ActiveShowerSession();
}
