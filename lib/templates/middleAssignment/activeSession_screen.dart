import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'models.dart';
import 'main.dart';
import 'timer.dart';

class ActiveSessionScreen extends ConsumerWidget {
  final ShowerSession session;

  ActiveSessionScreen({required this.session});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timerProvider = ref.watch(sessionTimerProvider(session));

    if (timerProvider.isComplete) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pop(context);
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Active Session'),
      ),
      body: AnimatedContainer(
        duration: Duration(seconds: 1),
        color: timerProvider.currentPhase.type == 'hot' ? Colors.red : Colors.blue,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                timerProvider.currentPhase.type == 'hot' ? Icons.wb_sunny : Icons.ac_unit,
                size: 100,
                color: Colors.white,
              ),
              SizedBox(height: 16),
              Text(
                'Current Phase: ${timerProvider.currentPhase.type}',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
              SizedBox(height: 16),
              Text(
                'Time Remaining: ${timerProvider.timeRemaining}',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
              SizedBox(height: 32), 
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (timerProvider.isPaused)
                    CircularIconButton(
                      icon: Icons.play_arrow,
                      onPressed: () {
                        ref.read(sessionTimerProvider(session).notifier).resume();
                      },
                    )
                  else
                    CircularIconButton(
                      icon: Icons.pause,
                      onPressed: () {
                        ref.read(sessionTimerProvider(session).notifier).pause();
                      },
                    ),
                  SizedBox(height: 16), 
                  GradientButton(
                    text: 'End Session',
                    width: 120, 
                    onPressed: () {
                      ref.read(sessionTimerProvider(session).notifier).end();
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}