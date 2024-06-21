import 'dart:math';

import 'package:education/templates/middleAssignment/data/boxes.dart';
import 'package:education/templates/middleAssignment/data/session.dart';
import 'package:education/templates/middleAssignment/data/session_settings.dart';
import 'package:education/templates/middleAssignment/main.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class SessionSettingsWidget extends StatefulWidget {
  const SessionSettingsWidget({super.key});

  @override
  State<StatefulWidget> createState() => _SessionSettingsWidgetState();
}

class _SessionSettingsWidgetState extends State<SessionSettingsWidget> {
  final Box _sessionSettingsBox;
  late SessionSettings _sessionSettings;

  _SessionSettingsWidgetState()
      : _sessionSettingsBox = Hive.box(Boxes.sessionSettings) {
    _sessionSettings = SessionSettings.fromJson(_sessionSettingsBox.toMap());
    _sessionSettingsBox.putAll(_sessionSettings.toJson());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(30.0),
          child: SingleChildScrollView(
            child: DefaultTextStyle.merge(
              style: Theme.of(context).textTheme.bodyLarge,
              child: Column(children: [
                Column(children: [
                  const Text('Initial temperature: '),
                  SegmentedButton<Thermostat>(
                    segments: [
                      ButtonSegment(
                        value: Thermostat.hot,
                        label: const Text('Hot'),
                        icon: Icon(
                          Icons.whatshot,
                          color: MiddleAssigmentApp.redScheme.primary,
                        ),
                      ),
                      ButtonSegment(
                        value: Thermostat.cold,
                        label: const Text('Cold'),
                        icon: Icon(
                          Icons.ac_unit,
                          color: MiddleAssigmentApp.blueScheme.primary,
                        ),
                      ),
                    ],
                    selected: {_sessionSettings.initialTemperature},
                    onSelectionChanged: (newSelection) {
                      setState(() {
                        _sessionSettings.initialTemperature =
                            newSelection.first;
                      });
                    },
                  ),
                ]),
                Column(children: [
                  const Text('Max cycles:'),
                  Slider(
                    value: _sessionSettings.maxCycles.clamp(0, 16).toDouble(),
                    min: 0,
                    max: 16,
                    divisions: 16,
                    label: _sessionSettings.maxCycles == 0
                        ? '∞'
                        : _sessionSettings.maxCycles.toInt().toString(),
                    onChanged: (double value) {
                      setState(() {
                        _sessionSettings.maxCycles = value.toInt();
                      });
                    },
                  ),
                ]),
                Column(children: [
                  const Text('Length of hot cycle:'),
                  Slider(
                    value: _sessionSettings.cycleLength[Thermostat.hot]!
                        .clamp(30, 300)
                        .toDouble(),
                    min: 30,
                    max: 300,
                    divisions: 9,
                    label: (_sessionSettings.cycleLength[Thermostat.hot]! / 60)
                        .toString(),
                    onChanged: (double value) {
                      setState(() {
                        _sessionSettings.cycleLength[Thermostat.hot] =
                            value.toInt();
                      });
                    },
                  ),
                ]),
                Column(children: [
                  const Text('Length of cold cycle:'),
                  Slider(
                    value: _sessionSettings.cycleLength[Thermostat.cold]!
                        .clamp(30, 300)
                        .toDouble(),
                    min: 30,
                    max: 300,
                    divisions: 9,
                    label: (_sessionSettings.cycleLength[Thermostat.cold]! / 60)
                        .toString(),
                    onChanged: (double value) {
                      setState(() {
                        _sessionSettings.cycleLength[Thermostat.cold] =
                            value.toInt();
                      });
                    },
                  ),
                ]),
              ]),
            ),
          ),
        ),
        ConstrainedBox(
          constraints: BoxConstraints.tight(const Size(double.infinity, 100.0)),
          child: TextButton(
            style: TextButton.styleFrom(
                shape: const RoundedRectangleBorder(),
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary),
            child: const Text('Save'),
            onPressed: () {
              _sessionSettingsBox.putAll(_sessionSettings.toJson());
              Navigator.of(context).popAndPushNamed('/session');
            },
          ),
        ),
      ],
    );
  }
}
