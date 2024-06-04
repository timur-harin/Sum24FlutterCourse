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
    return const Text(
      'Hello World!',
      style: TextStyle(
      fontSize: 30,
      color: Color.fromARGB(255, 50, 125, 58),
      fontWeight: FontWeight.bold,
      ),  
    );
  }

  Widget exercise2() {
    return const Icon(Icons.home , size: 90, color: Color.fromARGB(255, 199, 33, 18),);
  }

  Widget exercise3() {
    return Image.network(
      'https://storage.googleapis.com/cms-storage-bucket/acb0587990b4e7890b95.png',
      width: 100,
      height: 60,
      fit: BoxFit.cover,
    );
  }

  Widget exercise4() {
    return TextButton(
    onPressed: () {
      print('Pressed');
    },
    child: const Text('Press me'),
  );
  }

  Widget exercise5() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.blue,
              width: 2,
            ),
          ),
          child: Text(
            'widget',
            style: TextStyle(
              fontSize: 18,
              color: Color.fromARGB(255, 194, 255, 95),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(
              color: Color.fromARGB(255, 223, 75, 179),
              width: 2,
            ),
          ),
          child: Icon(
            Icons.home,
            size: 50,
            color: Color.fromARGB(255, 69, 93, 230),
          ),
        ),
      ],
    );
  }
}
