import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ShowerSessionForHistory.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<ShowerSessionForHistory> sessions = [];

  @override
  void initState() {
    super.initState();
    _loadSessions();
  }

  void _loadSessions() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String>? sessionsJson = prefs.getStringList('sessions');

      if (sessionsJson != null) {
        setState(() {
          sessions = sessionsJson.map((jsonString) => ShowerSessionForHistory.fromJson(jsonDecode(jsonString))).toList();
        });
      }
    } catch (e) {
      print('Error loading sessions: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History of Sessions'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: sessions.isEmpty
            ? Center(
          child: Text('No sessions recorded yet.'),
        )
            : ListView.builder(
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
                    Text('Rating: ${session.rating.toStringAsFixed(1)}'), // Display rating
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
