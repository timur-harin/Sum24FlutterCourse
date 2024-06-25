import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../ui/widgets/timer_widget.dart';
import '../storage/notifier.dart';

class ActiveSessionScreen extends StatelessWidget {
  final int id;
  final String currentPhase;
  final Duration initialRemainingTime;
  final Function onSessionEnd;

  const ActiveSessionScreen({
    super.key,
    required this.id,
    required this.currentPhase,
    required this.initialRemainingTime,
    required this.onSessionEnd,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Active Session'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Current Temperature Phase: $currentPhase',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TimerWidget(
              id: id,
              initialDuration: initialRemainingTime,
              timerName: 'Timer',
              onTimerFinished: onSessionEnd,
            ),
            ElevatedButton(
                onPressed: () {
                  Duration remainingTime = context
                      .read<TimerNotifier>()
                      .loadData('Timer', const Duration(minutes: 1));
                  context
                      .read<SessionNotifier>()
                      .saveData(id, currentPhase, remainingTime);
                },
                child: const Text("Save Data"))
          ],
        ),
      ),
    );
  }
}
