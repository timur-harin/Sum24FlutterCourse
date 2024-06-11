import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'hydration.dart';
import 'notifier.dart';

class HydrationScreen extends ConsumerWidget {
  const HydrationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final waterIntake = ref.watch(waterIntakeProvider);
    final waterIntakeLevel = waterIntake / 2;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hydration Tracker'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.read(waterIntakeProvider.notifier).reset();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Text(
                'Water Intake: ${waterIntake.toStringAsFixed(1)} L',
                style: const TextStyle(fontSize: 30),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: HydrationWidget(waterIntakeLevel: waterIntakeLevel),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(waterIntakeProvider.notifier).increment(0.25);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
