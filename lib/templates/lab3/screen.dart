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
      title: const Text('Water Intake'),
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
            Text("Water Intake: $waterIntake"),
            HydrationWidget(waterIntakeLevel: waterIntake)
          ],
        ),
      ),
      // TODO - Add floating action button to increment the water intake using ref.read(waterIntakeProvider.notifier).increment(x)
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(waterIntakeProvider.notifier).increment(0.1);
        },
        tooltip: "Increment the water intake",
        child: const Icon(Icons.add),
      )
    );
  }
}
