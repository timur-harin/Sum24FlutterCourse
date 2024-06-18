
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/session_provider.dart';
import 'session_preferences_screen.dart';

class HomeScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionHistory = ref.watch(sessionProvider).sessionHistory;

    return Scaffold(
      appBar: AppBar(
        title: Text('Contrast Shower Companion'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: sessionHistory.length,
              itemBuilder: (context, index) {
                final session = sessionHistory[index];
                return ListTile(
                  title: Text('Session on ${session.date}'),
                  subtitle: Text('Duration: ${session.totalDuration} mins, Rating: ${session.rate}'),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SessionPreferencesScreen()),
                );
              },
              child: Text('Start New Session'),
            ),
          ),
        ],
      ),
    );
  }
}

