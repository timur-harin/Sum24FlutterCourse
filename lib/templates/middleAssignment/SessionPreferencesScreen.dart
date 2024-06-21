import 'package:flutter/material.dart';
import 'SessionScreen.dart';
import 'ShowerSessionForHistory.dart';

class SessionPreferencesScreen extends StatefulWidget {
  final List<ShowerSessionForHistory> sessions;

  const SessionPreferencesScreen({required this.sessions});

  @override
  _SessionPreferencesScreenState createState() => _SessionPreferencesScreenState();
}

class _SessionPreferencesScreenState extends State<SessionPreferencesScreen> {
  final _formKey = GlobalKey<FormState>();
  final _sessionDurationController = TextEditingController();
  final _hotWaterDurationController = TextEditingController();
  final _coldWaterDurationController = TextEditingController();
  bool startWithHotWater = true;

  @override
  void dispose() {
    _sessionDurationController.dispose();
    _hotWaterDurationController.dispose();
    _coldWaterDurationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Session Preferences'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _sessionDurationController,
                decoration: const InputDecoration(labelText: 'Session Duration (seconds)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a duration';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _hotWaterDurationController,
                decoration: const InputDecoration(labelText: 'Hot Water Duration (seconds)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a duration';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _coldWaterDurationController,
                decoration: const InputDecoration(labelText: 'Cold Water Duration (seconds)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a duration';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    startWithHotWater = true;

                    int sessionDuration = int.parse(_sessionDurationController.text);
                    int hotWaterDuration = int.parse(_hotWaterDurationController.text);
                    int coldWaterDuration = int.parse(_coldWaterDurationController.text);

                    UserPreferences preferences = UserPreferences(
                      sessionDuration: sessionDuration,
                      hotWaterDuration: hotWaterDuration,
                      coldWaterDuration: coldWaterDuration,
                      startWithHotWater: startWithHotWater,
                    );

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SessionScreen(
                          preferences: preferences,
                          sessions: widget.sessions,
                        ),
                      ),
                    );
                  }
                },
                child: const Text(
                  'Start with Hot Water',
                  style: TextStyle(color: Colors.amber),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    startWithHotWater = false;

                    int sessionDuration = int.parse(_sessionDurationController.text);
                    int hotWaterDuration = int.parse(_hotWaterDurationController.text);
                    int coldWaterDuration = int.parse(_coldWaterDurationController.text);

                    UserPreferences preferences = UserPreferences(
                      sessionDuration: sessionDuration,
                      hotWaterDuration: hotWaterDuration,
                      coldWaterDuration: coldWaterDuration,
                      startWithHotWater: startWithHotWater,
                    );

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SessionScreen(
                          preferences: preferences,
                          sessions: widget.sessions,
                        ),
                      ),
                    );
                  }
                },
                child: const Text(
                  'Start with Cold Water',
                  style: TextStyle(color: Colors.amber),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
