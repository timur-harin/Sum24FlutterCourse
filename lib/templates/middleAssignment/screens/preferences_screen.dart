import '../small_widgets/gradient_appbar.dart';

import '../screens/session_overview_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../notifiers/phases_notifier.dart';
import '../small_widgets/gradient_button.dart';

class PreferencesScreen extends ConsumerWidget {
  const PreferencesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final phases = ref.watch(phasesProvider);

    return Scaffold(
      appBar: const GradientAppBar(
        title: 'Contrast Shower Companion',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Total Duration: ${ref.read(phasesProvider.notifier).getTotalDuration()} minutes',
              style: const TextStyle(color: Colors.black),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: phases.length,
              itemBuilder: (context, index) {
                final phase = phases[index];
                return TextField(
                  controller: phase.controller,
                  decoration: InputDecoration(
                    labelText:
                        '${phase.type[0].toUpperCase()}${phase.type.substring(1)} Phase ${index + 1} Duration (minutes)',
                    labelStyle: TextStyle(
                        color: phase.type == 'hot' ? Colors.red : Colors.cyan),
                  ),
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                      color: phase.type == 'hot' ? Colors.red : Colors.cyan),
                  onChanged: (value) {
                    ref
                        .read(phasesProvider.notifier)
                        .updatePhaseDuration(index, value);
                  },
                );
              },
            ),
            const SizedBox(height: 16),
            GradientButton(
              buttonText: 'Add Phase',
              onPressed: () {
                ref.read(phasesProvider.notifier).addPhase();
              },
            ),
            const SizedBox(height: 16),
            GradientButton(
              buttonText: 'Start Session',
              onPressed: () {
                List<Phase> phases = ref.read(phasesProvider);

                if (phases.any((phase) => phase.duration == 0)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                          'Please fill in all phase durations. Duration must be greater than 0.'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                  return;
                }

                List<int> hotPhaseDurations = phases
                    .where((phase) => phase.type == 'hot')
                    .map((phase) => phase.duration)
                    .toList();
                List<int> coldPhaseDurations = phases
                    .where((phase) => phase.type == 'cold')
                    .map((phase) => phase.duration)
                    .toList();

                int totalDuration =
                    ref.read(phasesProvider.notifier).getTotalDuration();
                ref.read(phasesProvider.notifier).reset();

                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => SessionOverviewScreen(
                        totalDuration: totalDuration,
                        hotPhaseDurations: hotPhaseDurations,
                        coldPhaseDurations: coldPhaseDurations),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
