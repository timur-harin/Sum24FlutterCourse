import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'hydration.dart';
import 'notifier.dart';

const Color primary = Colors.teal;
const Color accent = Colors.tealAccent;

class HydrationScreen extends ConsumerWidget {
  const HydrationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final waterIntake = ref.watch(waterIntakeProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        foregroundColor: accent,
        leading: const Icon(
          Icons.local_drink,
        ),
        title: const Text('Betta Watch Your Water Intake'),
        actions: [
          TextButton(
            child: const Icon(
              Icons.bolt_outlined,
              color: accent,
            ),
            onPressed: () {
              ref.read(waterIntakeProvider.notifier).reset();
            },
          )
        ],
      ),
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            SizedBox.expand(
              child: HydrationWidget(
                waterIntakeRatio: waterIntake / maxLevel,
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Your current water intake is:',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
                Text(
                  '$waterIntake ml',
                  style: const TextStyle(
                      fontSize: 64, fontWeight: FontWeight.w700),
                ),
              ],
            ),
            // Add more UI components if necessary
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: accent,
        foregroundColor: primary,
        onPressed: () {
          ref.read(waterIntakeProvider.notifier).increment();
        },
        child: const Icon(
          Icons.water_drop,
        ),
      ),
    );
  }
}
