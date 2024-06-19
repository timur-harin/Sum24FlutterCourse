import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

enum Thermostat {
  hot,
  cold;

  static Thermostat? parse(String s) {
    for (Thermostat t in Thermostat.values) {
      if (s == t.name.toLowerCase()) {
        return t;
      }
    }
    return null;
  }

  Thermostat getNext() {
    switch (this) {
      case Thermostat.cold:
        return Thermostat.hot;
      case Thermostat.hot:
        return Thermostat.cold;
    }
  }

  @override
  String toString() {
    return name.toLowerCase();
  }
}

class ShowerSession {
  static const Duration hotCycle = Duration(seconds: 3);
  static const Duration coldCycle = Duration(minutes: 1);

  Duration time;
  Thermostat thermostat;
  int cycles;
  bool isRunning;

  ShowerSession(this.time,
      {required this.cycles,
      required this.isRunning,
      required this.thermostat});
  ShowerSession.from(ShowerSession another)
      : this(another.time,
            cycles: another.cycles,
            isRunning: another.isRunning,
            thermostat: another.thermostat);

  Map toDbItem() {
    return {
      'timestamp': DateTime.now().toUtc(),
      'cycles': cycles,
      'last_temp': thermostat.toString()
    };
  }

  void incrementCycle() {
    ++cycles;
    thermostat = thermostat.getNext();
  }
}

class ShowerSessionManager extends Notifier<ShowerSession> {
  static final provider =
      NotifierProvider<ShowerSessionManager, ShowerSession>(() {
    return ShowerSessionManager();
  });
  static final historyBoxProvider =
      FutureProvider<Box<Map>>((ref) => Hive.openBox<Map>('history'));

  late Timer _timer = Timer(Duration.zero, () {});

  @override
  ShowerSession build() {
    _timer.cancel();
    ref.onDispose(() {
      _timer.cancel();
    });
    return ShowerSession(ShowerSession.hotCycle,
        cycles: 0, isRunning: false, thermostat: Thermostat.hot);
  }

  void runTimer() {
    if (_timer.isActive) {
      return;
    }
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (timer) {
      if (state.time == Duration.zero) {
        state = ShowerSession.from(state)
          ..incrementCycle()
          ..time = switch (state.thermostat.getNext()) {
            Thermostat.cold => ShowerSession.coldCycle,
            Thermostat.hot => ShowerSession.hotCycle
          };
      } else {
        state = ShowerSession.from(state)..time -= oneSec;
      }
    });
    state = (ShowerSession.from(state)..isRunning = true);
  }

  void stopTimer() {
    if (!_timer.isActive) {
      return;
    }
    _timer.cancel();
    state = (ShowerSession.from(state)..isRunning = false);
  }

  void resetSession() {
    state = build();
  }

  void saveSession({BuildContext? context}) async {
    final savedState = state;
    resetSession();
    if (savedState.cycles <= 0) {
      return;
    }
    final box = await ref.watch(historyBoxProvider.future);
    box.add(savedState.toDbItem());
    if (context != null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Session saved!'),
      ));
    }
    // TODO
  }
}
