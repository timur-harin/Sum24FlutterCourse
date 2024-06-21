import 'package:flutter/material.dart';
import 'ShowerSessionForHistory.dart';
import 'main.dart';

class SessionSummary extends StatefulWidget {
  final ShowerSessionForHistory session;
  final List<ShowerSessionForHistory> sessions;

  SessionSummary({required this.session, required this.sessions});

  @override
  _SessionSummaryState createState() => _SessionSummaryState();
}

class _SessionSummaryState extends State<SessionSummary> {
  double _rating = 5.0; 

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
            Text('Session Duration: ${widget.session.sessionDuration} seconds'),
            Text('Hot Water Duration: ${widget.session.hotWaterDuration} seconds'),
            Text('Cold Water Duration: ${widget.session.coldWaterDuration} seconds'),
            Text('Started with Hot Water: ${widget.session.startWithHotWater ? 'Yes' : 'No'}'),
            Text('Phases Completed: ${widget.session.phasesCompleted}'),
            const SizedBox(height: 20),
            Text('Rate your experience: ${_rating.toStringAsFixed(1)}'),
            Slider(
              value: _rating,
              min: 1,
              max: 10,
              divisions: 9,
              onChanged: (newRating) {
                setState(() {
                  _rating = newRating;
                });
              },
            ),
            ElevatedButton(
              onPressed: () {
                widget.session.rating = _rating;

                widget.sessions.add(widget.session);

                Navigator.popUntil(context, (route) => route.isFirst);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(sessions: widget.sessions),
                  ),
                );
              },
              child: Text('Back to home page', style: TextStyle(color: Colors.amber)),
            ),
          ],
        ),
      ),
    );
  }
}
