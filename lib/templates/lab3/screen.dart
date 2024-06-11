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
            icon: const Icon(Icons.refresh,),
            onPressed: () async {
              ref.read(waterIntakeProvider.notifier).reset();
            }, 
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Water intake: ${waterIntake.toStringAsFixed(2)} ml', style: const TextStyle(fontWeight: FontWeight.bold),),
            HydrationWidget(waterIntakeLevel: waterIntake),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(waterIntakeProvider.notifier).increment(250); 
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}