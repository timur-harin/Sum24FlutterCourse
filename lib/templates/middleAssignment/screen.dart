import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'data.dart';
import 'providers.dart';
import 'preferences.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessions = ref.watch(sessionListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Contrast Shower Companion',
          style: TextStyle(color: Colors.white)
        ),
        backgroundColor: Colors.cyan[400],
      ),
      body: sessions.isEmpty 
        ? const Center(
            child: Text(
              'No sessions',
              style: TextStyle(fontSize: 24, color: Colors.blueGrey),
            ),
          )
        : ListView(
          children: [
            if (sessions.isNotEmpty) const Divider(height: 0),
            for (var i = 0; i < sessions.length; i++) ...[
              if (i > 0) const Divider(height: 0),
              SessionItem(session: sessions[i]),
            ],
          ],
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context, 
            MaterialPageRoute(builder: (context) => const PreferencesScreen()),
          );
          //add(ref); another way to add
          //ref.read(sessionListProvider.notifier).add();
        },
        tooltip: 'Start New Session',
        shape: const CircleBorder(),
        backgroundColor: Colors.cyan[300],
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class SessionItem extends StatelessWidget {
  final Session session;

  const SessionItem({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: ListTile(
        title: Text('Session ${session.id}'),
      ),
    );
  }
}
