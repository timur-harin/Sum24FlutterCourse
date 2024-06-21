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

  int overallTime, repetitions, overallHot, overallCold;

  late String first;
  late String second;

  SessionSummary(
      {super.key, required this.overallTime, required this.repetitions, required this.overallHot, required this.overallCold});

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
    prefs.setString(prevSession1,
        '${((overallHot + overallCold) ~/ 3600).toString().padLeft(2, '0')} : ${(((overallHot + overallCold) % 3600) ~/ 60).toString().padLeft(2, '0')} : ${((overallHot + overallCold) % 60)}');
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
    Duration fullTime = Duration(seconds: overallHot + overallCold);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(49, 14, 76, 1),
              Color.fromRGBO(255, 255, 255, 1)
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Summary:",
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Full session time: ${(fullTime.inHours % 60).toString().padLeft(2, '0')} : ${(fullTime.inMinutes % 60).toString().padLeft(2, '0')} : ${(fullTime.inSeconds % 60).toString().padLeft(2, '0')}',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Text(
                'Hot session time: ${(overallHot ~/ 3600).toString().padLeft(2, '0')} : ${((overallHot % 3600) ~/ 60).toString().padLeft(2, '0')} : ${(overallHot % 60).toString().padLeft(2, '0')}',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Text(
                'Cold session time: ${(overallCold ~/ 3600).toString().padLeft(2, '0')} : ${((overallCold % 3600) ~/ 60).toString().padLeft(2, '0')} : ${(overallCold % 60).toString().padLeft(2, '0')}',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(
                height: 80,
              ),
              SizedBox(
                height: 60,
                width: 200,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,

                      backgroundColor: Color.fromRGBO(
                          69, 26, 112, 0.965), // Foreground color (text color)
                      textStyle: TextStyle(
                        fontSize: 16.8,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(98, 37, 159, 0.807),
                      ), // Text style
                      elevation: 7, // Elevation
                    ),
                    onPressed: () {
                      setSession1();
                      setSession2(first);
                      setSession3(second);
                      
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                    },
                    child: Text('Go to the main page')),
              ),
              FutureBuilder<String>(
                future: getSession1(),
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
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
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
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
      ),
    );
  }
}
