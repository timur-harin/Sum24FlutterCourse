import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/temperature_phase.dart';
import '../providers/preferences_provider.dart';
import 'active_session_screen.dart';

class SessionPreferencesScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final preferences = ref.watch(preferencesProvider);
    final preferencesNotifier = ref.watch(preferencesProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text('Session Preferences'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            DropdownButton<TemperaturePhase>(
              value: preferences.firstPhase,
              onChanged: (TemperaturePhase? newValue) {
                preferencesNotifier.updateFirstPhase(newValue!);
              },
              items: TemperaturePhase.values.map((TemperaturePhase phase) {
                return DropdownMenuItem<TemperaturePhase>(
                  value: phase,
                  child: Text(phase == TemperaturePhase.hot ? 'Hot' : 'Cold'),
                );
              }).toList(),
            ),
            Slider(
              value: preferences.durationOfPhase.toDouble(),
              min: 1,
              max: 10,
              divisions: 9,
              label: preferences.durationOfPhase.toString(),
              onChanged: (double value) {
                preferencesNotifier.updateDurationOfPhase(value.toInt());
              },
            ),
            Slider(
              value: preferences.numberOfPhases.toDouble(),
              min: 1,
              max: 10,
              divisions: 9,
              label: preferences.numberOfPhases.toString(),
              onChanged: (double value) {
                preferencesNotifier.updateNumberOfPhases(value.toInt());
              },
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ActiveSessionScreen()),
                );
              },
              child: Text('Begin Session'),
            ),
          ],
        ),
      ),
    );
  }
}

