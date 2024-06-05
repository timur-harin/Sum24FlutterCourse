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
      "Hello Flutter!",
      style: TextStyle(
        fontSize: 43,
        color: Color.fromARGB(255, 128, 215, 56),
        fontWeight: FontWeight.normal,
      ),
    );
  }

  Widget exercise2() {
    return const Icon(
      Icons.home,
      size: 43,
      color: Colors.blueGrey,
    );
  }

  Widget exercise3() {
    return Image.network(
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTZeDjxzRrdZi8UQtbEHQdqCrwETxCz5GwMog&s",
      width: 300,
      height: 300,
    );
  }

  Widget exercise4() {
    return TextButton(
      onPressed: () {
        print("Pressed");
      },
        child: Text("Button"),
    );
  }

  Widget exercise5() {
    return Column(
      children: [
        Container(child: Text("Text")),
        Container(child: Icon(Icons.favorite)),
      ],
    );
  }
}
