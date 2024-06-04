import 'package:flutter/material.dart';

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
        title: const Text('Lab 1'),
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
    return const Text("Hello Flutter!",
        style: TextStyle(
            fontSize: 30, color: Colors.teal, fontWeight: FontWeight.bold));
  }

  Widget exercise2() {
    return const Icon(
      Icons.storm_sharp,
      size: 100,
      color: Colors.teal,
    );
  }

  Widget exercise3() {
    return Image.network(
      'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif',
      width: 200,
      height: 200,
      fit: BoxFit.contain,
    );
  }

  Widget exercise4() {
    return TextButton(
      onPressed: () {
        // ignore: avoid_print
        print("Pressed");
      },
      style:
          TextButton.styleFrom(backgroundColor: Colors.teal),
      child: const Text(
        "Press on me to me!",
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget exercise5() {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.teal, width: 5),
              color: Colors.teal),
          child: const Text("Hello, I am container 1"),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          padding: const EdgeInsets.only(top: 10, left: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.teal, width: 5),
          ),
          child: const Icon(Icons.anchor),
        ),
      ],
    );
  }
}
