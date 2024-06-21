import 'package:education/templates/middleAssignment/data/session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShowerSessionScreen extends ConsumerStatefulWidget {
  const ShowerSessionScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ShowerSessionScreenState();
}

class _ShowerSessionScreenState extends ConsumerState<ShowerSessionScreen> {
  bool _startedSession = false;
  bool _runningSession = false;

  @override
  Widget build(BuildContext context) {
    String twoDigit(int n) => n.toString().padLeft(2, '0');
    final ShowerSession sessionState = ref.watch(ShowerSessionManager.provider);
    // TODO: gradient backgrounds
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(children: [
          const Spacer(flex: 5),
          Text(
            switch (sessionState.thermostat) {
              Thermostat.cold => "Cold Water",
              Thermostat.hot => "Hot Water"
            },
            style: const TextStyle(
                fontSize: 64.0, fontWeight: FontWeight.w700, height: 1.1),
          ),
          const Spacer(flex: 1),
          Text(
            "${twoDigit(sessionState.time.inMinutes)}:${twoDigit(sessionState.time.inSeconds.remainder(60))}",
            style: const TextStyle(
                fontSize: 72.0, fontWeight: FontWeight.w900, height: 1.2),
          ),
          Text(
            "It's your ${sessionState.cycles} cycle. Keep it up!",
            style: const TextStyle(fontSize: 24.0),
          ),
          const Spacer(flex: 2),
          sessionButtons(context),
          const Spacer(flex: 5),
        ]),
      ),
    );
  }

  Widget sessionButtons(BuildContext context) {
    const double iconSize = 52.0;
    if (_startedSession) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            iconSize: iconSize,
            icon: const Icon(Icons.stop),
            onPressed: () {
              if (ref
                  .read(ShowerSessionManager.provider.notifier)
                  .resetSession()) {
                setState(
                  () {
                    _startedSession = false;
                    _runningSession = false;
                  },
                );
              }
            },
          ),
          _runningSession
              ? IconButton(
                  iconSize: iconSize,
                  icon: const Icon(Icons.pause),
                  onPressed: () {
                    if (ref
                        .read(ShowerSessionManager.provider.notifier)
                        .stopTimer()) {
                      setState(
                        () {
                          _runningSession = false;
                        },
                      );
                    }
                  },
                )
              : IconButton(
                  iconSize: iconSize,
                  icon: const Icon(Icons.play_arrow),
                  onPressed: () {
                    if (ref
                        .read(ShowerSessionManager.provider.notifier)
                        .runTimer()) {
                      setState(
                        () {
                          _runningSession = true;
                        },
                      );
                    }
                  },
                ),
          IconButton(
            iconSize: iconSize,
            icon: const Icon(Icons.save),
            onPressed: () async {
              if (await ref
                  .read(ShowerSessionManager.provider.notifier)
                  .saveSession(context: context)) {
                setState(
                  () {
                    _startedSession = false;
                    _runningSession = false;
                  },
                );
              }
            },
          ),
        ],
      );
    } else {
      return TextButton(
        child: const Text('Start new session',
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600)),
        onPressed: () {
          if (ref.read(ShowerSessionManager.provider.notifier).runTimer()) {
            setState(
              () {
                _startedSession = true;
                _runningSession = true;
              },
            );
          }
        },
      );
    }
  }
}
