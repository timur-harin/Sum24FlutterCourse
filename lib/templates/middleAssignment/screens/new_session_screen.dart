import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/models.dart';
import '../session_notifier.dart';

class NewSessionScreen extends StatefulWidget {
  @override
  _NewSessionScreenState createState() => _NewSessionScreenState();
}

class _NewSessionScreenState extends State<NewSessionScreen> {
  final List<TemperaturePhase> _phases = [];
  final _formKey = GlobalKey<FormState>();
  final _phaseController = TextEditingController();
  final _durationController = TextEditingController();

  @override
  void dispose() {
    _phaseController.dispose();
    _durationController.dispose();
    super.dispose();
  }

  void _addPhase() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _phases.add(TemperaturePhase(
          _phaseController.text,
          int.parse(_durationController.text),
        ));
        _phaseController.clear();
        _durationController.clear();
      });
    }
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
              TextFormField(
                controller: _phaseController,
                decoration: InputDecoration(labelText: 'Phase (Hot/Cold)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a phase';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _durationController,
                decoration: InputDecoration(labelText: 'Duration (seconds)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a duration';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: _addPhase,
                child: Text('Add Phase'),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _phases.length,
                  itemBuilder: (context, index) {
                    final phase = _phases[index];
                    return ListTile(
                      title: Text('${phase.phase} - ${phase.duration} seconds'),
                    );
                  },
                ),
              ),
              Consumer(
                builder: (context, ref, child) {
                  return ElevatedButton(
                    onPressed: () {
                      final newSession = ShowerSession(
                        DateTime.now(),
                        _phases,
                        _phases.fold(0, (sum, phase) => sum + phase.duration),
                      );
                      ref.read(sessionHistoryProvider.notifier).addSession(newSession);
                      Navigator.pushReplacementNamed(context, '/active-session', arguments: newSession);
                    },
                    child: Text('Begin Session'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
