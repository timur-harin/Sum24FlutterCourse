import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'hydration.dart';
import 'notifier.dart';

class HydrationScreen extends ConsumerWidget {
  const HydrationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO - Add ref.watch and use provider to get the water intake DONE
    final waterIntake = ref.watch(waterIntakeProvider);
    return Scaffold(
      // TODO add AppBar with Icon to reset the water intake as actions parameter of AppBar DONE
      appBar: AppBar(
        toolbarHeight: 50,
        backgroundColor: Colors.cyan,
        centerTitle: true,
        title: const Text('Hydration Tracker'),
        actions: [

          IconButton(
            icon: const Icon(
              Icons.refresh,
              color: Colors.black,),
              tooltip: 'Refresh water intake',
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
            // TODO - Add text to display the water intake DONE
            Text("Water intake: ${waterIntake} ml",),
            // TODO add HydrationWidget to display the water intake and put waterIntake into it DONE
            HydrationWidget(waterIntakeLevel: waterIntake),
            // Add more UI components if necessary
          ],
        ),
      ),
      // TODO - Add floating action button to increment the water intake using ref.read(waterIntakeProvider.notifier).increment(x) DONE
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        
        backgroundColor: Colors.cyan,
        child: Icon(
          Icons.add,
        ),
        onPressed: () => ref.read(waterIntakeProvider.notifier).increment(250),
        ),
    );
  }
}
