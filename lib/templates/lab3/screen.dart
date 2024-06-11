import 'package:education/templates/lab3/storage.dart';
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
              title: const Text("reset"),
              actions: <Widget>[
                IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: ref.read(waterIntakeProvider.notifier).reset,
                )
              ]
            ),      
            body: Center(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[const Text("water intake"),
            HydrationWidget(waterIntakeLevel: waterIntake),
            // TODO add HydrationWidget to display the water intake and put waterIntake into it
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.read(waterIntakeProvider.notifier).increment(0.1),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}