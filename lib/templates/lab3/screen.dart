import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'hydration.dart';
import 'notifier.dart';

class HydrationScreen extends ConsumerWidget {
  const HydrationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Add ref.watch and use provider to get the water intake
    final waterIntake = ref.watch(waterIntakeProvider);
    return Scaffold(
      // add AppBar with Icon to reset the water intake as actions parameter of AppBar
      appBar: AppBar(
        title: Text('Hydration Screen'),
        actions: [IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: () {
        // Code to reset water intake goes here
        ref.read(waterIntakeProvider.notifier).reset();
        },
      ),
    ],
  ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Add text to display the water intake
            Text('Water intake: $waterIntake'),
            // add HydrationWidget to display the water intake and put waterIntake into it
            HydrationWidget(waterIntakeLevel: waterIntake),
            // Add more UI components if necessary
          ],
        ),
      ),
      // Add floating action button to increment the water intake using ref.read(waterIntakeProvider.notifier).increment(x)
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (waterIntake < 100) {
            ref.read(waterIntakeProvider.notifier).increment(10);
            }else{
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Done"), duration: Duration(seconds: 2))
              );
          
            }
          }
        )
      );
    }
  }