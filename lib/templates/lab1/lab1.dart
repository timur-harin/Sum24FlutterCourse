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
      "Hello Flutter!",
      style: TextStyle(
        fontSize: 52,
        color: Colors.redAccent,
        fontWeight: FontWeight.bold
      ),
    );
  }

  Widget exercise2() {
    return const Icon(
      Icons.home,
      size: 52,
      color: Colors.blue,
    );
  }

  Widget exercise3() {
    return Container(
      width: 200,
      height: 200,
      child: Image.network(
      'https://loginportal9999.funnyjunk.com/pictures/Bober_f70283_11166797.jpg',
        fit: BoxFit.cover,
      ),
    );
  }

  Widget exercise4() {
    return TextButton(
      onPressed: () {
        print('Pressed');
      },
      child: Text('Press me'),
    );
  }

  Widget exercise5() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(5),
          padding: EdgeInsets.all(7),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.green, width: 3),
            color: Colors.yellow,
          ),
          child: Text(
            'Hello, World!',
            style: TextStyle(fontSize: 20),
          ),
        ),
        Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 2),
            color: Colors.blue,
          ),
          child: Icon(Icons.abc),
        ),
      ],
    );
  }
}
