import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

import 'main.dart';
import 'screen.dart';
import 'data.dart';
import 'providers.dart';

enum Water { hot, cold }

const uuid = Uuid();

class SessionScreen extends ConsumerStatefulWidget {
  const SessionScreen({super.key});

  @override
  ConsumerState<SessionScreen> createState() => _SessionScreenState();
}

class _SessionScreenState extends ConsumerState<SessionScreen> {
  late Timer _timer;
  int timeLeft = 0;
  bool isRunning = false;
  int cyclesLeft = 0;
  int cyclesPassed = 0;
  Water currentWater = Water.hot;

  DateTime startTime = DateTime.now();
  late DateTime endTime;

  @override
  void initState() {
    super.initState();
    cyclesLeft = ref.read(cyclesProvider).toInt();
    timeLeft = ref.read(intervalProvider).toInt();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    setState(() {
      currentWater = Water.hot;
      isRunning = true;
    });
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (!isRunning) return;
        if (timeLeft > 0) {
          setState(() {
            timeLeft--;
          });
        } else { // timeLeft == 0
          if (cyclesLeft >= 1 && currentWater == Water.hot) {
            setState(() {
              currentWater = Water.cold;
              timeLeft = ref.read(intervalProvider).toInt();
            });
          } else if (cyclesLeft > 1 && currentWater == Water.cold) {
            setState(() {
              cyclesLeft--;
              cyclesPassed++;
              currentWater = Water.hot;
              timeLeft = ref.read(intervalProvider).toInt();
            });
          } else {
            _timer.cancel();
            setState(() {
              cyclesLeft--;
              cyclesPassed++;
              isRunning = false;
            });
          }
        }
      },
    );
  }

  void pauseTimer() {
    setState(() {
      isRunning = false;
      endTime = DateTime.now();
    });
  }

  void unpauseTimer() {
    setState(() {
      isRunning = true;
    });
    if (!_timer.isActive) {
      setState(() {
        timeLeft = ref.read(intervalProvider).toInt();
      });
      _startTimer();
    }
  }

  void cancelTimer() {
    _timer.cancel();
    setState(() {
      endTime = DateTime.now();
      isRunning = false;
    });
  }

  void addCycle() {
    setState(() {
      cyclesLeft++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: currentWater == Water.hot ? Colors.red[100] : Colors.blue[100],
      appBar: AppBar(
        title: const Text(
          'Session',
          style: TextStyle(color: Colors.white),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: currentWater == Water.hot ? Colors.red[400] : Colors.cyan[400],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$timeLeft',
              style: TextStyle(
                fontSize: 300,
                color: currentWater == Water.hot ? Colors.red : Colors.cyan,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Temperature: ',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.blueGrey,
                  ),
                ),
                currentWater == Water.hot ? 
                const Icon(
                  Icons.local_fire_department, 
                  size: 40,
                  color: Colors.red,
                ) 
                : const  Icon(
                  Icons.ac_unit, 
                  size: 40,
                  color: Colors.blue,
                ),
                const SizedBox(width: 30),
                Text(
                'Cycles: $cyclesPassed / $cyclesLeft',
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.blueGrey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.add,
                    color: Colors.blueGrey[800],
                    size: 60,
                  ),
                  tooltip: 'Add Cycle',
                  onPressed: addCycle,
                ),
                IconButton(
                  icon: Icon(
                    isRunning ? Icons.pause : Icons.play_arrow,
                    color: Colors.blueGrey[800],
                    size: 60,
                  ),
                  tooltip: isRunning ? 'Pause' : 'Unpause',
                  onPressed: isRunning ? pauseTimer : unpauseTimer,
                ),
                isRunning ? const SizedBox(width: 75) : IconButton(
                  icon: Icon(
                    Icons.save,
                    color: Colors.blueGrey[800],
                    size: 60,
                  ),
                  tooltip: 'Save',
                  onPressed: () {
                    cancelTimer();
                    Box<Session> box = Hive.box<Session>(sessionBoxName);
                    String id = uuid.v4();
                    box.put(id, Session(startTime, endTime, cyclesPassed));
                    _showDialog(context, id);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> _showDialog(BuildContext context, String id) async {
  int r = 0;

  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return SimpleDialog(
        title: Text('Rate your session!', style: TextStyle(color: Colors.blueGrey[800])),
        children: [
          Center(
            child: RatingBar.builder(
              initialRating: 0,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: false,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
              Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                r = rating.toInt();
              },
            ),
          ),
          SimpleDialogOption(
            child: const Align(
              alignment: Alignment.centerRight,
              child: Text('Save', style: TextStyle(color: Colors.blueGrey)),
            ),
            onPressed: () {
              Box<Session> box = Hive.box<Session>(sessionBoxName);
              box.get(id)!.setRating(r);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            },
          ),
        ],
      );
    },
  );
}