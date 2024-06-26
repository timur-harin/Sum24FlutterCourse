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
    return const Text(
      "Hello, Flutter!",
      style: TextStyle(
        fontSize: 30,
        color: Colors.lightBlue,
        fontWeight: FontWeight.bold),
        );
  }

  Widget exercise2() {
    return const Icon(
      Icons.favorite,
      size: 100,
      color: Colors.red,
    );
  }

  Widget exercise3() {
    return const Image(
      image: NetworkImage(
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRqJxPznJUf7ginHrFwVaxHPJ4TXxaeepJu6A&s"),
      width: 750,
      height: 925,
      fit: BoxFit.cover,
    );
  }

  printPressed() {
    print("Pressed");
  }

  Widget exercise4() {
    return TextButton(
      onPressed: onPressedButtonOne,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.pink
      ),
      child: textForButton(),
    );
  }

  void onPressedButtonOne() {
    print("Why do you press buttons, are you what, a button presser???");
  }

  Widget textForButton() {
    return const Text(
      "Press me",
      style: TextStyle(
        color: Colors.yellow,
        fontSize: 30,
      ),
    );
  }

  Widget exercise5() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.cyan,
              width: 3
            )
          ),
          child: textForExercise5()
        ),
        Container(
          padding: const EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.pink,
              width: 10
            )
          ),
          child: const Icon(
            Icons.star_border_outlined,
            color: Colors.pink,
          ),
        )
      ],
    );
  }

  Widget textForExercise5() {
    return const Text(
      "Some text",
      style: TextStyle(
        fontSize: 30,
        color: Colors.purple
      )
        Container(color: Colors.blue, padding: const EdgeInsets.all(50), child: const Text("This is home Icon in Container!")),
        Container(color: Colors.red, margin: const EdgeInsets.all(100), child: const Icon(Icons.home)),
      ]
    );
  }
}
