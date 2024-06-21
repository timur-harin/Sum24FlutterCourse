import 'package:education/templates/middleAssignment/data/boxes.dart';
import 'package:education/templates/middleAssignment/data/session.dart';
import 'package:education/templates/middleAssignment/data/settings.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class SessionSettingsScreen extends StatefulWidget {
  const SessionSettingsScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SessionSettingsScreenState();
}

class _SessionSettingsScreenState extends State<SessionSettingsScreen> {
  late final Box _settingsBox;
  late Settings _settings;

  _SessionSettingsScreenState() {
    _settingsBox = Hive.box(Boxes.settings);
    _settings = Settings.fromJson(_settingsBox.toMap());
    _settingsBox.putAll(_settings.toJson());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuraion'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 75.0),
        child: Column(children: [
          Row(children: [
            const Text('Initial temperature:'),
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
              value: _settings.maxCycles.toDouble(),
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
          ElevatedButton(
            child: const Text('Save'),
            onPressed: () {
              _settingsBox.putAll(_settings.toJson());
              Navigator.of(context).popAndPushNamed('/session');
            },
          ),
        ]),
      ),
    );
  }
}
