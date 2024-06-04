import 'package:flutter/cupertino.dart';
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
    return const Text(
      "Hello, Flutter!",
      style: TextStyle(
        fontSize: 45,
        color: Colors.teal,
        fontWeight: FontWeight.bold,
      )
    );
  }

  Widget exercise2() {
    return const Icon(
      Icons.stars,
      size: 100,
      color: Colors.teal,
    );
  }

  Widget exercise3() {
    return const Image(
      image: NetworkImage('https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
    );
  }

  isPressed() {
    print("pressed");
  }

  Widget exercise4() {
    return TextButton(
      onPressed: isPressed(),
      child: const Text("Click here"),
    );
  }

  Widget exercise5() {
    return Column(
      children: [
        
        Container(child: const Text("This is star!")),
        Container(child: const Icon(Icons.stars)),
      ]
    );
  }
}