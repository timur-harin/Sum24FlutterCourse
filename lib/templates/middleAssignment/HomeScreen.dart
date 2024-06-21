import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ShowerSessionProvider.dart';
import 'ShowerTimerProvider.dart';
import 'SessionScreen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contrast Shower Companion'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<ShowerTimerProvider>(
              builder: (context, timerProvider, _) => Column(
                children: [
                  Text(
                    'What water to start the session with?',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          timerProvider.setStartPhase('Hot');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: timerProvider.startPhase == 'Hot'
                              ? Colors.red
                              : Colors.grey,
                        ),
                        child: Text(
                          'Hot',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          timerProvider.setStartPhase('Cold');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: timerProvider.startPhase == 'Cold'
                              ? Colors.blue
                              : Colors.grey,
                        ),
                        child: Text(
                          'Cold',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Number of Repetitions',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      timerProvider.setRepetitions(int.tryParse(value) ?? 1);
                    },
                  ),
                  SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Duration per Phase (seconds)',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      timerProvider.setDuration(int.tryParse(value) ?? 10);
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      timerProvider.startShower();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SessionScreen()),
                      );
                    },
                    child: Text('Start Shower'),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/history');
                    },
                    child: Text('Session History'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Consumer<ShowerSessionProvider>(
              builder: (context, sessionProvider, _) {
                final lastSession = sessionProvider.lastSession;
                if (lastSession != null) {
                  return Column(
                    children: [
                      Divider(),
                      Text('Last Session:'),
                      ListTile(
                        title: Text('Start Phase: ${lastSession.startPhase}'),
                        subtitle: Text(
                            'Repetitions: ${lastSession.completedRepetitions}/${lastSession.repetitions}, Total Duration: ${lastSession.totalDuration}s\n${lastSession.timestamp}'),
                      ),
                    ],
                  );
                } else {
                  return SizedBox.shrink();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
