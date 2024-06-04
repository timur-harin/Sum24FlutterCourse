import 'dart:nativewrappers/_internal/vm/lib/internal_patch.dart';
import 'dart:ui_web';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() => runApp(const Lab1());

class Lab1 extends StatelessWidget {
  const Lab1({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LAb1HomePage(),
    );
  }
}

class LAb1HomePage extends StatelessWidget {
  const LAb1HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const Icon(Icons.stars),
        title: const Text('Lab 2'),
        backgroundColor: Colors.teal,
        elevation: 4,
      ),
      body: myWidget(),
    );
  }

  Widget myWidget() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 25,
          ),
          exercise1(),
          const SizedBox(
            height: 25,
          ),
          exercise2(),
          const SizedBox(
            height: 25,
          ),
          exercise3(),
          const SizedBox(
            height: 25,
          ),
          exercise4(),
          const SizedBox(
            height: 25,
          ),
          exercise5(),
        ],
      ),
    );
  }

  Widget exercise1() {
    return const Text("Hello Flutter!"); // Text
    style:
    TextStyle(
        fontSize: 90,
        fontWeight: FontWeight.w400,
        color: Color.fromARGB(255, 10, 175, 197));
  }

  Widget exercise2() {
    return const Icon(
      Icons.abc,
      size: 100,
      color: Color.fromARGB(255, 203, 1, 92),
    );
  }

  Widget exercise3() {
    return const Image(
      image: NetworkImage(
          'https://img.freepik.com/free-photo/human-skeleton-on-a-black-background-isolated_169016-20937.jpg'),
      width: 40,
      height: 100,
    );
  }

  Widget exercise4() {
    return TextButton(
        child: Text('idk'),
        onPressed: () {
          printToConsole("Pressed");
        });
  }

  Widget exercise5() {
    return const FlutterLogo(
      size: 100,
    );
  }
}
