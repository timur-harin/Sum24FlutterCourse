import 'package:flutter/material.dart';

void main() => runApp(const Lab1());

class Lab1 extends StatelessWidget {
  const Lab1({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Lab1HomePage(),
    );
  }
}

class Lab1HomePage extends StatelessWidget {
  const Lab1HomePage({super.key});

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
    return const Text(
      "Hello Flutter!",
      style: TextStyle(
          fontSize: 14, color: Colors.amber, fontWeight: FontWeight.bold),
    );
  }

  Widget exercise2() {
    return const Icon(
      Icons.heart_broken,
      color: Colors.deepPurple,
      size: 48, // dp?
    );
  }

  Widget exercise3() {
    return Image.network(
      "https://docs.flutter.dev/assets/images/dash/dash-fainting.gif",
      fit: BoxFit.contain,
      height: 48,
    );
  }

  Widget exercise4() {
    return ElevatedButton.icon(
      onPressed: () {
        print("Pressed");
      },
      label: const Text("Press me!"),
      icon: const Icon(Icons.auto_awesome),
    );
  }

Widget exercise5() {
  return Column(
    children: <Widget>[
      Container(
        padding: const EdgeInsets.all(16),
        color: Colors.deepOrange,
        child: const Text(
          "Flutter is good, I guess...",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      Container(
        padding: const EdgeInsets.all(16),
        color: Colors.deepPurple,
        child: const Icon(
          Icons.sentiment_satisfied,
          color: Colors.white,
        ),
      )
    ],
  );
}
}
