import 'timer_page.dart';
import 'home_page.dart';
import 'package:flutter/material.dart';
import 'local_storage.dart';

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
            Text('You were in the shower for: ${secondsLeft ~/ 60} minutes and ${secondsLeft % 60} seconds',
             style: const TextStyle(fontSize: 15),),
            const SizedBox(height: 20),
            Text('Minimum Temperature: ${timerPageState.preferencesState.minTemp}',
             style: const TextStyle(fontSize: 15),),
            const SizedBox(height: 20),
            Text('Maximum Temperature: ${timerPageState.preferencesState.maxTemp}',
             style: const TextStyle(fontSize: 15),),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final localStorageService = LocalStorageService();
                localStorageService.saveShowerSession('${(secondsLeft ~/ 60)}:${secondsLeft % 60}',
                '${timerPageState.preferencesState.minTemp}', '${timerPageState.preferencesState.maxTemp}');
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ContrastShowerScreenHome()),
                );
              },
              child: const Text('Go to home page'),
            ),
          ],
        ),
      ),
    ),
    );
  }
}