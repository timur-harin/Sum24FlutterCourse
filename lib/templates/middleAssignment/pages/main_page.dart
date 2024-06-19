import 'package:flutter/material.dart';
import '../data/session.dart';
import '../providers/provider.dart';
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

  IconData getIcon(SessionType type) {
    switch (type) {
      case SessionType.Finished:
        return Icons.thermostat;
      case SessionType.Stopped:
        return Icons.fitness_center;
    }
  }

  @override
  Widget build(BuildContext context) {
    final sessionProvider = Provider.of<SessionProvider>(context);


    return Scaffold(
      appBar: AppBar(
        title: const Text('Contrast Shower'),
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
                for (Session session in sessionProvider.sessions)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(session.temperature.toString(), style: const TextStyle(fontSize: 20)),
                      Icon(getIcon(session.type)),
                      Text(session.endTime.toString())
                    ],
                  ),
              ],
            ),
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter session duration of cycle',
              ),
              keyboardType: TextInputType.number,
              controller: controller,
            ),
            ElevatedButton(
              onPressed: () {
                sessionProvider.number = int.parse(controller.text);
                Navigator.of(context).pushNamed('/session');
              },
              child: Text('Start Workout'),
            )
          ])),
    );
  }
}
