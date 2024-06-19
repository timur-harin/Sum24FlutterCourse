import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'data.dart';
import 'session.dart';

class PreferencesScreen extends ConsumerWidget {
  const PreferencesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Preferences',
          style: TextStyle(color: Colors.white)
        ),
        leading: const BackButton(color: Colors.white),
        backgroundColor: Colors.cyan[400],
      ),
      body: const Center(
        child: Text('Settings'),
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