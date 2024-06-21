import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'session.dart';
import 'providers.dart';

class PreferencesScreen extends ConsumerStatefulWidget {
  const PreferencesScreen({super.key});

  @override
  ConsumerState<PreferencesScreen> createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends ConsumerState<PreferencesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Preferences',
          style: TextStyle(color: Colors.white)
        ),
        leading: const BackButton(color: Colors.white),
        backgroundColor: Colors.cyan[400],
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 40),
            Text(
              'Number of Cycles',
              style: TextStyle(
                fontSize: 25, 
                color: Colors.blueGrey[800],
              ),
            ),
            const SizedBox(height: 10),
            Slider(
              value: ref.watch(cyclesProvider),
              max: 10,
              min: 1,
              divisions: 9,
              label: ref.watch(cyclesProvider).round().toString(),
              activeColor: Colors.cyan[300],
              onChanged: (double value) {
                setState(() {
                  ref.read(cyclesProvider.notifier).state = value;
                });
              },
            ),
            const SizedBox(height: 40),
            Text(
              'Cycle Duration',
              style: TextStyle(
                fontSize: 25,
                color: Colors.blueGrey[800],
              ),
            ),
            const SizedBox(height: 10),
            Slider(
              value: ref.watch(intervalProvider),
              max: 60,
              min: 5,
              divisions: 11,
              label: ref.watch(intervalProvider).round().toString(),
              activeColor: Colors.cyan[300],
              onChanged: (double value) {
                setState(() {
                  ref.read(intervalProvider.notifier).state = value;
                });
              },
            ),
          ],
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context, 
            MaterialPageRoute(builder: (context) => const SessionScreen()),
          );
        },
        tooltip: 'Start',
        shape: const CircleBorder(),
        backgroundColor: Colors.cyan[300],
        child: const Icon(Icons.play_arrow, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}