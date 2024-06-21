import 'package:education/templates/middleAssignment/data/boxes.dart';
import 'package:education/templates/middleAssignment/data/session.dart';
import 'package:education/templates/middleAssignment/data/settings.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class SessionSettings extends StatefulWidget {
  const SessionSettings({super.key});

  @override
  State<StatefulWidget> createState() => _SessionSettingsState();
}

class _SessionSettingsState extends State<SessionSettings> {
  late final Box _settingsBox;
  late Settings _settings;

  _SessionSettingsState() {
    _settingsBox = Hive.box(Boxes.sessionSettings);
    _settings = Settings.fromJson(_settingsBox.toMap());
    _settingsBox.putAll(_settings.toJson());
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
                    selected: {_settings.initialTemperature},
                    onSelectionChanged: (newSelection) {
                      setState(() {
                        _settings.initialTemperature = newSelection.first;
                      });
                    },
                  ),
                ]),
                Column(children: [
                  const Text('Max cycles:'),
                  Slider(
                    value: _settings.maxCycles.clamp(0, 16).toDouble(),
                    min: 0,
                    max: 16,
                    divisions: 16,
                    label: _settings.maxCycles == 0
                        ? '∞'
                        : _settings.maxCycles.toInt().toString(),
                    onChanged: (double value) {
                      setState(() {
                        _settings.maxCycles = value.toInt();
                      });
                    },
                  ),
                ]),
                Column(children: [
                  const Text('Length of hot cycle:'),
                  Slider(
                    value: _settings.hotCycle.clamp(30, 300).toDouble(),
                    min: 30,
                    max: 300,
                    divisions: 9,
                    label: (_settings.hotCycle / 60).toString(),
                    onChanged: (double value) {
                      setState(() {
                        _settings.hotCycle = value.toInt();
                      });
                    },
                  ),
                ]),
                Column(children: [
                  const Text('Length of cold cycle:'),
                  Slider(
                    value: _settings.coldCycle.clamp(30, 300).toDouble(),
                    min: 30,
                    max: 300,
                    divisions: 9,
                    label: (_settings.coldCycle / 60).toString(),
                    onChanged: (double value) {
                      setState(() {
                        _settings.coldCycle = value.toInt();
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
              _settingsBox.putAll(_settings.toJson());
              Navigator.of(context).popAndPushNamed('/session');
            },
          ),
        ],
      ),
    );
  }
}
