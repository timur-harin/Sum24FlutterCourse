import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'main.dart';
import 'preferences.dart';


class TimerShower extends StatelessWidget {
  final PreferencesState preferencesState;
  TimerShower ({Key? key, required this.preferencesState});

  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Timer'),
      ),
      body: Center(
        child: Text('${preferencesState.duration} minutes'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
  
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}