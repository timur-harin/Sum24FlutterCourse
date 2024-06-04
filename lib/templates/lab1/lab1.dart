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
    return Container(
      child: const Text(
        "Hello flutter!",
        style: TextStyle(
          fontSize: 35,
          color: Colors.blue,
          fontWeight: FontWeight.bold,
        ))
    );
  }

  Widget exercise2() {
    return const Icon(
      Icons.home,
      size: 50,
      color: Colors.blue,
    );
  }

  Widget exercise3() {
    return const Image(
      image: NetworkImage('https://images.theconversation.com/files/540430/original/file-20230801-25-3ylj74.jpeg?ixlib=rb-4.1.0&rect=201%2C0%2C3322%2C1661&q=45&auto=format&w=668&h=324&fit=crop'),
      width: 700,
      height: 300,
    );
  }

  Widget exercise4() {
    return TextButton(
        onPressed: () {
          print('Pressed');
        },
        child: const Text('Tap me!'));
  }

  Widget exercise5() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.blue,
              width: 5,
            ),
          ),
          padding: EdgeInsets.all(40),
          margin: EdgeInsets.fromLTRB(12, 10, 12, 20),
          child: const Text("Wonderful Megalodon!",
            style: TextStyle(
                color: Colors.blue,
                fontSize: 45,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.blue,
              width: 5,
            ),
          ),
          padding: EdgeInsets.fromLTRB(10, 15, 10, 30),
          margin: EdgeInsets.all(40),
          child: const Icon(
            Icons.star,
            size: 50,
            color: Colors.blue,
          ),
        )
      ]
    );
  }
}
