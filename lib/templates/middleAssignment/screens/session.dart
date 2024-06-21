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
    if (sessionState.finished) {
      WidgetsBinding.instance.addPostFrameCallback((duration) {
        saveAndRate(context, sessionState);
      });
    }
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
          sessionButtons(context, sessionState),
          const Spacer(flex: 5),
        ]),
      ),
    );
  }

  Widget sessionButtons(BuildContext context, ShowerSession sessionState) {
    const double iconSize = 52.0;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Visibility(
          visible: _startedSession,
          maintainSize: true,
          maintainState: true,
          maintainAnimation: true,
          child: IconButton(
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
                        _startedSession = true;
                        _runningSession = true;
                      },
                    );
                  }
                },
              ),
        Visibility(
          visible: _startedSession,
          maintainSize: true,
          maintainState: true,
          maintainAnimation: true,
          child: IconButton(
            iconSize: iconSize,
            icon: const Icon(Icons.save),
            onPressed: () {
              saveAndRate(context, sessionState);
            },
          ),
        ),
      ],
    );
  }

  void saveAndRate(BuildContext context, ShowerSession sessionState) {
    if (sessionState.cycles < 1) {
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(const SnackBar(
          content: Text('Complete at least one session to save it'),
        ));
      return;
    }
    String twoDigit(int n) => n.toString().padLeft(2, '0');
    setState(() {
      _runningSession = false;
    });
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Well done!'),
        content: Text(
            "You've successfully completed this contrast shower.\nYou've been in shower ${twoDigit(sessionState.totalTime.inMinutes)}:${twoDigit(sessionState.totalTime.inSeconds.remainder(60))}.\nWould you like to save it into history?"),
        actions: [
          TextButton(
            child: const Text('No, discard it'),
            onPressed: () {
              if (ref
                  .read(ShowerSessionManager.provider.notifier)
                  .resetSession()) {
                Navigator.of(context).popUntil(ModalRoute.withName('/'));
              } else {
                Navigator.of(context).pop();
              }
            },
          ),
          TextButton(
            child: const Text('Yes, save please!'),
            onPressed: () {
              if (ref
                  .read(ShowerSessionManager.provider.notifier)
                  .saveSession()) {
                ScaffoldMessenger.of(context)
                  ..removeCurrentSnackBar()
                  ..showSnackBar(const SnackBar(
                    content: Text('Session saved!'),
                  ));
                Navigator.of(context).popUntil(ModalRoute.withName('/'));
              } else {
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
    );
  }
}
