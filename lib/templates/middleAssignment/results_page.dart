import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'timer_page.dart';
import 'home_page.dart';
import 'package:flutter/material.dart';
import 'notifier.dart';
import 'preferences_page.dart';

class ResultsPage extends ConsumerWidget {
  final TimerPageState timerPageState;
  final int secondsLeft;
  final int actualSwitch;
  late final String startWater = (timerPageState.preferencesState.waterType == WaterType.hot) ? 'Hot water' : 'Cold water';

  WidgetRef? ref;
  ResultsPage({required this.timerPageState, required this.secondsLeft, required this.actualSwitch ,this.ref});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            Text('You switched $actualSwitch time(-s)'),    
            const SizedBox(height: 20),    
            ElevatedButton(
              onPressed: () async {
                ref.read(sessionProvider.notifier).saving(secondsLeft, actualSwitch, startWater);
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