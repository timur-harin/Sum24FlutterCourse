import 'package:flutter/material.dart';
import 'SessionScreen.dart';

class SummaryScreen extends StatelessWidget {
  final SessionScreen session;

  SummaryScreen({required this.session});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Summary Screen'),
      ),
      body: Column(
        children: <Widget>[
          Text('Total Time: ${session.sessionDuration}'),
          Text('Number of Phases Completed: ${session.phasesCompleted}'), // Ensure 'phasesCompleted' is a valid property of 'SessionScreen'
          Text('Rate Your Experience:'),
          // Add your rating widget here
        ],
      ),
    );
  }
}