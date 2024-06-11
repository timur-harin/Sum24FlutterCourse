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
      appBar : AppBar(
        title: Text("Hydration Tracker"),
        actions: [
          IconButton(onPressed: () {ref.read(waterIntakeProvider.notifier).reset();},
           icon: const Icon(
            Icons.water_drop_outlined,
            size: 30))
        ],
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Water taken: $waterIntake ml."),
            HydrationWidget(waterIntakeLevel: waterIntake)
          ],
        ),
      ),
      floatingActionButton: SizedBox (
        width: 60,
        height: 60,
        child: FloatingActionButton (
          onPressed: () { ref.read(waterIntakeProvider.notifier).increment(250); },),
        )
    );
  }
}
