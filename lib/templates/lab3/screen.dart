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
        title: const Center(child: Text("Hydration Tracker")),
        actions: [
          IconButton(
              onPressed: ref.read(waterIntakeProvider.notifier).reset,
              icon: const Icon(Icons.bed))
        ],
      ),
      // TODO add AppBar with Icon to reset the water intake as actions parameter of AppBar
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Your Water Intake: $waterIntake ml"),
            HydrationWidget(waterIntakeLevel: waterIntake)
          ],
        ),
      ),
      floatingActionButton: TextButton(
        child: const Text("+"),
        onPressed: () => {
          if (waterIntake < 2000)
            ref.read(waterIntakeProvider.notifier).increment(250)
        },
      ),
    );
  }
}
