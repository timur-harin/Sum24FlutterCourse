import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers.dart'; // Assuming the providers are defined in this file
import 'models.dart';

class ShowerHistoryScreen extends ConsumerWidget {
  const ShowerHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showerHistory = ref.watch(showerHistoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shower History'),
      ),
      body: ListView.builder(
        itemCount: showerHistory.length,
        itemBuilder: (context, index) {
          final session = showerHistory[index];
          return ListTile(
            title: Text('Session on ${session.date}'),
            subtitle: Text('Duration: ${session.duration.inMinutes} minutes'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ActiveShowerScreen(session: session),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ActiveShowerScreen extends ConsumerWidget {
  @override
  final ShowerSession session;
  const ActiveShowerScreen({super.key, required this.session});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showerSession = ref.watch(showerSessionProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Active Shower Session'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Current Temperature Phase: ${showerSession.phases.last.temperature}'),
            Text('Remaining Time: ${showerSession.phases.last.duration.inSeconds} seconds'),
          ],
        ),
      ),
    );
  }
}