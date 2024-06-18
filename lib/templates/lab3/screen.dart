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
        actions: <Widget>[
          IconButton(
            onPressed: () {
              ref.read(waterIntakeProvider.notifier).reset();
            }, 
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Your water intake:",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "${waterIntake.toStringAsFixed(1)} ml",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20
            ),
            HydrationWidget(
              waterIntakeLevel: waterIntake
            ),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () { 
          ref.read(waterIntakeProvider.notifier).increment(250);
        },
        child: Icon(Icons.add),
        tooltip: 'Increment',
      ),
    );
  }
}
