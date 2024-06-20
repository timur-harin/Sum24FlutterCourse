import 'dart:convert';

import 'ActiveShowerSession.dart';
import 'SessionSummary.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'NewShowerSession.dart';
import 'ShowerSessionEntry.dart';

void main() {
  runApp(const MiddleAssigmentApp());
}

class MiddleAssigmentApp extends StatelessWidget {
  const MiddleAssigmentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Middle Assigment',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: ShowerHelperHomePage(),
      // home: SessionSummary(10, 10, DateTime.now()),
    );
  }
}

class ShowerSessionCard extends StatelessWidget {
  final ShowerSessionEntry entry;

  const ShowerSessionCard({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final dateString =
        "${entry.start.year}.${entry.start.month.toString().padLeft(2, '0')}.${entry.start.day.toString().padLeft(2, '0')}\n${entry.start.hour.toString().padLeft(2, '0')}:${entry.start.minute.toString().padLeft(2, '0')}";
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.shower, color: entry.rating > 3 ? colorScheme.primary : colorScheme.error),
            title: Text("Shower session"),
            subtitle: Text((entry.realDuration / 60).round().toString() +
                " mins (from " + (entry.duration / 60).round().toString() + ") / " +
                entry.realIntevals.toString() +
                " intervals (from " + entry.intervals.toString() + ")"),
            trailing: Text(dateString, textAlign: TextAlign.center),
          )
        ],
      ),
    );
  }
}

class ShowerHelperHomePage extends StatefulWidget {
  const ShowerHelperHomePage({super.key});

  @override
  State<ShowerHelperHomePage> createState() => _ShowerHelperHomePageState();
}

class _ShowerHelperHomePageState extends State<ShowerHelperHomePage> {
  List<ShowerSessionEntry> _sessions = List.empty();

  @override
  void initState() {
    super.initState();
    _loadSessions();
  }

  Future<void> _loadSessions() async {
    final prefs = await SharedPreferences.getInstance();
    String? showerSessions = prefs.getString("shower_sessions");

    List<ShowerSessionEntry> sessions = List.empty();

    if (showerSessions != null) {
      Iterable it = json.decode(showerSessions);
      sessions = List<ShowerSessionEntry>.from(
          it.map((session) => ShowerSessionEntry.fromJson(session)));
    }

    setState(() {
      _sessions = sessions;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const NewShowerSession()));
          },
          icon: const Icon(Icons.shower),
          label: const Text("New session"),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Padding(
            padding: EdgeInsets.all(20),
            child: SingleChildScrollView(
                child: Column(
              children: [
                for (var session in _sessions.reversed) ShowerSessionCard(entry: session)
              ],
            ))));
  }
}
