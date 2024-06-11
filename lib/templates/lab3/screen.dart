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
        title: Text('WaterBalance'),
        actions: [
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
            Text('consumption water: ${waterIntake.toStringAsFixed(1)} л'),
            SizedBox(height: 20),
            HydrationWidget(waterIntakeLevel: waterIntake),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.read(waterIntakeProvider.notifier).increment(0.5),
        tooltip: '+ water',
        child: Icon(Icons.add),),
      );
  }
}
