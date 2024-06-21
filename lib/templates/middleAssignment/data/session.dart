import 'dart:async';

import 'package:education/templates/middleAssignment/data/boxes.dart';
import 'package:education/templates/middleAssignment/data/history.dart';
import 'package:education/templates/middleAssignment/data/session_settings.dart';
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
  Duration time;
  Duration totalTime;
  Thermostat thermostat;
  int cycles;
  bool finished;
  DateTime? timestamp;

  ShowerSession(
    this.time, {
    required this.thermostat,
    this.cycles = 0,
    this.finished = false,
    this.totalTime = Duration.zero,
  });
  ShowerSession.from(ShowerSession another)
      : this(
          another.time,
          cycles: another.cycles,
          thermostat: another.thermostat,
          finished: another.finished,
          totalTime: another.totalTime,
        );
}

class ShowerSessionManager extends AutoDisposeNotifier<ShowerSession> {
  static final provider =
      AutoDisposeNotifierProvider<ShowerSessionManager, ShowerSession>(
    () => ShowerSessionManager(),
  );

  final Box _sessionSettingsBox;
  final Box<Map> _historyBox;
  late SessionSettings _sessionSettings;
  late Timer _timer = Timer(Duration.zero, () {});

  ShowerSessionManager()
      : _sessionSettingsBox = Hive.box(Boxes.sessionSettings),
        _historyBox = Hive.box(Boxes.history);

  @override
  ShowerSession build() {
    _timer.cancel();
    ref.onCancel(
      () {
        _timer.cancel();
      },
    );
    _sessionSettings = SessionSettings.fromJson(_sessionSettingsBox.toMap());
    return ShowerSession(
        Duration(
          seconds: _sessionSettings
              .cycleLength[_sessionSettings.initialTemperature]!,
        ),
        thermostat: _sessionSettings.initialTemperature);
  }

  bool runTimer() {
    if (_timer.isActive) {
      return false;
    }
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (timer) {
      if (state.time != Duration.zero) {
        state = ShowerSession.from(state)
          ..time -= oneSec
          ..totalTime += oneSec;
        return;
      }
      var newCycle = ShowerSession.from(state)..cycles += 1;
      if (_sessionSettings.maxCycles != 0 &&
          newCycle.cycles == _sessionSettings.maxCycles) {
        state = newCycle..finished = true;
        timer.cancel();
        return;
      }
      state = newCycle
        ..thermostat = newCycle.thermostat.getNext()
        ..time = Duration(
            seconds: _sessionSettings.cycleLength[newCycle.thermostat]!);
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

  bool saveSession() {
    if (state.cycles <= 0) {
      return false;
    }
    final savedState = ShowerSession.from(state);
    resetSession();
    _historyBox.add(HistoryItem.toDbItem(savedState));
    return true;
  }
}
