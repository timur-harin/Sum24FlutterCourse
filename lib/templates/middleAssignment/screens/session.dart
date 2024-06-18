import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

const Duration hotCycle = Duration(minutes: 3);
const Duration coldCycle = Duration(minutes: 1);

enum Temperature {
  hot,
  cold;

  Temperature getOpposite() {
    switch (this) {
      case Temperature.cold:
        return Temperature.hot;
      case Temperature.hot:
        return Temperature.cold;
    }
  }
}

class ShowerSession {
  Duration time;
  late Temperature temperature;
  int cycle;
  bool running;

  ShowerSession(this.time,
      {required this.cycle, required this.running, required this.temperature});
  ShowerSession.from(ShowerSession another)
      : this(another.time,
            cycle: another.cycle,
            running: another.running,
            temperature: another.temperature);

  void incrementCycle() {
    ++cycle;
    temperature = temperature.getOpposite();
  }
}

class ShowerSessionScreen extends ConsumerWidget {
  const ShowerSessionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String twoDigit(int n) => n.toString().padLeft(2, '0');
    final ShowerSession showerState = ref.watch(showerSessionProvider);
    // TODO: gradient backgrounds
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(showerState.temperature == Temperature.cold
                ? "Cold Water"
                : "Hot Water"),
            Text(
                "${twoDigit(showerState.time.inMinutes)}:${twoDigit(showerState.time.inSeconds.remainder(60))}"),
            Text("It's your ${showerState.cycle} cycle. Keep it up!"),
            showerState.running
                ? IconButton(
                    icon: const Icon(Icons.stop),
                    onPressed: () {
                      ref.read(showerSessionProvider.notifier).stopTimer();
                    },
                  )
                : IconButton(
                    icon: const Icon(Icons.play_arrow),
                    onPressed: () {
                      ref.read(showerSessionProvider.notifier).runTimer();
                    },
                  )
          ],
        ),
      ),
    );
  }
}

final showerSessionProvider =
    NotifierProvider<ShowerSessionNotifier, ShowerSession>(() {
  return ShowerSessionNotifier();
});

@riverpod
class ShowerSessionNotifier extends Notifier<ShowerSession> {
  Timer _timer = Timer(Duration.zero, () {});

  @override
  ShowerSession build() {
    _timer.cancel();
    return ShowerSession(hotCycle,
        cycle: 0, running: false, temperature: Temperature.hot);
  }

  void runTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (timer) {
      if (state.time == Duration.zero) {
        state = ShowerSession.from(state)
          ..time =
              (state.temperature == Temperature.cold ? hotCycle : coldCycle)
          ..incrementCycle();
      } else {
        state = ShowerSession.from(state)..time -= oneSec;
      }
    });
    state = (ShowerSession.from(state)..running = true);
  }

  void stopTimer() {
    _timer.cancel();
    state = (ShowerSession.from(state)..running = false);
  }
}
