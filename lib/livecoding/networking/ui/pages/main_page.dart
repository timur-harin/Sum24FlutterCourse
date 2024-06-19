import 'package:education/livecoding/networking/data/workout.dart';
import 'package:education/livecoding/networking/providers/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // final List<Workout> workouts = [
  //   Workout('Warm Up', WorkoutType.WarmUp, DateTime.now()),
  //   Workout('Exercise', WorkoutType.Exercise, DateTime.now()),
  //   Workout('Cool Down', WorkoutType.CoolDown, DateTime.now()),
  // ];

  final TextEditingController controller = TextEditingController();

  IconData getIcon(WorkoutType type) {
    switch (type) {
      case WorkoutType.WarmUp:
        return Icons.thermostat;
      case WorkoutType.Exercise:
        return Icons.fitness_center;
      case WorkoutType.CoolDown:
        return Icons.thermostat;
    }
  }

  @override
  Widget build(BuildContext context) {
    final workoutProvider = Provider.of<WorkoutProvider>(context);


    return Scaffold(
      appBar: AppBar(
        title: const Text('Workout App'),
      ),
      body: Center(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                for (Workout workout in workoutProvider.workouts)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(workout.name, style: const TextStyle(fontSize: 20)),
                      Icon(getIcon(workout.type)),
                      Text(workout.endTime.toString())
                    ],
                  ),
              ],
            ),
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter workout duration of cycle',
              ),
              keyboardType: TextInputType.number,
              controller: controller,
            ),
            ElevatedButton(
              onPressed: () {
                workoutProvider.number = int.parse(controller.text);
                Navigator.of(context).pushNamed('/workout');
              },
              child: Text('Start Workout'),
            )
          ])),
    );
  }
}
