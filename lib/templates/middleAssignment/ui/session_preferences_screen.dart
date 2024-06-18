import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/models/shower_session.dart';
import '../data/models/temperature_phase.dart';
import '../data/providers/session_provider.dart';
import 'active_session_screen.dart';


class SessionPreferencesScreen extends StatefulWidget {
  @override
  _SessionPreferencesScreenState createState() => _SessionPreferencesScreenState();
}

class _SessionPreferencesScreenState extends State<SessionPreferencesScreen> {
  final _formKey = GlobalKey<FormState>();
  int _duration = 10;
  int _interval = 5;
  int _hotTemperature = 40;
  int _coldTemperature = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Session Preferences'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Duration (minutes)'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a duration';
                }
                return null;
              },
              onSaved: (value) => _duration = int.parse(value!),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Interval (seconds)'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter an interval';
                }
                return null;
              },
              onSaved: (value) => _interval = int.parse(value!),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Hot Temperature (°C)'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a hot temperature';
                }
                return null;
              },
              onSaved: (value) => _hotTemperature = int.parse(value!),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Cold Temperature (°C)'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a cold temperature';
                }
                return null;
              },
              onSaved: (value) => _coldTemperature = int.parse(value!),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState?.save();
                  final session = ShowerSession(
                    id: 2,
                    interval: _interval,
                    duration: _duration,
                    phases: [
                      TemperaturePhase(id: 1, temperature: _hotTemperature, duration: _duration ~/ 2),
                      TemperaturePhase(id: 1, temperature: _coldTemperature, duration: _duration ~/ 2),
                    ], startTime: DateTime.now(),
                  );
                  context.read<SessionProvider>().startNewSession(session);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ActiveSessionScreen()),
                  );
                }
              },
              child: Text('Begin Session'),
            ),
          ],
        ),
      ),
    );
  }
}

