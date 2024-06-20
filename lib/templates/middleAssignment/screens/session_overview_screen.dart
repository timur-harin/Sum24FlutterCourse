import '../notifiers/phases_notifier.dart';
import 'active_session_screen.dart';
import '../small_widgets/gradient_appbar.dart';
import 'package:flutter/material.dart';
import '../small_widgets/gradient_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../notifiers/session_notifier.dart';

class SessionOverviewScreen extends ConsumerWidget {
  late int totalDuration;
  late List<int> hotPhaseDurations;
  late List<int> coldPhaseDurations;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
    final totalDuration = arguments['totalDuration'];
    final hotPhaseDurations = arguments['hotPhaseDurations'];
    final coldPhaseDurations = arguments['coldPhaseDurations'];

    return Scaffold(
      appBar: const GradientAppBar(
        title: 'Session Overview',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Total Duration: ${totalDuration ~/ 60} minutes ${totalDuration % 60} seconds',
                style: const TextStyle(
                  fontSize: 24,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Hot Phases: ${hotPhaseDurations.length}',
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.red,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Cold Phases: ${coldPhaseDurations.length}',
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.cyan,
                ),
              ),
              const SizedBox(height: 20),
              GradientButton(
                buttonText: 'Begin Session',
                onPressed: () {
                  ref.read(sessionsProvider.notifier).startSession(
                        totalDuration,
                        hotPhaseDurations,
                        coldPhaseDurations,
                      );

                  ref.read(phasesProvider.notifier).reset();

                  Navigator.of(context).pushReplacementNamed(
                    '/activeSession',
                    arguments: {
                      'totalDuration': totalDuration,
                      'hotPhaseDurations': hotPhaseDurations,
                      'coldPhaseDurations': coldPhaseDurations,
                    },
                  );
                },
              ),
              GradientButton(
                buttonText: 'Back to Preferences',
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/preferences');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
