import 'package:flutter/material.dart';
import 'SessionScreen.dart';

class Session {
  final int sessionDuration;
  final int hotWaterDuration;
  final int coldWaterDuration;
  final bool startWithHotWater;

  Session({
    required this.sessionDuration,
    required this.hotWaterDuration,
    required this.coldWaterDuration,
    required this.startWithHotWater,
  });
}

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class SessionHistory extends ChangeNotifier {
  List<SessionScreen> _sessions = [];

  List<SessionScreen> get sessions => _sessions;

  void addSession(SessionScreen session) {
    _sessions.add(session);
    notifyListeners();
  }
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<Session> _sessionHistory = [];
  
  void addSession(Session session) {
  setState(() {
    _sessionHistory.add(session);
  });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Session History'),
      ),
      body: ListView.builder(
        itemCount: _sessionHistory.length,
        itemBuilder: (context, index) {
          Session session = _sessionHistory.reversed.toList()[index];
          return ListTile(
            title: Text('Session ${index + 1}'),
            subtitle: Text('Session Duration: ${session.sessionDuration}\n'
                          'Hot Water Duration: ${session.hotWaterDuration}\n'
                          'Cold Water Duration: ${session.coldWaterDuration}\n'
                          'Start with Hot Water: ${session.startWithHotWater ? 'Yes' : 'No'}'),
          );
        },
      ),
    );
  }
}