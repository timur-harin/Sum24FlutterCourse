import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'preview_session_dialog.dart';
import 'shower_session.dart';
import 'session_history_provider.dart';
import 'theme.dart';

class SessionScreen extends ConsumerStatefulWidget {
  @override
  _SessionScreenState createState() => _SessionScreenState();
}

class _SessionScreenState extends ConsumerState<SessionScreen> {
  int totalDuration = 5;
  int hotDuration = 30;
  int coldDuration = 30;
  int hotTemperature = 40;
  int coldTemperature = 15;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Set Your Session Preferences',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
        backgroundColor: AppColors.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Total Duration (minutes)',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Slider(
              value: totalDuration.toDouble(),
              min: 1,
              max: 30,
              divisions: 29,
              label: '$totalDuration minutes',
              onChanged: (double value) {
                setState(() {
                  totalDuration = value.toInt();
                });
              },
            ),
            Text(
              'Hot Interval Duration (seconds)',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Slider(
              value: hotDuration.toDouble(),
              min: 10,
              max: 60,
              divisions: 50,
              label: '$hotDuration seconds',
              onChanged: (double value) {
                setState(() {
                  hotDuration = value.toInt();
                });
              },
            ),
            Text(
              'Cold Interval Duration (seconds)',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Slider(
              value: coldDuration.toDouble(),
              min: 10,
              max: 60,
              divisions: 50,
              label: '$coldDuration seconds',
              onChanged: (double value) {
                setState(() {
                  coldDuration = value.toInt();
                });
              },
            ),
            Text(
              'Hot Water Temperature (°C)',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Slider(
              value: hotTemperature.toDouble(),
              min: 30,
              max: 50,
              divisions: 20,
              label: '$hotTemperature °C',
              onChanged: (double value) {
                setState(() {
                  hotTemperature = value.toInt();
                });
              },
            ),
            Text(
              'Cold Water Temperature (°C)',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Slider(
              value: coldTemperature.toDouble(),
              min: 10,
              max: 20,
              divisions: 10,
              label: '$coldTemperature °C',
              onChanged: (double value) {
                setState(() {
                  coldTemperature = value.toInt();
                });
              },
            ),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => PreviewSessionDialog(
                    totalDuration: totalDuration,
                    hotDuration: hotDuration,
                    coldDuration: coldDuration,
                    hotTemperature: hotTemperature,
                    coldTemperature: coldTemperature,
                  ),
                );
              },
              child: Text('Preview Session'),
            ),
            ElevatedButton(
              onPressed: () {
                final newSession = ShowerSession(
                  date: DateTime.now(),
                  totalDuration: totalDuration,
                  hotDuration: hotDuration,
                  coldDuration: coldDuration,
                  hotTemperature: hotTemperature,
                  coldTemperature: coldTemperature,
                  cycles: List.generate(
                    totalDuration * 60 ~/ (hotDuration + coldDuration),
                        (index) => ShowerCycle(
                      hotDuration: hotDuration,
                      coldDuration: coldDuration,
                    ),
                  ),
                );

                ref.read(sessionHistoryProvider.notifier).addSession(newSession);
                Navigator.pop(context);
              },
              child: Text('Start Session'),
            ),
          ],
        ),
      ),
    );
  }
}
