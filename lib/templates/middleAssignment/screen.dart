import 'package:education/templates/middleAssignment/main.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'data.dart';
import 'preferences.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Contrast Shower Companion',
          style: TextStyle(color: Colors.white)
        ),
        backgroundColor: Colors.cyan[400],
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<Session>(sessionBoxName).listenable(),
        builder: (context, Box<Session> box, _) {
          if (box.values.isEmpty) {
            return const Center(
              child: Text(
                'No sessions',
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.blueGrey,
                ),
              ),
            );
          }
          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              Session? s = box.getAt(index);
              return Card(
                child: ListTile(
                  title: Text('Session with ${s!.cycles} cycles, ${s.rating}/5'),
                  subtitle: Text(s.getDuration()),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      box.deleteAt(index);
                    },
                  ),
                ),
              );
            },
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context, 
            MaterialPageRoute(builder: (context) => const PreferencesScreen()),
          );
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