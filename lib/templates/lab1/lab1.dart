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
        title: const Text('Lab 1'),
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
        fontSize: 30,
        color: Color.fromARGB(255, 244, 3, 188),
        fontWeight: FontWeight.w600),
        );
  }

  Widget exercise2() {
    return const Icon(
      Icons.home,
      size: 300,
      color: Color.fromARGB(255, 255, 247, 91),
    );
  }

  Widget exercise3() {
    return const Image(
      width: 100, height: 100, image: NetworkImage('https://http.cat/images/200.jpg'),
    );
  }

  printPressed() {
    print("Pressed");
  }

  Widget exercise4() {
  return TextButton(
    onPressed: printPressed,
    child: const Text(
      'Press me',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        decoration: TextDecoration.underline,
      ),
    ),
  );
}

  Widget exercise5() {
    return Column(
      children: [
        Container(
          color: const Color.fromARGB(255, 177, 220, 255),
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0),
          child: const Text("This is home Icon in Container!"),
        ),
        Container(
          color: Color.fromARGB(255, 255, 144, 188),
          margin: const EdgeInsets.symmetric(horizontal: 100.0, vertical: 20.0),
          child: const Icon(Icons.favorite),
        ),
      ],
    );
  }
}
