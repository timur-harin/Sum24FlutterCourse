import 'package:education/templates/middleAssignment/data/functions.dart';
import 'package:education/templates/middleAssignment/data/workout.dart';
import 'package:education/templates/middleAssignment/providers/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Workout> workouts = [
    Workout(
        name: "Hot",
        duration: 10,
        type: WorkoutType.Hot,
        startTime: DateTime.now()),
    Workout(
        name: "Warm",
        duration: 10,
        type: WorkoutType.Warm,
        startTime: DateTime.now()),
    Workout(
        name: "Cold",
        duration: 10,
        type: WorkoutType.Cold,
        startTime: DateTime.now()),
  ];

  final TextEditingController _controller = TextEditingController();


final showerProvider = Provider.of<ShowerProvider>(
  context
);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              for (Workout workout in workouts)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(workout.name),
                    Padding(padding: EdgeInsets.only(left: 10)),
                    getIcon(workout.type),
                  ],
                )
            ],
          ),
          TextField(
          onChanged: (value) {
            showerProvider.
          },
            controller: _controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Duration",
              hintText: "Enter duration in minutes",
            ),
          ),
          ElevatedButton(
              onPressed: () {

                if (containsOnlyDigits(_controller.text)) {
                  Navigator.of(context).pushNamed("/shower");
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("ОШИБКА"),
                        content: Text("Введите длительность душа"),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('ОК'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          )
                        ],
                      );
                    },
                  );
                }
              },
              child: Icon(Icons.add))
        ],
      )),
    );
  }
}
