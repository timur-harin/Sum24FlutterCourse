import 'package:education/templates/middleAssignment/data/session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShowerSessionScreen extends ConsumerWidget {
  const ShowerSessionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String twoDigit(int n) => n.toString().padLeft(2, '0');
    final ShowerSession sessionState = ref.watch(ShowerSessionManager.provider);
    const double iconSize = 52.0;
    // TODO: gradient backgrounds
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            switch (sessionState.thermostat) {
              Thermostat.cold => "Cold Water",
              Thermostat.hot => "Hot Water"
            },
            style: const TextStyle(
                fontSize: 64.0, fontWeight: FontWeight.w700, height: 1.1),
          ),
          Text(
            "${twoDigit(sessionState.time.inMinutes)}:${twoDigit(sessionState.time.inSeconds.remainder(60))}",
            style: const TextStyle(
                fontSize: 72.0, fontWeight: FontWeight.w900, height: 1.2),
          ),
          Text(
            "It's your ${sessionState.cycles} cycle. Keep it up!",
            style: const TextStyle(fontSize: 24.0),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                iconSize: iconSize,
                icon: const Icon(Icons.stop),
                onPressed: () {
                  ref
                      .read(ShowerSessionManager.provider.notifier)
                      .resetSession();
                },
              ),
              sessionState.isRunning
                  ? IconButton(
                      iconSize: iconSize,
                      icon: const Icon(Icons.pause),
                      onPressed: () {
                        ref
                            .read(ShowerSessionManager.provider.notifier)
                            .stopTimer();
                      },
                    )
                  : IconButton(
                      iconSize: iconSize,
                      icon: const Icon(Icons.play_arrow),
                      onPressed: () {
                        ref
                            .read(ShowerSessionManager.provider.notifier)
                            .runTimer();
                      },
                    ),
              Visibility(
                  visible: sessionState.cycles > 0,
                  maintainSize: true,
                  maintainState: true,
                  maintainAnimation: true,
                  child: IconButton(
                    iconSize: iconSize,
                    icon: const Icon(Icons.save),
                    onPressed: () {
                      ref
                          .read(ShowerSessionManager.provider.notifier)
                          .saveSession(context: context);
                    },
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
