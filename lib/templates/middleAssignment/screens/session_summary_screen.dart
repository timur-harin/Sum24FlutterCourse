import 'package:flutter/material.dart';

class SessionSummaryScreen extends StatelessWidget {
  final int totalTime;
  final int numberOfPhases;

  const SessionSummaryScreen({required this.totalTime, required this.numberOfPhases});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Session Summary'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text('Total Time: $totalTime minutes'),
            Text('Number of Phases: $numberOfPhases'),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Back to Home'),
            ),
          ],
        ),
      ),
    );
  }
}

