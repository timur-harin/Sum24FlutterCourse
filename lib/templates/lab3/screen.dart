import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'hydration.dart';
import 'notifier.dart';

class HydrationScreen extends ConsumerWidget {
  const HydrationScreen({super.key});
  

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO - Add ref.watch and use provider to get the water intake
    final waterIntake = ref.watch(waterIntakeProvider);
  
    return Scaffold(
      // TODO add AppBar with Icon to reset the water intake as actions parameter of AppBar
      appBar: AppBar(
        title: const Text("reset"),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(waterIntakeProvider.notifier).reset();
            }
          , icon: const Icon(Icons.reset_tv))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // TODO - Add text to display the water intake
            // TODO add HydrationWidget to display the water intake and put waterIntake into it
            // Add more UI components if necessary
            Text('Water intake: ${waterIntake * 1000} ml'),
            HydrationWidget(waterIntakeLevel: waterIntake),
          ],
        ),
      ),
      // TODO - Add floating action button to increment the water intake using ref.read(waterIntakeProvider.notifier).increment(x)
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(waterIntakeProvider.notifier).increment(0.125);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
