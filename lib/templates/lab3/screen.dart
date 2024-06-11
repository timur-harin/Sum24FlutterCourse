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
    // final waterIntake =

    return Scaffold(
      appBar: AppBar(
        title: Text('Check your hydration'),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.cached,
                color: Colors.black,
              ),
              onPressed: () {
                ref.read(waterIntakeProvider.notifier).reset();
              })
        ],
      ),
      // TODO add AppBar with Icon to reset the water intake as actions parameter of AppBar
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("The total water intake is $waterIntake"),
            HydrationWidget(waterIntakeLevel: waterIntake)
            // TODO - Add text to display the water intake
            // TODO add HydrationWidget to display the water intake and put waterIntake into it
            // Add more UI components if necessary
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(waterIntakeProvider.notifier).increment(100.0);
        },
        tooltip: 'Drink water',
        child: const Icon(Icons.water),
      ),
      // TODO - Add floating action button to increment the water intake using ref.read(waterIntakeProvider.notifier).increment(x)
    );
  }
}
