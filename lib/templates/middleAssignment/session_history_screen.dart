import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'session_history_provider.dart';

class SessionHistoryScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionHistory = ref.watch(sessionHistoryProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Session History'),
      ),
      body: Container(
        color: Color.fromRGBO(157, 213, 235, 1),
        child: ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount: sessionHistory.length,
          itemBuilder: (context, index) {
            final session = sessionHistory[index];
            final formattedDateTime = DateFormat('yyyy-MM-dd HH:mm').format(session.sessionDateTime);
            return Card(
              color: Colors.white, 
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16.0),
                title: Text(
                  'Session ${index + 1}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8.0),
                    Text(
                      'Total Time: ${session.totalTime ~/ 60} mins',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      'Phases: ${session.totalPhases}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      'Date: $formattedDateTime',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
