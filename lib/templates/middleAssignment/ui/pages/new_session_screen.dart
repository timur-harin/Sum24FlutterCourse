import 'package:flutter/material.dart';
import 'package:education/templates/middleAssignment/providers/notifier.dart';
import 'package:education/templates/middleAssignment/data/models/shower_history.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewShowerSessionWidget extends ConsumerStatefulWidget {
  const NewShowerSessionWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NewShowerSessionWidgetState();
}

class _NewShowerSessionWidgetState extends ConsumerState<NewShowerSessionWidget> {
  List<TemperaturePhase> phases = [];
  String temperature = 'Hot';
  int duration = 0;

  void addPhase(String temperature, int duration) {
    setState(() {
      phases.add(
          TemperaturePhase(temperature: temperature, duration: duration, id: phases.length + 1));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Shower Session'),
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Column(
        children: [
          TextField(
            onChanged: (value) => setState(() {
              duration = int.parse(value);
            }),
            decoration: const InputDecoration(labelText: 'Duration'),
          ),
          DropdownButton<String>(
            value: temperature,
            items: <String>['Hot', 'Cold'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                temperature = newValue!;
              });
            },
          ),
          ElevatedButton(
            onPressed: () {
              addPhase(temperature, duration);
            },
            child: const Text('Add Phase'),
          ),
          ElevatedButton(
            onPressed: () {
              final _id = ref.read(idProvider);
              ref.read(idProvider.notifier).getId();
              print(_id);
              final session = ShowerSession(
                id: _id,
                date: DateTime.now().toString(),
                temperaturePhases: phases,
              );
              ref.read(showerSessionsProvider.notifier).addSession(session);
              Navigator.pop(context);
            },
            child: const Text('Add Session'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: phases.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(phases[index].temperature),
                  subtitle: Text('${phases[index].duration} seconds'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
