import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainScreen extends StatelessWidget {
  static const String firstKey = "first";
  static const String secondKey = "second";
  static const String thirdKey = "third";

  String sesF = '';
  String sesS = '';
  String sesT = '';

  MainScreen({super.key});

  Future<String> getFirst() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getString(firstKey) ?? "No prev session";
  }

  Future<String> getSecond() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getString(secondKey) ?? "No prev session";
  }

  Future<String> getThird() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getString(thirdKey) ?? "No prev session";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
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
      )),
      child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        FutureBuilder<String>(
          future: getFirst(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text('');
            } else {
              sesF = snapshot.data ?? "";
              return Text('');
            }
          },
        ),
        FutureBuilder<String>(
          future: getSecond(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text('');
            } else {
              sesS = snapshot.data ?? "";
              return Text('');
            }
          },
        ),
        FutureBuilder<String>(
          future: getThird(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text('');
            } else {
              sesT = snapshot.data ?? "";
              return Text('');
            }
          },
        ),
        OutlinedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/settings');
          },
          child: const Text(
            'Start New Session',
            style: TextStyle(color: Colors.white, fontSize: 30),
          ),
          style: ButtonStyle(
              side: MaterialStateProperty.all(
                  BorderSide(color: Colors.white, width: 3)),
              minimumSize: MaterialStateProperty.all(Size(50, 80))),
        ),
        Container(
          height: 30,
        ),
        OutlinedButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      title: Text("Previous sessions: ",
                          style: TextStyle(color: Colors.white)),
                      content: Text(
                        "First: $sesF\n\nSecond: $sesS\n\nThird: $sesT",
                        style: TextStyle(color: Colors.white),
                      ),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("OK",
                                style: TextStyle(color: Colors.white)))
                      ],
                      backgroundColor: Color.fromARGB(255, 36, 36, 36),
                    ));
          },
          child: const Text(
            'Previous Sessions',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          style: ButtonStyle(
              side: MaterialStateProperty.all(
                  BorderSide(color: Colors.white, width: 2)),
              minimumSize: MaterialStateProperty.all(Size(50, 60))),
        ),
      ])),
    ));
  }
}
