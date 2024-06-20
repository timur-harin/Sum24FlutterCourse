import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'shower_session.dart';
import 'theme.dart';

class ActiveSessionScreen extends ConsumerWidget {
  final ShowerSession session;
  final int currentCycle;
  final bool isHot;

  ActiveSessionScreen({
    required this.session,
    required this.currentCycle,
    required this.isHot,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cycle = session.cycles[currentCycle];
    final duration = isHot ? cycle.hotDuration : cycle.coldDuration;
    final temperature = isHot ? session.hotTemperature : session.coldTemperature;
    final fillColor = isHot ? AppColors.hot : AppColors.cold;

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Active Session',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
        backgroundColor: AppColors.primary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Cycle ${currentCycle + 1}',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            SizedBox(height: 20),
            Text(
              'Water Temperature: $temperature°C',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(height: 20),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(fillColor),
              strokeWidth: 8,
              value: duration / (isHot ? session.hotDuration : session.coldDuration),
            ),
          ],
        ),
      ),
    );
  }
}
