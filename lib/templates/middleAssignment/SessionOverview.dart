import 'package:education/templates/middleAssignment/riverpod.dart';
import 'package:education/templates/middleAssignment/timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SessionOverview extends ConsumerWidget {
  final int overallTime, repetitions;

  const SessionOverview(
      {super.key, required this.overallTime, required this.repetitions});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromRGBO(142, 63, 221, 0.965),
            Color.fromRGBO(255, 255, 255, 1)
          ],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              textAlign: TextAlign.center,
              'Overall time for shower:\n ${(ref.read(riverpodFullTimer).inHours % 60).toString().padLeft(2, '0')} : ${(ref.read(riverpodFullTimer).inMinutes % 60).toString().padLeft(2, '0')} : ${(ref.read(riverpodFullTimer).inSeconds % 60).toString().padLeft(2, '0')}',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 244, 244, 244),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Hot shower time: ${(ref.read(riverpodHotTimer).inHours % 60).toString().padLeft(2, '0')} : ${(ref.read(riverpodHotTimer).inMinutes % 60).toString().padLeft(2, '0')} : ${(ref.read(riverpodHotTimer).inSeconds % 60).toString().padLeft(2, '0')}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 244, 244, 244),
              ),
            ),
            Text(
              'Cold shower time: ${(ref.read(riverpodColdTimer).inHours % 60).toString().padLeft(2, '0')} : ${(ref.read(riverpodColdTimer).inMinutes % 60).toString().padLeft(2, '0')} : ${(ref.read(riverpodColdTimer).inSeconds % 60).toString().padLeft(2, '0')}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 244, 244, 244),
              ),
            ),
            Text(
              '$repetitions cycle(-s)',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 244, 244, 244),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 50,
              width: 190,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Color.fromRGBO(142, 63, 221, 0.965),

                  backgroundColor:
                      Colors.white, // Foreground color (text color)
                  textStyle: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(142, 63, 221, 0.965),
                  ), // Text style
                  elevation: 6, // Elevation
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TimerScreen(
                        overallTime: overallTime,
                        repetitions: repetitions,
                        hotTime: ref.read(riverpodHotTimer),
                        coldTime: ref.read(riverpodColdTimer),
                      ),
                    ),
                  );
                },
                child: Text(
                  'Start Session',
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 50,
              width: 150,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color.fromRGBO(
                      142, 63, 221, 0.965), // Foreground color (text color)
                  textStyle: TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold), // Text style
                  elevation: 5, // Elevation
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Change time',
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
