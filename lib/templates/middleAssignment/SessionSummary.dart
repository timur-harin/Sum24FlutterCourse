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

  late String first;
  late String second;
  
  SessionSummary({super.key, required this.overallTime, required this.repetitions});

  Future<String> getSession1() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getString(prevSession1) ?? 'No previous sessions';
  }

  Future<String> getSession2() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getString(prevSession2) ?? '';
  }

  Future<String> getSession3() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getString(prevSession3) ?? '';
  }

  Future setSession1() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(prevSession1, '${overallTime ~/ 3600} : ${(overallTime % 3600) ~/ 60} : ${(overallTime % 60)}');
  }


  Future setSession2(String value) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(prevSession2, value);
  }

  Future setSession3(String value) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(prevSession3, value);
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
                setSession1();
                setSession2(first);
                setSession3(second);
                Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
              },
              child: Text('Go to the main page')),
              FutureBuilder<String>(
                        future: getSession1(),
                        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else {
                            first = snapshot.data!;
                            return Text('');
                          }
                        },
                      ),
                      FutureBuilder<String>(
                        future: getSession2(),
                        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else {
                            second = snapshot.data!;
                            return Text('');
                          }
                        },
                      ),
          ],
          ),
      ),
    );
  }
}