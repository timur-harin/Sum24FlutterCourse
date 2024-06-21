import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ShowerTimerProvider.dart';

class SessionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final timerProvider = Provider.of<ShowerTimerProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Contrast Shower Session'),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: timerProvider.currentPhase == 'Hot'
                ? [Colors.red, Colors.redAccent]
                : [Colors.blue, Colors.blueAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Current Phase: ${timerProvider.currentPhase}',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
              Text(
                'Time Remaining: ${timerProvider.currentDuration.inSeconds}s',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  timerProvider.togglePauseResume();
                },
                child: Text(timerProvider.isPaused ? 'Resume' : 'Pause'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  timerProvider.cancelShower();
                },
                child: Text('Pause and Exit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
