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
        title: Text("Hydration tracker"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
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
              'Уровень воды: ${waterIntake.toStringAsFixed(1)} L',
            ),
            SizedBox(height: 20),
            HydrationWidget(waterIntakeLevel: waterIntake),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          ref.read(waterIntakeProvider.notifier).increment(0.1);
        },
        child: Icon(Icons.add),
        ),
    );
  }
}
