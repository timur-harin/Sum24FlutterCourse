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
        title: Text("reset"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed:() {ref.read(waterIntakeProvider.notifier).reset();}
          )
        ]
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("water intake: $waterIntake"),
            HydrationWidget(waterIntakeLevel: waterIntake),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          ref.read(waterIntakeProvider.notifier).increment(0.1);
        },
        tooltip: "Increment",
        child: Icon(Icons.exposure_plus_1),
      ),
    );
  }
}
