import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'settings_state_provider.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  final _textDurationController = TextEditingController();
  final _textPhaseController = TextEditingController();

  late String duration_of_phase;
  late String number_of_phases;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _textPhaseController,
              decoration: const InputDecoration(
                hintText: 'Input number of phases',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: _textDurationController,
              decoration: const InputDecoration(
                hintText: 'Input duration of one phase (in seconds)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            MaterialButton(
              onPressed: () {
                duration_of_phase = _textDurationController.text;
                number_of_phases = _textPhaseController.text;
                ref.read(settingsStateProvider).first =
                    int.parse(duration_of_phase);
                ref.read(settingsStateProvider).second =
                    int.parse(number_of_phases);
                Navigator.pushNamed(
                  context,
                  '/shower',
                );
              },
              color: Colors.blue,
              child: const Text('Start', style: TextStyle(color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }
}
