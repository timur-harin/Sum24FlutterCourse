import 'package:education/templates/middleAssignment/shower_procedure.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'notifier.dart';
import 'storage.dart';

class HydrationScreen extends ConsumerWidget {
  const HydrationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final waterIntake = ref.watch(showerProceduresProvider);
    return Scaffold(
      appBar: AppBar(
              title: const Text("New Procedure"),
              actions: <Widget>[
                IconButton(
                  icon: const Icon(Icons.plus_one_rounded),
                  onPressed: ref.read(showerProceduresProvider.notifier).reset,
                )
              ]
            ),      
            body: Center(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[const Text("Your Procedures"), 
            ListView(children: <Widget>[],),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.read(showerProceduresProvider.notifier).addNewShowerProcedure(
          ShowerProcedure(
            cold_duration: 0.0,
            hot_duration: 0.0
            )
            ),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}