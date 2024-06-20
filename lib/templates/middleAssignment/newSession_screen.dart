import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models.dart';
import 'activeSession_screen.dart';

class NewSessionScreen extends StatefulWidget {
  @override
  _NewSessionScreenState createState() => _NewSessionScreenState();
}

class _NewSessionScreenState extends State<NewSessionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _hotDurationController = TextEditingController();
  final _coldDurationController = TextEditingController();
  final _cyclesController = TextEditingController();

  @override
  void dispose() {
    _hotDurationController.dispose();
    _coldDurationController.dispose();
    _cyclesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Session'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text('Set your preferences', style: Theme.of(context).textTheme.headlineLarge),
              SizedBox(height: 16),
              TextFormField(
                controller: _hotDurationController,
                decoration: InputDecoration(
                  labelText: 'Hot Duration (seconds)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a duration';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _coldDurationController,
                decoration: InputDecoration(
                  labelText: 'Cold Duration (seconds)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a duration';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _cyclesController,
                decoration: InputDecoration(
                  labelText: 'Number of Cycles',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the number of cycles';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final hotDuration = int.parse(_hotDurationController.text);
                    final coldDuration = int.parse(_coldDurationController.text);
                    final cycles = int.parse(_cyclesController.text);

                    final phases = <TemperaturePhase>[];
                    for (int i = 0; i < cycles; i++) {
                      phases.add(TemperaturePhase(type: 'hot', duration: hotDuration));
                      phases.add(TemperaturePhase(type: 'cold', duration: coldDuration));
                    }

                    final session = ShowerSession(
                      date: DateTime.now(),
                      phases: phases,
                    );

                    final box = Hive.box<ShowerSession>('sessions');
                    box.add(session);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ActiveSessionScreen(session: session),
                      ),
                    );
                  }
                },
                child: Text('Start Session'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}