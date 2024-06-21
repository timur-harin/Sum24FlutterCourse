import 'package:education/templates/middleAssignment/providers/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  double hotCycleDuration = 30.0;
  int hotNumberOfCycles = 5;
  double coldCycleDuration = 30.0;
  int coldNumberOfCycles = 5;

  void _showConfirmationDialog(BuildContext context) {
    final totalHotTime = hotCycleDuration * hotNumberOfCycles;
    final totalColdTime = coldCycleDuration * coldNumberOfCycles;
    final totalTime = totalHotTime + totalColdTime;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Your Session'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Hot Cycles: $hotNumberOfCycles'),
              Text('Cold Cycles: $coldNumberOfCycles'),
              Text('Total Time: ${totalTime.toInt()} seconds'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed(
                  '/workout',
                  arguments: {
                    'hotCycleDuration': hotCycleDuration.toInt(),
                    'hotNumberOfCycles': hotNumberOfCycles,
                    'coldCycleDuration': coldCycleDuration.toInt(),
                    'coldNumberOfCycles': coldNumberOfCycles,
                  },
                );
              },
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final workoutState = ref.watch(workoutProvider);
    final workoutNotifier = ref.read(workoutProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Contrast Shower App'),
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
              children: [],
            ),
            Column(
              children: [
                Text(
                  'Hot Cycle Duration: ${hotCycleDuration.toInt()} seconds',
                  style: TextStyle(fontSize: 18, color: Colors.pinkAccent),
                ),
                Slider(
                  value: hotCycleDuration,
                  min: 1,
                  max: 60,
                  divisions: 59,
                  label: hotCycleDuration.toInt().toString(),
                  onChanged: (double value) {
                    setState(() {
                      hotCycleDuration = value;
                    });
                  },
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  'Number of Hot Cycles: $hotNumberOfCycles',
                  style: TextStyle(fontSize: 18, color: Colors.pinkAccent),
                ),
                SizedBox(
                  height: 150,
                  child: CupertinoPicker(
                    itemExtent: 40,
                    onSelectedItemChanged: (int value) {
                      setState(() {
                        hotNumberOfCycles = value + 1;
                      });
                    },
                    children: List<Widget>.generate(20, (int index) {
                      return Center(
                        child: Text(
                          (index + 1).toString(),
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  'Cold Cycle Duration: ${coldCycleDuration.toInt()} seconds',
                  style: TextStyle(fontSize: 18, color: Colors.pinkAccent),
                ),
                Slider(
                  value: coldCycleDuration,
                  min: 1,
                  max: 60,
                  divisions: 59,
                  label: coldCycleDuration.toInt().toString(),
                  onChanged: (double value) {
                    setState(() {
                      coldCycleDuration = value;
                    });
                  },
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  'Number of Cold Cycles: $coldNumberOfCycles',
                  style: TextStyle(fontSize: 18, color: Colors.pinkAccent),
                ),
                SizedBox(
                  height: 150,
                  child: CupertinoPicker(
                    itemExtent: 40,
                    onSelectedItemChanged: (int value) {
                      setState(() {
                        coldNumberOfCycles = value + 1;
                      });
                    },
                    children: List<Widget>.generate(20, (int index) {
                      return Center(
                        child: Text(
                          (index + 1).toString(),
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                _showConfirmationDialog(context);
              },
              child: const Text('Start Showering'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/session_history');
              },
              child: const Text('View Session History'),
            ),
          ],
        ),
      ),
    );
  }
}
