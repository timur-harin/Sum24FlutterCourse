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

  ShowerSession(this.time, {required this.cycles, required this.thermostat});
  ShowerSession.from(ShowerSession another)
      : this(another.time,
            cycles: another.cycles, thermostat: another.thermostat);

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
        cycles: 0, thermostat: Thermostat.hot);
  }

  bool runTimer() {
    if (_timer.isActive) {
      return false;
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
    return true;
  }

  bool stopTimer() {
    if (!_timer.isActive) {
      return false;
    }
    _timer.cancel();
    return true;
  }

  bool resetSession() {
    state = build();
    return true;
  }

  Future<bool> saveSession({BuildContext? context}) async {
    if (state.cycles <= 0) {
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Complete at least one session to save it')));
      }
      return false;
    }
    final savedState = ShowerSession.from(state);
    resetSession();
    final box = await ref.watch(historyBoxProvider.future);
    box.add(savedState.toDbItem());
    if (context != null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Session saved!'),
      ));
    }
    return true;
  }
}
