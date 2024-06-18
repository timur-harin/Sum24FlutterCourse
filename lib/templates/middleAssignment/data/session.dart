import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Thermostat {
  hot,
  cold;

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
  static const String historyTableName = 'history';
  static const Duration hotCycle = Duration(minutes: 3);
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

  Map<String, Object?> toDbItem() {
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

  late Timer _timer;

  @override
  ShowerSession build() {
    _timer = Timer(Duration.zero, () {})..cancel();
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
    // TODO
  }
}
