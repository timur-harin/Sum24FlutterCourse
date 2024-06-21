import 'package:education/templates/middleAssignment/main.dart';
import 'package:education/templates/middleAssignment/ui/history.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.meeting_room),
          onPressed: () {
            Hive.close();
            SystemNavigator.pop();
          },
        ),
        title: const Text('Contrast Shower Manager'),
        foregroundColor: Colors.white,
        backgroundColor: primary,
      ),
      body: const SessionHistoryList(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        label: const Text('Start new session'),
        onPressed: () {
          Navigator.pushNamed(context, '/settings');
        },
      ),
    );
  }
}
