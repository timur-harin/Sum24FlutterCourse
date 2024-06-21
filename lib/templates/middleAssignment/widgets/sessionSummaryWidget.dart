import 'package:education/templates/middleAssignment/providers/selectedSessionProvider.dart';
import 'package:education/templates/middleAssignment/providers/sessionProvider.dart';
import 'package:education/templates/middleAssignment/session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SessionSummaryWidget extends ConsumerStatefulWidget {
  const SessionSummaryWidget({super.key});

  @override
  ConsumerState<SessionSummaryWidget> createState() => _SessionSummaryWidgetState();
}

class _SessionSummaryWidgetState extends ConsumerState<SessionSummaryWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 5,
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: finishedSessionInfo(),
      ),
    );
  }

  Text finishedSessionInfo() {
    final Session finishedSession = ref.watch(finishedSessionNotifierProvider.notifier).lastSession();
    final Session session = ref.watch(selectedSessionNotifierProvider);

    return Text(
      'Phases finished: ${finishedSession.numberOfPhases()}/${session.numberOfPhases()}\n'
      'Periods finished: ${finishedSession.numberOfPeriods()}/${session.numberOfPeriods()}\n'
      'Session time: ${Session.formattedDuration(finishedSession.getSessionDuration())}\n'
      'Expected session time: ${Session.formattedDuration(session.getSessionDuration())}\n'
      'Task completion rate: ${(
        (finishedSession.getSessionDuration().inSeconds / session.getSessionDuration().inSeconds) * 100
        ).toStringAsFixed(0)}%',
        
      style: const TextStyle(fontSize: 24),
    );
  }
}