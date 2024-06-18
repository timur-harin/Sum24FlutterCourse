import 'dart:async';

import 'package:education/templates/middleAssignment/HomePage.dart';
import 'package:education/templates/middleAssignment/riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionSummary extends ConsumerWidget {
  static const prevSession1 = 'prevSession1';
  static const prevSession2 = 'prevSession2';
  static const prevSession3 = 'prevSession3';

  int overallTime, repetitions;
  
  SessionSummary({super.key, required this.overallTime, required this.repetitions});

  void setSession() async {
    await _setSession();
  }

  Future _setSession() async {
    var prefs = await SharedPreferences.getInstance();
    '${overallTime ~/ 3600} : ${(overallTime % 3600) ~/ 60} : ${(overallTime % 60)}';
    prefs.setString(prevSession1, '${overallTime ~/ 3600} : ${(overallTime % 3600) ~/ 60} : ${(overallTime % 60)}');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Duration fullTime = Duration(seconds: overallTime);
    return Scaffold(
      appBar: AppBar(
        title: Text('Contrast Shower: Session Summary'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('Full time: ${(fullTime.inHours % 60).toString().padLeft(2, '0')} : ${(fullTime.inMinutes % 60).toString().padLeft(2, '0')} : ${(fullTime.inSeconds % 60).toString().padLeft(2, '0')}'),
            ElevatedButton(
              onPressed: () {
                setSession();
                Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
              },
              child: Text('Go to the main page')),
          ],
          ),
      ),
    );
  }
}