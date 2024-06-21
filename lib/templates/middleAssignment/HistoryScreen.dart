import 'package:flutter/material.dart';
import 'ShowerSessionForHistory.dart';

class ShowerSession {
  final int sessionDuration;
  final int hotWaterDuration;
  final int coldWaterDuration;
  final bool startWithHotWater;
  final int phasesCompleted;

  ShowerSession({
    required this.sessionDuration,
    required this.hotWaterDuration,
    required this.coldWaterDuration,
    required this.startWithHotWater,
    required this.phasesCompleted,
  });
}

class HistoryScreen extends StatelessWidget {
  final List<ShowerSessionForHistory> sessions;

  HistoryScreen({required this.sessions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History of Sessions'),
      ),
      
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: sessions.length,
          itemBuilder: (context, index) {
            final session = sessions[index];
            return Card(
              margin: EdgeInsets.symmetric(vertical: 8.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Session Duration: ${session.sessionDuration} seconds'),
                    Text('Hot Water Duration: ${session.hotWaterDuration} seconds'),
                    Text('Cold Water Duration: ${session.coldWaterDuration} seconds'),
                    Text(session.startWithHotWater ? 'Started with Hot Water' : 'Started with Cold Water'),
                    Text('Phases Completed: ${session.phasesCompleted}'),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}