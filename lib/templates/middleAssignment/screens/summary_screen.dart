import 'package:education/templates/middleAssignment/models/temperature_phase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/session_provider.dart';

class SummaryScreen extends ConsumerStatefulWidget {
  const SummaryScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends ConsumerState<SummaryScreen> {
  int _currentRate = 0;

  @override
  Widget build(BuildContext context) {
    final session = ref.watch(sessionRiverpod);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Summary'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('Total Duration: ${session.totalDuration}'),
            Text("Number of Phases: ${session.phases.length}"),
            Column(
              children: [
                for (int i = 0; i < session.phases.length; i++)
                  Text("Phase ${i + 1}: ${session.phases[i] == TemperaturePhase.hot ? 'hot' : 'cold'}"),
              ],
            ),
            Text("Date: ${session.date.day}/${session.date.month}/${session.date.year}"),
            Text("Rate the session:"),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return IconButton(
                  icon: Icon(
                    index < _currentRate ? Icons.star : Icons.star_border,
                  ),
                  color: Colors.amber,
                  onPressed: () {
                    setState(() {
                      _currentRate = index + 1;
                    });
                    ref.read(sessionRiverpod.notifier).setRate(_currentRate);
                  },
                );
              }),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/');
              },
              child: Text("To home screen"),
            )
          ],
        ),
      ),
    );
  }
}
