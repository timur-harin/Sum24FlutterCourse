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
              'Water Intake: ${waterIntake.toStringAsFixed(2)} liters',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            HydrationWidget(waterIntakeLevel: waterIntake),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(waterIntakeProvider.notifier).increment(0.1);
        },
        tooltip: 'Add Water',
        child: const Icon(Icons.add),
      ),
    );
  }
}
