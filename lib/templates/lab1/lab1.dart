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
    return const Text("Hello Flutter!",
        style: TextStyle(
          fontSize: 90,
          color: Colors.red,
          fontWeight: FontWeight.bold,
        ));
  }

  Widget exercise2() {
    return const Icon(
      Icons.arrow_downward,
      size: 180,
      color: Colors.yellow,
    );
  }

  Widget exercise3() {
    return const Image(
      image: NetworkImage(
          'https://memepedia.ru/wp-content/uploads/2020/12/sasha-iz-univera-memy-3.jpg'),
      width: 50,
      height: 400,
      fit: BoxFit.cover,
    );
  }

  Widget exercise4() {
    return TextButton(
      onPressed: () {
        print("Pressed");
      },
      child: const Text('Button'),
    );
  }

  Widget exercise5() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(5),
          decoration: const BoxDecoration(color: Colors.blue),
          child: const Text('text'),
        ),
        Container(
          padding: const EdgeInsets.all(7),
          margin: const EdgeInsets.all(9),
          decoration: const BoxDecoration(color: Colors.green),
          child: const Icon(
            Icons.home,
            size: 180,
          ),
        ),
      ],
    );
  }
}
