import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:education/templates/middleAssignment/pages/riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/outlinedButton.dart';

class EndScreen extends ConsumerWidget {
  EndScreen({super.key});

  static const String firstKey = "first";
  static const String secondKey = "second";
  static const String thirdKey = "third";
  static const String sessionKey = "session";

  late String first;
  late String second;
  late String session;

  Future<void> setFirst(String value) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(firstKey, value);
  }

  Future<void> setSecond(String value) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(secondKey, value);
  }

  Future<void> setThird(String value) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(thirdKey, value);
  }

  Future<String> getFirst() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getString(firstKey) ?? "No prev session";
  }

  Future<String> getSecond() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getString(secondKey) ?? "No prev session";
  }

  Future<String> getSession() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getString(sessionKey) ?? "No prev session";
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 36, 36, 36),
      ),
      child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        FutureBuilder<String>(
          future: getFirst(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(); 
            } else {
              first = snapshot.data.toString();
              return Text(''); 
            }
          },
        ),
        FutureBuilder<String>(
          future: getSecond(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(); 
            } else {
              second = snapshot.data.toString();
              return Text(''); 
            }
          },
        ),
        FutureBuilder<String>(
          future: getSession(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(); 
            } else {
              session = snapshot.data.toString();
              return Text(
                'Overview:\n' +
                    'Hot water duration: ' +
                    ref.watch(riverpod_hot).round().toString() +
                    '\n' +
                    'Cold water duration: ' +
                    ref.watch(riverpod_cold).round().toString() +
                    '\n' +
                    'Number of repetitions: ' +
                    (int.parse(session) - ref.watch(riverpod_times)/2).round().toString(),
                style: TextStyle(color: Colors.white, fontSize: 20),
                textAlign: TextAlign.center,
              ); 
            }
          },
        ),
        Container(
          width: 30,
          height: 30,
        ),
        GradientOutlinedButton(
          onPressed: () {
            setSecond(first);
            setThird(second);
            String value = 'Hot water duration: ' +
                ref.watch(riverpod_hot).round().toString() +
                '\n' +
                'Cold water duration: ' +
                ref.watch(riverpod_cold).round().toString() +
                '\n' +
                'Number of repetitions: ' +
                (int.parse(session) - ref.watch(riverpod_times)/2).round().toString();
            setFirst(value);
            Navigator.pushNamed(context, '/');
          },
          child: GradientText(
            text: 'Back to main screen',
            gradient: LinearGradient(
            colors: <Color>[
              Color(0xFFc0000b),
              Color(0xffc8002c),
              Color(0xffca0049),
              Color(0xffc30067),
              Color(0xffb40085),
              Color(0xff9a00a1),
              Color(0xff712aba),
              Color(0xff1241cd),
            ], 
            begin: Alignment.topLeft, 
            end: Alignment.bottomRight,
          ),
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
          gradient: LinearGradient(
            colors: <Color>[
              Color(0xFFc0000b),
              Color(0xffc8002c),
              Color(0xffca0049),
              Color(0xffc30067),
              Color(0xffb40085),
              Color(0xff9a00a1),
              Color(0xff712aba),
              Color(0xff1241cd),
            ], 
            begin: Alignment.topLeft, 
            end: Alignment.bottomRight, 
          ),
        ),
      ])),
    ));
  }
}
