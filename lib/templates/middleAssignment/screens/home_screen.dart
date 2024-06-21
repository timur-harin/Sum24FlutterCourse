import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../session_notifier.dart';

class HomeScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionHistory = ref.watch(sessionHistoryProvider);

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
                  title: Text('Session on ${session.dateTime}'),
                  subtitle: Text('Duration: ${session.duration} seconds'),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/new-session');
            },
            child: Text('Start New Session'),
          ),
        ],
      ),
    );
  }
}
