import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:education/templates/middleAssignment/storage.dart';
import 'package:education/templates/middleAssignment/addSessionScreen.dart';


class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localStorageService = LocalStorageService();

  return Scaffold(
    appBar: AppBar(
      title: Text('Contrast Showers',),
      backgroundColor: Color(0xFF24305E),
      foregroundColor: Colors.white,
    ),
    body: FutureBuilder<List<ShowerSession>>(
        future: localStorageService.getSessions(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading sessions'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No sessions available'));
          }

          final sessions = snapshot.data!;

          return ListView(
            children: sessions.map((session) {
              return ExpansionTile(
                title: Text(session.date.toIso8601String()),
                children: session.phases.map((phase) {
                  return ListTile(
                    title: Text(phase.name),
                    subtitle: Text('${phase.duration.inMinutes} minutes'),
                  );
                }).toList(),
              );
            }).toList(),
          ); 
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddSessionScreen()),
          );
        },
        child: const Icon(Icons.add),
        backgroundColor: Color(0xFF24305E),
        foregroundColor: Colors.white,
      ),
    );
  }
}