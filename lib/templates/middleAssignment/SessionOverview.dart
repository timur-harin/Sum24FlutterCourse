import 'package:education/templates/middleAssignment/HotWater.dart';
import 'package:education/templates/middleAssignment/riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SessionOverview extends ConsumerWidget {

  final int overallTime, repetitions;

  const SessionOverview({super.key, required this.overallTime, required this.repetitions});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contrast Shower: Session Overview'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('Session Overview'),
            Text('Overall time: ${(ref.read(riverpodFullTimer).inHours % 60).toString().padLeft(2, '0')} : ${(ref.read(riverpodFullTimer).inMinutes % 60).toString().padLeft(2, '0')} : ${(ref.read(riverpodFullTimer).inSeconds % 60).toString().padLeft(2, '0')}'),
            Text('Hot shower time: ${(ref.read(riverpodHotTimer).inHours % 60).toString().padLeft(2, '0')} : ${(ref.read(riverpodHotTimer).inMinutes % 60).toString().padLeft(2, '0')} : ${(ref.read(riverpodHotTimer).inSeconds % 60).toString().padLeft(2, '0')}'),
            Text('Cold shower time: ${(ref.read(riverpodColdTimer).inHours % 60).toString().padLeft(2, '0')} : ${(ref.read(riverpodColdTimer).inMinutes % 60).toString().padLeft(2, '0')} : ${(ref.read(riverpodColdTimer).inSeconds % 60).toString().padLeft(2, '0')}'),
            Text('$repetitions repetitions'),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => HotWater(overallTime: overallTime, repetitions: repetitions)));
              }, 
              child: Text('Start new session',),
            ),
            
            ElevatedButton(
              onPressed: () {

                Navigator.pop(context);
              }, 
              child: Text('Change preferences',),
            ),
          ],
        ),
      ),
    );
  }
}