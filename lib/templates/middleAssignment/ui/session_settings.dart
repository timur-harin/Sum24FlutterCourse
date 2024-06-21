import 'package:education/templates/middleAssignment/data/boxes.dart';
import 'package:education/templates/middleAssignment/data/session.dart';
import 'package:education/templates/middleAssignment/data/session_settings.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class SessionSettingsWidget extends StatefulWidget {
  const SessionSettingsWidget({super.key});

  @override
  State<StatefulWidget> createState() => _SessionSettingsWidgetState();
}

class _SessionSettingsWidgetState extends State<SessionSettingsWidget> {
  late final Box _sessionSettingsBox;
  late SessionSettings _sessionSettings;

  _SessionSettingsWidgetState() {
    _sessionSettingsBox = Hive.box(Boxes.sessionSettings);
    _sessionSettings = SessionSettings.fromJson(_sessionSettingsBox.toMap());
    _sessionSettingsBox.putAll(_sessionSettings.toJson());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: SingleChildScrollView(
              child: Column(children: [
                Row(children: [
                  const Text('Initial temperature: '),
                  SegmentedButton<Thermostat>(
                    segments: const [
                      ButtonSegment(
                        value: Thermostat.hot,
                        label: Text('Hot'),
                        icon: Icon(Icons.whatshot),
                      ),
                      ButtonSegment(
                        value: Thermostat.cold,
                        label: Text('Cold'),
                        icon: Icon(Icons.ac_unit),
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
                    value: _sessionSettings.hotCycle.clamp(30, 300).toDouble(),
                    min: 30,
                    max: 300,
                    divisions: 9,
                    label: (_sessionSettings.hotCycle / 60).toString(),
                    onChanged: (double value) {
                      setState(() {
                        _sessionSettings.hotCycle = value.toInt();
                      });
                    },
                  ),
                ]),
                Column(children: [
                  const Text('Length of cold cycle:'),
                  Slider(
                    value: _sessionSettings.coldCycle.clamp(30, 300).toDouble(),
                    min: 30,
                    max: 300,
                    divisions: 9,
                    label: (_sessionSettings.coldCycle / 60).toString(),
                    onChanged: (double value) {
                      setState(() {
                        _sessionSettings.coldCycle = value.toInt();
                      });
                    },
                  ),
                ]),
              ]),
            ),
          ),
          ElevatedButton(
            child: const Text('Save'),
            onPressed: () {
              _sessionSettingsBox.putAll(_sessionSettings.toJson());
              Navigator.of(context).popAndPushNamed('/session');
            },
          ),
        ],
      ),
    );
  }
}
