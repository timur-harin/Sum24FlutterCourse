import 'timer_screen.dart';
import 'package:flutter/material.dart';

class ResultsPage extends StatelessWidget {
  final TimerPageState timerPageState;
  int secondsLeft;
  ResultsPage({required this.timerPageState, required this.secondsLeft});

  @override
  Widget build(BuildContext context) {
    return Container ( 
    decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color.fromARGB(209, 68, 137, 255),
            Color.fromARGB(106, 155, 39, 176),
            Color.fromARGB(213, 255, 82, 82),
          ],
        ),
      ),
    child: Scaffold(
      backgroundColor: const Color.fromARGB(0, 244, 67, 54),
      appBar: AppBar(
        title: const Text('Results of session'),
        backgroundColor: const Color.fromARGB(255, 62, 160, 185)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Center(child: Text('Results:', style: TextStyle(fontSize: 20),),),
            const SizedBox(height: 20),
            Text('You were in the shower for: ${secondsLeft ~/ 60} minutes and ${secondsLeft % 60} seconds'),
            const SizedBox(height: 20),
            Text('Minimum Temperature: ${timerPageState.preferencesState.minTemp}'),
            const SizedBox(height: 20),
            Text('Maximum Temperature: ${timerPageState.preferencesState.maxTemp}'),
            const SizedBox(height: 20),
          ],
        ),
      ),
    ),
    );
  }
}