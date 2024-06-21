import 'package:flutter/material.dart';
import 'ShowerSessionForHistory.dart';
import 'main.dart';

class SessionSummary extends StatelessWidget {
  final ShowerSessionForHistory session;
  final List<ShowerSessionForHistory> sessions;

  SessionSummary({required this.session, required this.sessions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Session Summary'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Session Duration: ${session.sessionDuration} minutes'),
            Text('Hot Water Duration: ${session.hotWaterDuration} minutes'),
            Text('Cold Water Duration: ${session.coldWaterDuration} minutes'),
            Text('Started with Hot Water: ${session.startWithHotWater ? 'Yes' : 'No'}'),
            Text('Phases Completed: ${session.phasesCompleted}'),
            ElevatedButton(
              onPressed: () {
                sessions.add(session);
                Navigator.popUntil(context, (route) => route.isFirst);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(sessions: sessions),
                  ),
                );
              },
              child: Text('Back to home page',  
              style: TextStyle(color: Colors.amber),),
            ),
          ],
        ),
      ),
    );
  }
}