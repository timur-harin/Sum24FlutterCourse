import 'package:education/templates/middleAssignment/data/session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShowerSessionScreen extends ConsumerWidget {
  const ShowerSessionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String twoDigit(int n) => n.toString().padLeft(2, '0');
    final ShowerSession showerState = ref.watch(ShowerSessionManager.provider);
    // TODO: gradient backgrounds
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(switch (showerState.thermostat) {
              Thermostat.cold => "Cold Water",
              Thermostat.hot => "Hot Water"
            }),
            Text(
                "${twoDigit(showerState.time.inMinutes)}:${twoDigit(showerState.time.inSeconds.remainder(60))}"),
            Text("It's your ${showerState.cycles} cycle. Keep it up!"),
            showerState.isRunning
                ? IconButton(
                    icon: const Icon(Icons.stop),
                    onPressed: () {
                      ref
                          .read(ShowerSessionManager.provider.notifier)
                          .stopTimer();
                    },
                  )
                : IconButton(
                    icon: const Icon(Icons.play_arrow),
                    onPressed: () {
                      ref
                          .read(ShowerSessionManager.provider.notifier)
                          .runTimer();
                    },
                  ),
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: () {
                ref
                    .read(ShowerSessionManager.provider.notifier)
                    .saveSession(context: context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
