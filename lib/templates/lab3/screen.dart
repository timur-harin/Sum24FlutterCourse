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
        title: Text('Hydration Tracker'),
        backgroundColor: Colors.purple,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () => ref.read(waterIntakeProvider.notifier).reset(),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Water Intake: $waterIntake L',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900,
                  shadows:  [
                    Shadow(
                      blurRadius: 10.0,
                      color: Colors.black,
                      offset: Offset(5.0, 5.0),
                    ),
                  ]
              ),
            ),
            HydrationWidget(waterIntakeLevel: waterIntake),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.read(waterIntakeProvider.notifier).increment(0.5),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
