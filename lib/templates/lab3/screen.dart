import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'hydration.dart';
import 'notifier.dart';

class HydrationScreen extends ConsumerWidget {
  const HydrationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            
            Text ('Water intake: $waterIntake ml'),
            // TODO add HydrationWidget to display the water intake and put waterIntake into it

            HydrationWidget(waterIntakeLevel: waterIntake),
          

    

            // Add more UI components if necessary
          ],
        ),
      ),
      // TODO - Add floating action button to increment the water intake using ref.read(waterIntakeProvider.notifier).increment(x)

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(waterIntakeProvider.notifier).increment(150);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
