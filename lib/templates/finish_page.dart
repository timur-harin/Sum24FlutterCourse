import 'package:education/templates/middleAssignment/providers/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FinishPage extends ConsumerStatefulWidget {
  const FinishPage({Key? key}) : super(key: key);

  @override
  _FinishPageState createState() => _FinishPageState();
}

class _FinishPageState extends ConsumerState<FinishPage> {
  @override
  Widget build(BuildContext context) {
    final workoutState = ref.watch(workoutProvider);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Shower History'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                _showRatingDialog(context);
              },
              child: Text('Back to Main Page'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: workoutState.workouts.length,
                itemBuilder: (context, index) {
                  final workout = workoutState.workouts[index];
                  return ListTile(
                    title: const Text("Showering"),
                    subtitle: Text(
                      'Hot Cycles: ${workout.hotCycles}, Cold Cycles: ${workout.coldCycles}, Total Cycles: ${workout.totalCycles}, Date: ${workout.date}, Elapsed Time: ${workout.actualTime} seconds',
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showRatingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        int selectedRating = 1;

        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Rate Your Experience'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Please rate your experience:'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      return IconButton(
                        icon: Icon(
                          Icons.star,
                          color: selectedRating > index
                              ? Colors.amber
                              : Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            selectedRating = index + 1;
                          });
                        },
                      );
                    }),
                  ),
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
                    Navigator.of(context).pushReplacementNamed('/main');
                  },
                  child: const Text('Confirm'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
