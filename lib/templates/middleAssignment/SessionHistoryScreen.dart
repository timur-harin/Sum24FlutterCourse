import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ShowerSessionProvider.dart';

class SessionHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final sessionProvider = Provider.of<ShowerSessionProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Session History'),
      ),
      body: ListView.builder(
        itemCount: sessionProvider.sessions.length,
        itemBuilder: (context, index) {
          final session = sessionProvider.sessions[index];
          return ListTile(
            title: Text('Start Phase: ${session.startPhase}'),
            subtitle: Text(
                'Repetitions: ${session.completedRepetitions}/${session.repetitions}, Total Duration: ${session.totalDuration}s\n${session.timestamp}'),
          );
        },
      ),
    );
  }
}
