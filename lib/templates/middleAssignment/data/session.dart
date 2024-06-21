import 'dart:async';

import 'package:education/templates/middleAssignment/data/boxes.dart';
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
  Thermostat thermostat;
  int cycles;

  ShowerSession(this.time, {this.cycles = 0, required this.thermostat});
  ShowerSession.from(ShowerSession another)
      : this(
          another.time,
          cycles: another.cycles,
          thermostat: another.thermostat,
        );

  Map toDbItem() => {
        'timestamp': DateTime.now().toUtc(),
        'cycles': cycles,
        'last_temp': thermostat.toString(),
      };

  void incrementCycle() {
    ++cycles;
    thermostat = thermostat.getNext();
  }
}

class ShowerSessionManager extends AutoDisposeNotifier<ShowerSession> {
  static final provider =
      AutoDisposeNotifierProvider<ShowerSessionManager, ShowerSession>(
    () => ShowerSessionManager(),
  );

  late final Box _sessionSettingsBox;
  late final Box<Map> _historyBox;
  late SessionSettings _sessionSettings;
  late Timer _timer = Timer(Duration.zero, () {});

  ShowerSessionManager() {
    _sessionSettingsBox = Hive.box(Boxes.sessionSettings);
    _historyBox = Hive.box(Boxes.history);
  }

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
      if (state.time == Duration.zero) {
        state = ShowerSession.from(state)
          ..incrementCycle()
          ..time = Duration(
              seconds:
                  _sessionSettings.cycleLength[state.thermostat.getNext()]!);
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
        ScaffoldMessenger.of(context)
          ..removeCurrentSnackBar()
          ..showSnackBar(const SnackBar(
            content: Text('Complete at least one session to save it'),
          ));
      }
      return false;
    }
    final savedState = ShowerSession.from(state);
    resetSession();
    _historyBox.add(savedState.toDbItem());
    if (context != null) {
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(const SnackBar(
          content: Text('Session saved!'),
        ));
    }
    return true;
  }
}
