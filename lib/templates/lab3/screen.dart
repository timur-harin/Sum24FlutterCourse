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
    appBar: AppBar(
      title: const Text('Hydration'),
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: () {
            ref.read(waterIntakeProvider.notifier).reset();
          },
        ),
      ],
    ),
    
      // TODO add AppBar with Icon to reset the water intake as actions parameter of AppBar
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          Text('Water Intake: $waterIntake'),
            // TODO - Add text to display the water intake
            HydrationWidget(waterIntakeLevel: waterIntake),
            // TODO add HydrationWidget to display the water intake and put waterIntake into it
            // Add more UI components if necessary
          ],
        ),
      ),
      floatingActionButton: IconButton(
        icon: const Icon(Icons.add),
        onPressed: () {
          ref.read(waterIntakeProvider.notifier).increment(1);
        },
      ),
      // TODO - Add floating action button to increment the water intake using ref.read(waterIntakeProvider.notifier).increment(x)
    );
  }
}
