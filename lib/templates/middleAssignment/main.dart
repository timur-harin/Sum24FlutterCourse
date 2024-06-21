import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => WorkoutProvider())],
      child: const MiddleAssigmentApp(),
    ),
  );
}

class MiddleAssigmentApp extends StatelessWidget {
  const MiddleAssigmentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Middle Assigment',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/settings': (context) => const MainPage(),
        '/workout': (context) => const WorkoutPage(),
        '/finish': (context) => const FinishPage(),
      },
      home: null,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final workoutProvider = Provider.of<WorkoutProvider>(context);
    return Scaffold(
      body: Center(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
            Container(
                width: 600,
                height: 400,
                child: ListView.builder(
                  itemCount: workoutProvider.workouts.length,
                  itemBuilder: (context, index) {
                    final workout = workoutProvider.workouts[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.black,
                          width: 2,
                        ),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Date: ${workout.endTime.toString()}',
                                  // 'Date: ${workout.date}',
                                  style: const TextStyle(fontSize: 16),
                                ),
                                Text(
                                  'Amount of cycles: ${workout.cycles}',
                                  // 'Amount of cycles: ${workout.cycles}',
                                  style: const TextStyle(fontSize: 16),
                                ),
                                Text(
                                  'Hot water time: ${workout.hot}',
                                  // 'Hot water time: ${workout.hotWaterTime}',
                                  style: const TextStyle(fontSize: 16),
                                ),
                                Text(
                                  'Cold water time: ${workout.cold}',
                                  // 'Cold water time: ${workout.coldWaterTime}',
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                )),
            // Expanded(
            //   child: Container(),
            // ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(bottom: 100),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/settings');
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
                    textStyle: TextStyle(fontSize: 24),
                  ),
                  child: Text('New Shower'),
                ),
              ),
            ),
          ])),
    );
  }
}

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

  final TextEditingController controllerCycles = TextEditingController();
  final TextEditingController controllerHot = TextEditingController();
  final TextEditingController controllerCold = TextEditingController();

  IconData getIcon(WorkoutType type) {
    switch (type) {
      case WorkoutType.WarmUp:
        return Icons.thermostat;
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
            Container(
              width: 600,
              height: 400,
              child: Column(children: [
                Text('Write settings for contrast shower',
                    style: TextStyle(fontSize: 24)),
                SizedBox(height: 30),
                TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter amount of cycle',
                  ),
                  keyboardType: TextInputType.number,
                  controller: controllerCycles,
                ),
                SizedBox(height: 10),
                TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter hot water duration per cycle',
                  ),
                  keyboardType: TextInputType.number,
                  controller: controllerHot,
                ),
                SizedBox(height: 10),
                TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter cold water duration per cycle',
                  ),
                  keyboardType: TextInputType.number,
                  controller: controllerCold,
                ),
              ]),
            ),
            ElevatedButton(
              onPressed: () {
                workoutProvider.cycles = int.parse(controllerCycles.text);
                workoutProvider.hot = int.parse(controllerHot.text);
                workoutProvider.cold = int.parse(controllerCold.text);
                Navigator.of(context).pushNamed('/workout');
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
                textStyle: TextStyle(fontSize: 24),
              ),
              child: Text('Start Workout'),
            )
          ])),
    );
  }
}

class FinishPage extends StatefulWidget {
  const FinishPage({super.key});

  @override
  State<FinishPage> createState() => _FinishPageState();
}

class _FinishPageState extends State<FinishPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: ElevatedButton(
      onPressed: () {
        Navigator.of(context).pushNamed('/');
      },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
        textStyle: TextStyle(fontSize: 24),
      ),
      child: Text('Start Over'),
    )));
  }
}

class WorkoutProvider extends ChangeNotifier {
  int _cycles = 0;
  int get cycles => _cycles;
  int _hot = 0;
  int get hot => _hot;
  int _cold = 0;
  int get cold => _cold;
  set cycles(int value) {
    _cycles = value;
    notifyListeners();
  }

  set hot(int value) {
    _hot = value;
    notifyListeners();
  }

  set cold(int value) {
    _cold = value;
    notifyListeners();
  }

  List<Workout> _workouts = [];
  List<Workout> get workouts => _workouts;
  void addWorkout(Workout workout) {
    _workouts.add(workout);
    notifyListeners();
  }
}

class WorkoutPage extends StatefulWidget {
  const WorkoutPage({super.key});

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  String currentState = '';

  int number_cycles = 0;
  int current = 0;
  bool is_end = false;
  int time_left = 0;

  DateTime start = DateTime.now();
  late Timer _timer;

  void startTimer(int numberCycles, int hot, int cold) {
    if (currentState == '') {
      currentState = 'hot';
    }
    time_left = (currentState == 'hot' ? hot : cold);
    final cycles = numberCycles;
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (current != number_cycles) {
          if (time_left != 0) {
            setState(() {
              time_left--;
            });
          } else {
            if (currentState == 'hot') {
              currentState = 'cold';
              setState(() {
                timer.cancel();
              });
              startTimer(cycles, hot, cold);
            } else {
              currentState = 'hot';
              setState(() {
                timer.cancel();
              });
              current++;
              startTimer(cycles - 1, hot, cold);
            }
          }
        } else {
          setState(() {
            timer.cancel();
          });
          time_left = 0;
          is_end = true;
          currentState = '';
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final workoutProvider = Provider.of<WorkoutProvider>(context);
    final cycles = workoutProvider.cycles;
    final hot = workoutProvider.hot;
    final cold = workoutProvider.cold;
    number_cycles = workoutProvider.cycles;

    return Scaffold(
      body: Container(
        color: currentState == 'hot' ? Colors.red : currentState == 'cold' ? Colors.lightBlue : Colors.white,
        child: Center(
        child:Column(children: [
          SizedBox(height: 250),
          ElevatedButton(
              onPressed: () {
                start = DateTime.now();
                startTimer(number_cycles, hot, cold);
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
                textStyle: TextStyle(fontSize: 24),
              ),
              child: const Text('Start')
          ),
          SizedBox(height: 20),
          Text('Time: $time_left ', style: TextStyle(fontSize: 24)),
          SizedBox(height: 20),
          Text('Cycles: $current / $number_cycles', style: TextStyle(fontSize: 24)),
          SizedBox(height: 20),
          Text('Current state: ${currentState == 'hot' ? "Hot water" : currentState == 'cold' ? "Cold water" : "No water"}', style: TextStyle(fontSize: 24)),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              workoutProvider.addWorkout(Workout(
                workoutProvider.cycles.toString(),
                workoutProvider.hot.toString(),
                workoutProvider.cold.toString(),
                start,
                endTime: start.add(Duration(seconds: (hot+cold)*cycles)),
              ));
              Navigator.of(context).pushNamed('/finish');
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
              textStyle: TextStyle(fontSize: 24),
            ),
            child: const Text('Finish'),
          )
        
      ]
      ),
    
      )
      
      )
      
    );
  }
}

class Workout {
  final String cycles;
  final String hot;
  final String cold;
  final DateTime startTime;
  final DateTime? endTime;

  Workout(this.cycles, this.hot, this.cold, this.startTime, {this.endTime});
}

enum WorkoutType { WarmUp, CoolDown }

Future<void> saveHistory(String data) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> history = prefs.getStringList('history') ?? [];
  history.add(data);
  await prefs.setStringList('history', history);
}

Future<List<String>> getHistory() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> history = prefs.getStringList('history') ?? [];
  return history;
}