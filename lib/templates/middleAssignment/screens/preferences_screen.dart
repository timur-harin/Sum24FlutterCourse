import 'package:education/templates/middleAssignment/models/temperature_phase.dart';
import 'package:education/templates/middleAssignment/providers/preferences_provider.dart';
import 'package:education/templates/middleAssignment/providers/session_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PreferencesScreen extends ConsumerWidget {
  PreferencesScreen({super.key});


  final TextEditingController controller = TextEditingController();
  final TextEditingController controller2 = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preferences'),
      ),
      body: Center(
        child: Column(
          children:  <Widget>[
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter  duration of phase in seconds',
              ),
              keyboardType: TextInputType.number,
              controller: controller,
            ),
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter number of phases',
              ),
              keyboardType: TextInputType.number,
              controller: controller2,
            ),
            DropdownButton<TemperaturePhase>(
              hint: const Text('Select first phase'),
              value: ref.watch(preferencesProvider).firstPhase,
              items: const [
                DropdownMenuItem(
                  value: TemperaturePhase.hot,
                  child: Text('Hot'),
                ),
                DropdownMenuItem(
                  value: TemperaturePhase.cold,
                  child: Text('Cold'),
                ),
              ],
              onChanged: (value) {
                ref.read(preferencesProvider.notifier).setFirstPhase(value!);
              },
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(preferencesProvider.notifier).setNumberOfPhases(int.parse(controller2.text));
                ref.read(preferencesProvider.notifier).setPhaseDuration(int.parse(controller.text));
                ref.read(sessionRiverpod.notifier).updatePhases(ref.read(preferencesProvider).firstPhase);
                Navigator.of(context).pushNamed('/overview');
              },
              child: const Text('Overview'),
            ),
          ],
        ),
      ),
    );
  }

}
