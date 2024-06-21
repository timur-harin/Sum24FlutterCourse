import 'package:flutter/material.dart';
import 'package:education/templates/middleAssignment/providers/notifier.dart';
import 'package:education/templates/middleAssignment/data/models/shower_history.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



class NewShowerSessionWidget extends StatefulWidget {
  const NewShowerSessionWidget({super.key});

  @override
  _NewShowerSessionWidgetState createState() => _NewShowerSessionWidgetState();
}

class _NewShowerSessionWidgetState extends State<NewShowerSessionWidget> {
  List<TemperaturePhase> phases = [];

  void addPhase(String temperature, int duration) {
    setState(() {
      phases.add(TemperaturePhase(temperature: temperature, duration: duration, id: phases.length + 1));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          onChanged: (value) => print(value),
          decoration: const InputDecoration(labelText: 'Duration'),
        ),
        DropdownButton<String>(
          value: 'Hot',
          items: <String>['Hot', 'Cold'].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (newValue) {
            // Handle change
          },
        ),
        ElevatedButton(
          onPressed: () {
            // Add phase logic here
          },
          child: Text('Add Phase'),
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
    );
  }
}
