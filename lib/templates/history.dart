import 'package:education/templates/middleAssignment/providers/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SessionHistoryPage extends ConsumerWidget {
  const SessionHistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workoutState = ref.watch(workoutProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Session History'),
      ),
      body: ListView.builder(
        itemCount: workoutState.workouts.length,
        itemBuilder: (context, index) {
          final workout = workoutState.workouts[index];
          return ListTile(
            title: const Text("Showering"),
            subtitle: Text(
              'Hot Cycles: ${workout.hotCycles}, Cold Cycles: ${workout.coldCycles}, Total Cycles: ${workout.totalCycles}, Date: ${workout.date}, Elapsed Time: ${workout.actualTime} seconds',
            ),
          );
        },
      ),
    );
  }
}
