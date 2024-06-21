import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'shower_history.dart';
import 'new_session_screen.dart';

class NewSessionSettingsScreen extends StatefulWidget {
  const NewSessionSettingsScreen({super.key});

  @override
  _NewSessionSettingsScreenState createState() => _NewSessionSettingsScreenState();
}


class _NewSessionSettingsScreenState extends State<NewSessionSettingsScreen> {
  final showerHistoryProvider = StateNotifierProvider<ShowerHistory, List<ShowerSession>>((ref) => ShowerHistory());
  final _formKey = GlobalKey<FormState>();
  List<bool> _isHotList = [false];
  String _showerName = '';
  List<int> _durations = [0];
  ShowerSession currentSession = ShowerSession(duration: Duration.zero, temperatureInterval: Duration.zero, totalDuration: Duration.zero);

  void addNewCycleField() {
    setState(() {
      _durations.add(0);
      _isHotList.add(_durations.length % 2 == 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Session Settings'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Shower Name',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a shower name';
                }
                return null;
              },
              onSaved: (value) {
                _showerName = value!;
              },
            ),
            ..._durations.asMap().entries.map((entry) => Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Cycle Duration',
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a duration';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _durations[entry.key] = int.parse(value!);
                    },
                  ),
                ),
                Text(_isHotList[entry.key] ? 'Hot' : 'Cold'),
                Switch(
                  value: _isHotList[entry.key],
                  activeColor: Colors.red, // Цвет переключателя при включении
                  inactiveThumbColor: Colors.blue,
                  onChanged: (bool value) {
                    setState(() {
                      _isHotList[entry.key] = value;
                    });
                  },
                ),
              ],
            )).toList(),
            ElevatedButton(
              onPressed: addNewCycleField,
              child: const Text('Add New Cycle'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();

                  // Calculate the total duration of all cycles
                  final totalDuration = Duration(seconds: _durations.reduce((a, b) => a + b));

                  // Create a new ShowerSession with the input data
                  final newSession = ShowerSession(
                    duration: Duration(seconds: _durations.reduce((a, b) => a + b)),
                    temperatureInterval: Duration.zero,
                    totalDuration: totalDuration, // Add this line
                  );

                  // Add the new session to the shower history
                  final container = ProviderContainer();
                  final showerHistoryNotifier = container.read(showerHistoryProvider.notifier);
                  showerHistoryNotifier.add(newSession);

                  // Navigate to the new session screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NewSessionScreen(session: newSession, duration: _durations, isHotList: _isHotList)),
                  );
                }
              },
              child: const Text('Start Session'),
            ),
          ],
        ),
      ),
    );
  }
}