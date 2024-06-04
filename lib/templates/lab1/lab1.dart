import 'package:flutter/cupertino.dart';
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
      "Hello Flutter",
      style: TextStyle(
      color: Colors.amberAccent,
      fontSize: 30,
      fontWeight: FontWeight.bold
    ),
    );
  }

  Widget exercise2() {
    return const Icon(
      Icons.holiday_village,
      color: Colors.cyan,
      size: 10,
    );
  }

  Widget exercise3() {
    return const Image(
      image:NetworkImage("https://static.tildacdn.com/tild6461-3737-4462-b836-383331623161/photo.jpg"),
      fit: BoxFit.cover,
    );
  }

  Widget exercise4() {
    return const TextButton(
        onPressed: buttonPressedPrint,
        child: Text("Btn")
    );
  }

  Widget exercise5() {
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(8.0),
          margin: const EdgeInsets.symmetric(),
          child: const Text("EX 5", style: TextStyle(color: Colors.deepOrange, fontSize: 30))
        ),
        Container(
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.symmetric(),
            child: const Icon(Icons.ice_skating, color: Colors.purpleAccent)
        ),
      ],
    );
  }
}

void buttonPressedPrint() {
  print("Pressed");
}