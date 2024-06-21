import 'package:education/templates/middleAssignment/sessionScreen.dart';
import 'package:flutter/material.dart';

class OverviewScreen extends StatelessWidget {
  final double warmWaterSeconds;
  final double coldWaterSeconds;
  final double repeatCycles;

  OverviewScreen({
    required this.warmWaterSeconds,
    required this.coldWaterSeconds,
    required this.repeatCycles,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.green),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Text('Warm: ${(warmWaterSeconds / 60).floor().toStringAsFixed(0)} min ${(warmWaterSeconds % 60).toStringAsFixed(0)} sec'),
                  Text('Cold: ${coldWaterSeconds.toStringAsFixed(0)} seconds'),
                  Text('Cycles: ${repeatCycles.toStringAsFixed(0)} time(s)'),
                  Text('Overall (with phase switches): ${((warmWaterSeconds+coldWaterSeconds+7)*repeatCycles/ 60).floor().toStringAsFixed(0)} min ${((warmWaterSeconds+coldWaterSeconds+7)*repeatCycles % 60).toStringAsFixed(0)} sec'),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SessionScreen(
                      warmWaterSeconds: warmWaterSeconds,
                      coldWaterSeconds: coldWaterSeconds,
                      repeatCycles: repeatCycles,
                    ),
                  ),
                );
              },
              child: Text('Select'),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.green, // Text color
                side: BorderSide(color: Colors.green), // Border color
              ),
            ),
          ],
        ),
      ),
    );
  }
}
