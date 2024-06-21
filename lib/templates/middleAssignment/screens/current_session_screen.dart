import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shower_companion/models/shower_session.dart';
import 'package:shower_companion/screens/after_session_screen.dart';

class CurrentSessionScreen extends StatefulWidget {
  final ShowerSession session;

  const CurrentSessionScreen({super.key, required this.session});

  @override
  _CurrentSessionScreenState createState() => _CurrentSessionScreenState();
}

class _CurrentSessionScreenState extends State<CurrentSessionScreen> {
  late int totalRemainingSeconds;
  late int stepRemainingSeconds;
  Timer? totalTimer;
  Timer? stepTimer;
  bool isPaused = false;

  @override
  void initState() {
    super.initState();
    totalRemainingSeconds = widget.session.totalDuration.inSeconds;
    stepRemainingSeconds = widget.session.steps.isNotEmpty
        ? widget.session.steps[0].duration.inSeconds
        : 0;
    startTotalTimer();
    if (widget.session.steps.isNotEmpty) {
      startStepTimer();
    }
  }

  void startTotalTimer() {
    totalTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!isPaused && totalRemainingSeconds > 0) {
        setState(() {
          totalRemainingSeconds--;
        });
      } else if (totalRemainingSeconds == 0) {
        timer.cancel();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AfterSessionScreen()),
        );
      }
    });
  }

  void startStepTimer() {
    stepTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!isPaused && stepRemainingSeconds > 0) {
        setState(() {
          stepRemainingSeconds--;
        });
      } else if (stepRemainingSeconds == 0) {
        timer.cancel();
        setState(() {
          if (widget.session.steps.isNotEmpty) {
            widget.session.steps.removeAt(0);
            if (widget.session.steps.isNotEmpty) {
              stepRemainingSeconds = widget.session.steps[0].duration.inSeconds;
              startStepTimer();
            }
          }
        });
      }
    });
  }

  void togglePause() {
    setState(() {
      isPaused = !isPaused;
    });
  }

  @override
  void dispose() {
    totalTimer?.cancel();
    stepTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String formatDuration(int totalSeconds) {
      final minutes = totalSeconds ~/ 60;
      final seconds = totalSeconds % 60;
      return '$minutes:${seconds.toString().padLeft(2, '0')}';
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: const Text('Current Session',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 23)),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 90,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: TextButton(
                    onPressed: togglePause,
                    child: Text(
                      isPaused ? '⏯️' : '⏸️',
                      style: const TextStyle(fontSize: 50),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      '❌',
                      style: TextStyle(fontSize: 50),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30,),
          Expanded(
            flex: 70,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Total time: ${formatDuration(totalRemainingSeconds)}',
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 30),
                  ),
                  const SizedBox(height: 20),
                  if (widget.session.steps.isNotEmpty)
                    Text(
                      'Current step time: ${formatDuration(stepRemainingSeconds)}',
                      style: const TextStyle(
                          fontWeight: FontWeight.w300, fontSize: 20),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Expanded(
            flex: 400,
            child: ListView.builder(
              itemCount: widget.session.steps.length,
              itemBuilder: (context, index) {
                final step = widget.session.steps[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: index == 0 ? 250 : 150,
                        height: index == 0 ? 150 : 60,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 3,
                              blurRadius: 7,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            if (index == 0)
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    step.isHot ? '🔥' : '🧊',
                                    style: const TextStyle(fontSize: 70),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              )
                            else ...[
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "${step.duration.inMinutes} min",
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    step.isHot ? '🔥' : '🧊',
                                    style: const TextStyle(fontSize: 30),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
