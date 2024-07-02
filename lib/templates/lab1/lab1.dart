import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
      "Hello, Flutter!",
      style: TextStyle(
        fontSize: 30,
        color: Colors.lightBlue,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget exercise2() {
    return const Icon(
      Icons.home,
      size: 100,
      color: Colors.green,
    );
  }

  Widget exercise3() {
    return const Image(
      width: 200,
      height: 200,
      image: NetworkImage('https://http.dog/101.jpg'),
      fit: BoxFit.cover,
    );
  }

  void printPressed() {
    print("User just Pressed Me");
  }

  Widget exercise4() {
    return TextButton(
      style: ButtonStyle( 
        backgroundColor: WidgetStateProperty.all<Color>(Colors.red),
      ),
      onPressed: printPressed,
      child: const Text('I am red , CLICK ON ME!'),
    );
  }

  Widget exercise5() {
    return Column(
      children: [
        Container(
          color: Color.fromARGB(255, 24, 236, 31),
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.all(10),
          child: const Text(
            "This is a Text in a Container!",
            style: TextStyle(color: Colors.white),
          ),
        ),

        Container(
          color: Colors.green,
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.all(10),
          child: const Icon(
            Icons.home,
            size: 50,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
