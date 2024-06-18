import 'package:flutter/material.dart';
import 'package:education/templates/middleAssignment/SessionScreen.dart';

class SessionPreferencesScreen extends StatefulWidget {
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
        title: Text('Session Preferences'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _sessionDurationController,
                decoration: InputDecoration(labelText: 'Session Duration (seconds)'),
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
                decoration: InputDecoration(labelText: 'Hot Water Duration (seconds)'),
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
                decoration: InputDecoration(labelText: 'Cold Water Duration (seconds)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a duration';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    startWithHotWater = true;
                    // Convert the durations to integers
                    int sessionDuration = int.parse(_sessionDurationController.text);
                    int hotWaterDuration = int.parse(_hotWaterDurationController.text);
                    int coldWaterDuration = int.parse(_coldWaterDurationController.text);

                    // Navigate to the session screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SessionScreen(sessionDuration: sessionDuration, hotWaterDuration: hotWaterDuration, coldWaterDuration: coldWaterDuration, startWithHotWater: startWithHotWater)),
                    );
                  }
                },
                child: Text('Start with Hot Water'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    startWithHotWater = false;
                    // Convert the durations to integers
                    int sessionDuration = int.parse(_sessionDurationController.text);
                    int hotWaterDuration = int.parse(_hotWaterDurationController.text);
                    int coldWaterDuration = int.parse(_coldWaterDurationController.text);

                    // Navigate to the session screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SessionScreen(sessionDuration: sessionDuration, hotWaterDuration: hotWaterDuration, coldWaterDuration: coldWaterDuration, startWithHotWater: startWithHotWater)),
                    );
                  }
                },
                child: Text('Start with cold Water'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}