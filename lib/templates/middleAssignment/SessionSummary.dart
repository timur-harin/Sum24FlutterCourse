import 'dart:convert';

import 'main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ShowerSessionEntry.dart';

class SessionSummary extends StatefulWidget {
  final int sessionDuration;
  final int nIntervals;
  final int realSessionDuration;
  final int realIntervals;
  final DateTime startTime;

  const SessionSummary(this.sessionDuration, this.nIntervals, this.startTime, this.realSessionDuration, this.realIntervals);

  @override
  _SessionSummaryState createState() => _SessionSummaryState();
}

class _SessionSummaryState extends State<SessionSummary> {
  int _rating = 3;

  Future<void> finishSession() async {
    final prefs = await SharedPreferences.getInstance();
    String? showerSessions = prefs.getString("shower_sessions");

    List<ShowerSessionEntry> sessions = List.empty(growable: true);

    if (showerSessions != null) {
      Iterable it = json.decode(showerSessions);
      sessions = List<ShowerSessionEntry>.from(
          it.map((session) => ShowerSessionEntry.fromJson(session)));
    }

    sessions.add(ShowerSessionEntry(
        widget.sessionDuration, widget.nIntervals, widget.startTime, _rating, widget.realSessionDuration, widget.realIntervals));

    prefs.setString("shower_sessions", json.encode(sessions));
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    final dateString =
        "${widget.startTime.year}.${widget.startTime.month.toString().padLeft(2, '0')}.${widget.startTime.day.toString().padLeft(2, '0')} ${widget.startTime.hour.toString().padLeft(2, '0')}:${widget.startTime.minute.toString().padLeft(2, '0')}";

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.shower, size: 200, color: colorScheme.primary),
          Text("Shower session summary",
              /* Big text */
              style: TextStyle(fontSize: 30)),
          Text("Session length: ${(widget.realSessionDuration/60).round()}/${(widget.sessionDuration/60).round()} minutes",
              /* Medium text */
              style: TextStyle(fontSize: 20)),
          Text("Number of intervals: ${widget.realIntervals}/${widget.nIntervals}",
              /* Medium text */
              style: TextStyle(fontSize: 20)),
          Text("Start time: $dateString"),
          SizedBox(height: 50),
          /* Medium text */
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton.icon(
                style: TextButton.styleFrom(
                    backgroundColor: colorScheme.primaryContainer,
                    foregroundColor: colorScheme.primary),
                onPressed: () {
                  setState(() {
                    _rating = 4;
                  });
                  finishSession();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ShowerHelperHomePage()));
                },
                label: Text("Liked it!"),
                icon: Icon(Icons.thumb_up),
              ),
              SizedBox(width: 30),
              TextButton.icon(
                style: TextButton.styleFrom(
                    backgroundColor: colorScheme.errorContainer,
                    foregroundColor: colorScheme.error),
                onPressed: () {
                  setState(() {
                    _rating = 2;
                  });
                  finishSession();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ShowerHelperHomePage()));
                },
                label: Text("Could be better"),
                icon: Icon(Icons.thumb_down),
              )
            ],
          )
        ],
      ),
    );
  }
}
