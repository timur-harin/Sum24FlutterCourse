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
      'Hello Flutter!',
      style: TextStyle(
        fontSize: 24,
        color: Colors.pink,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget exercise2() {
    return const Icon(
      Icons.access_alarms_sharp,
      size: 50,
      color: Colors.blue,
    );
  }

  Widget exercise3() {
    return Image.network(
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS3Me_vy_UllvFDmxN7bTRpUQMINvJ9uCemPQ&s',
        width: 100,
        height: 100,
        fit: BoxFit.cover);
  }

  void tapped() {
    print('Pressed');
  }

  Widget exercise4() {
    return TextButton(
      onPressed: tapped,
      child: Text('Тык'),
    );
  }

  Widget exercise5() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: const EdgeInsets.all(10.0),
          width: 48.0,
          child: const Text(
            'Hello Flutter!',
            style: TextStyle(
              fontSize: 24,
              color: Colors.pink,
              fontWeight: FontWeight.w500,
            ),
          ),

        ),
        Container(
          margin: const EdgeInsets.all(5.0),
          width: 12.0,
          child: const Icon(
            Icons.abc_sharp,
            size: 100,
            color: Colors.yellow,
          ),
        ),
      ],
    );
  }
}
