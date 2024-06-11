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
        title: const Text('Water Balance'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.read(waterIntakeProvider.notifier).reset();
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Water Intake Program: ${waterIntake.toStringAsFixed(4)} liters',
              style: const TextStyle(fontSize: 12),
            ),
            const SizedBox(height: 10),
            HydrationWidget(waterIntakeLevel: waterIntake),
            const SizedBox(height: 10),
            FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () {
                final incrementAmount = 0.5;
                ref.read(waterIntakeProvider.notifier).increment(incrementAmount);
              },
            ),
          ],
                
            
            
            // TODO - Add text to display the water intake

            // TODO add HydrationWidget to display the water intake and put waterIntake into it
            // Add more UI components if necessary
    
        ),
      ),
      // TODO - Add floating action button to increment the water intake using ref.read(waterIntakeProvider.notifier).increment(x)
    );
  }
}
