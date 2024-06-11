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
        title: const Text('Hydration tracker', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.water_drop_outlined,
              size: 35,
            ),
            onPressed: () {
              ref.read(waterIntakeProvider.notifier).reset();
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Water intake: $waterIntake ml',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 10,),
            HydrationWidget(waterIntake: waterIntake),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        width: 70,
        height: 70,
        child: FloatingActionButton(
          onPressed: () {
            ref.read(waterIntakeProvider.notifier).increment(250); 
          },
          tooltip: 'Increment',
          backgroundColor: Colors.white,
          child: const Icon(
            Icons.water_drop_sharp,
            size: 40,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
