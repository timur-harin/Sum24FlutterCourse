import 'package:flutter/services.dart';

import '../small_widgets/gradient_appbar.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../notifiers/phases_notifier.dart';
import '../small_widgets/gradient_button.dart';

class PreferencesScreen extends ConsumerWidget {
  const PreferencesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final phases = ref.watch(phasesProvider);

    UserPreferences userPreferences = UserPreferences(
      ref: ref,
      phaseProvider: phasesProvider,
    );

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
              'Total Duration: ${userPreferences.getTotalDuration() ~/ 60} minutes ${userPreferences.getTotalDuration() % 60} seconds',
              style: const TextStyle(color: Colors.black),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: phases.length,
                itemBuilder: (context, index) {
                  final phase = phases[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: TextField(
                              controller: phase.minutesController,
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                labelText:
                                    '${phase.type[0].toUpperCase()}${phase.type.substring(1)} Phase ${index + 1} Minutes',
                                labelStyle: TextStyle(
                                    color: phase.type == 'hot'
                                        ? Colors.red
                                        : Colors.cyan),
                              ),
                              style: TextStyle(
                                  color: phase.type == 'hot'
                                      ? Colors.red
                                      : Colors.cyan),
                              onChanged: (value) {
                                userPreferences.updatePhaseDurationMinutes(
                                    index, value);
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: TextField(
                              controller: phase.secondsController,
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                labelText:
                                    '${phase.type[0].toUpperCase()}${phase.type.substring(1)} Phase ${index + 1} Seconds',
                                labelStyle: TextStyle(
                                    color: phase.type == 'hot'
                                        ? Colors.red
                                        : Colors.cyan),
                              ),
                              style: TextStyle(
                                  color: phase.type == 'hot'
                                      ? Colors.red
                                      : Colors.cyan),
                              onChanged: (value) {
                                userPreferences.updatePhaseDurationSeconds(
                                    index, value);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Visibility(
              visible: phases.length >= 9,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  height: 2.0,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Colors.transparent,
                        Colors.cyan,
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GradientButton(
                  onPressed: () {
                    userPreferences.addPhase();
                  },
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
                GradientButton(
                  onPressed: () {
                    userPreferences.removeLastPhase();
                  },
                  icon: const Icon(
                    Icons.remove,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            GradientButton(
              buttonText: 'Start Session',
              onPressed: () {
                List<TemperaturePhase> phases = ref.read(phasesProvider);

                if (phases
                    .any((phase) => phase.minutes == 0 && phase.seconds == 0)) {
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
                    .map((phase) => phase.minutes * 60 + phase.seconds)
                    .toList();
                List<int> coldPhaseDurations = phases
                    .where((phase) => phase.type == 'cold')
                    .map((phase) => phase.minutes * 60 + phase.seconds)
                    .toList();

                int totalDuration = userPreferences.getTotalDuration();

                Navigator.pushReplacementNamed(
                  context,
                  '/sessionOverview',
                  arguments: {
                    'totalDuration': totalDuration,
                    'hotPhaseDurations': hotPhaseDurations,
                    'coldPhaseDurations': coldPhaseDurations,
                  },
                );
              },
            ),
            GradientButton(
              buttonText: 'Back to Home',
              onPressed: () {
                userPreferences.reset();
                Navigator.pushReplacementNamed(context, '/');
              },
            ),
          ],
        ),
      ),
    );
  }
}

abstract class UserPreferencesBase {
  void updatePhaseDurationMinutes(int index, String value);
  void updatePhaseDurationSeconds(int index, String value);
  int getTotalDuration();
  void reset();
  void addPhase();
  void removeLastPhase();
}

class UserPreferences extends UserPreferencesBase {
  final WidgetRef ref;
  final StateNotifierProvider phaseProvider;

  UserPreferences({required this.ref, required this.phaseProvider});

  @override
  void reset() {
    ref.read(phasesProvider.notifier).reset();
  }

  @override
  void updatePhaseDurationMinutes(int index, String value) {
    ref.read(phasesProvider.notifier).updatePhaseDurationMinutes(index, value);
  }

  @override
  void updatePhaseDurationSeconds(int index, String value) {
    ref.read(phasesProvider.notifier).updatePhaseDurationSeconds(index, value);
  }

  @override
  void addPhase() {
    ref.read(phasesProvider.notifier).addPhase();
  }

  @override
  int getTotalDuration() {
    return ref.read(phasesProvider.notifier).getTotalDuration();
  }

  @override
  void removeLastPhase() {
    ref.read(phasesProvider.notifier).removeLastPhase();
  }
}
