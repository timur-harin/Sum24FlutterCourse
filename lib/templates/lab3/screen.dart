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
        title: const Text("Hydration"),
        actions: [
          IconButton(
              onPressed: () => ref.read(waterIntakeProvider.notifier).reset(),
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Water intake: $waterIntake",
            ),
            HydrationWidget(waterIntakeLevel: waterIntake),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.plus_one),
        onPressed: () => ref.read(waterIntakeProvider.notifier).increment(0.7), // because my cup has this size...
      ),
    );
  }
}
